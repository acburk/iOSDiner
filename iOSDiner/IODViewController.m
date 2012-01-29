//
//  IODViewController.m
//  iOSDiner
//
//  Created by Adam Burkepile on 1/29/12.
//  Copyright (c) 2012 Adam Burkepile. All rights reserved.
//

#import "IODViewController.h"
#import "IODItem.h"     // <---- #1
#import "IODOrder.h"     // <---- #1

@implementation IODViewController
@synthesize ibRemoveItemButton;
@synthesize ibAddItemButton;
@synthesize ibPreviousItemButton;
@synthesize ibNextItemButton;
@synthesize ibTotalOrderButton;
@synthesize ibChalkboardLabel;
@synthesize ibCurrentItemImageView;
@synthesize ibCurrentItemLabel;
@synthesize inventory;     // <---- #2
@synthesize order;     // <---- #2

dispatch_queue_t queue; 

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

-(void)dealloc {
    dispatch_release(queue);
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    currentItemIndex = 0;     // <---- #3
    [self setOrder:[IODOrder new]];     // <---- #4
    
    queue = dispatch_queue_create("com.adamburkepile.queue",nil); // <======
}

- (void)viewDidUnload
{
    [self setIbRemoveItemButton:nil];
    [self setIbAddItemButton:nil];
    [self setIbPreviousItemButton:nil];
    [self setIbNextItemButton:nil];
    [self setIbTotalOrderButton:nil];
    [self setIbChalkboardLabel:nil];
    [self setIbCurrentItemImageView:nil];
    [self setIbCurrentItemLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self updateInventoryButtons]; // <---- Add

    [ibChalkboardLabel setText:@"Loading Inventory..."];
    
    dispatch_async(queue, ^{
        [self setInventory:[[IODItem retrieveInventoryItems] mutableCopy]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self updateOrderBoard]; // <---- Add
            [self updateInventoryButtons]; // <---- Add
            [self updateCurrentInventoryItem]; // <---- Add

            [ibChalkboardLabel setText:@"Inventory Loaded\n\nHow can I help you?"];
        });
    });}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)ibaRemoveItem:(id)sender {
    IODItem* currentItem = [[self inventory] objectAtIndex:currentItemIndex];
    
    [order removeItemFromOrder:currentItem];
    [self updateOrderBoard];
    [self updateCurrentInventoryItem];
    [self updateInventoryButtons];
}

- (IBAction)ibaAddItem:(id)sender {
    IODItem* currentItem = [[self inventory] objectAtIndex:currentItemIndex];
    
    [order addItemToOrder:currentItem];
    [self updateOrderBoard];
    [self updateCurrentInventoryItem];
    [self updateInventoryButtons];
}

- (IBAction)ibaLoadPreviousItem:(id)sender {
    currentItemIndex--;
    [self updateCurrentInventoryItem];
    [self updateInventoryButtons];
}

- (IBAction)ibaLoadNextItem:(id)sender {
    currentItemIndex++;
    [self updateCurrentInventoryItem];
    [self updateInventoryButtons];
}

- (IBAction)ibaCalculateTotal:(id)sender {
}

#pragma mark - Helper Methods

- (void)updateCurrentInventoryItem {
    if (currentItemIndex >= 0 && currentItemIndex < [[self inventory] count]) {
        IODItem* currentItem = [[self inventory] objectAtIndex:currentItemIndex];
        [ibCurrentItemLabel setText:[currentItem name]];
        [ibCurrentItemImageView setImage:[UIImage imageNamed:[currentItem pictureFile]]];
    }
}

- (void)updateInventoryButtons {
    if (![self inventory] || [[self inventory] count] == 0) {
        [ibAddItemButton setEnabled:NO];
        [ibRemoveItemButton setEnabled:NO];
        [ibNextItemButton setEnabled:NO];
        [ibPreviousItemButton setEnabled:NO];
        [ibTotalOrderButton setEnabled:NO];
    }
    else {
        if (currentItemIndex <= 0) {
            [ibPreviousItemButton setEnabled:NO];
        }
        else {
            [ibPreviousItemButton setEnabled:YES];
        }
        
        if (currentItemIndex >= [[self inventory] count]-1) {
            [ibNextItemButton setEnabled:NO];
        }
        else {
            [ibNextItemButton setEnabled:YES];
        }
        
        IODItem* currentItem = [[self inventory] objectAtIndex:currentItemIndex];
        if (currentItem) {
            [ibAddItemButton setEnabled:YES];
        }
        else {
            [ibAddItemButton setEnabled:NO];
        }
        
        if (![[self order] findKeyForOrderItem:currentItem]) {
            [ibRemoveItemButton setEnabled:NO];
        }
        else {
            [ibRemoveItemButton setEnabled:YES];
        }
        
        if ([[order orderItems] count] == 0) {
            [ibTotalOrderButton setEnabled:NO];
        }
        else {
            [ibTotalOrderButton setEnabled:YES];
        }
    }
}

- (void)updateOrderBoard {
    if ([[order orderItems] count] == 0) {
        [ibChalkboardLabel setText:@"No Items. Please order something!"];
    }
    else {
        [ibChalkboardLabel setText:[order orderDescription]];
    }
}
@end
