//
//  IODOrder.m
//  iOSDiner
//
//  Created by Adam Burkepile on 1/29/12.
//  Copyright (c) 2012 Adam Burkepile. All rights reserved.
//

#import "IODOrder.h"
#import "IODItem.h"

@implementation IODOrder
@synthesize orderItems;

- (IODItem*)findKeyForOrderItem:(IODItem*)searchItem {
    NSIndexSet* indexes = [[[self orderItems] allKeys] indexesOfObjectsPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
        IODItem* key = obj;
        
        return [[searchItem name] isEqualToString:[key name]] && 
        [searchItem price] == [key price];
    }];
    
    if ([indexes count] >= 1) {
        IODItem* key = [[[self orderItems] allKeys] objectAtIndex:[indexes firstIndex]];
        return key;
    }
    
    return nil;
}

@end
