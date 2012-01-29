//
//  IODOrder.h
//  iOSDiner
//
//  Created by Adam Burkepile on 1/29/12.
//  Copyright (c) 2012 Adam Burkepile. All rights reserved.
//

#import <Foundation/Foundation.h>

@class IODItem;

@interface IODOrder : NSObject

@property (nonatomic,strong) NSMutableDictionary* orderItems;

- (IODItem*)findKeyForOrderItem:(IODItem*)searchItem;

@end
