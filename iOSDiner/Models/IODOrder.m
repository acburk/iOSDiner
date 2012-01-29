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

- (NSMutableDictionary *)orderItems{
    if (!orderItems) {
        orderItems = [NSMutableDictionary new];
    }
    
    return orderItems;
}

- (NSString*)orderDescription {
    NSMutableString* orderDescription = [NSMutableString new];
    
    NSArray* keys = [[[self orderItems] allKeys] sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        IODItem* item1 = (IODItem*)obj1;
        IODItem* item2 = (IODItem*)obj2;
        
        return [[item1 name] compare:[item2 name]];
    }];
    
    [keys enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        IODItem* item = (IODItem*)obj;
        NSNumber* quantity = (NSNumber*)[[self orderItems] objectForKey:item];
        
        [orderDescription appendFormat:@"%@ x%@\n",[item name],quantity];
    }];
    
    return [orderDescription copy];
}
@end
