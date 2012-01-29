//
//  IODItem.h
//  iOSDiner
//
//  Created by Adam Burkepile on 1/29/12.
//  Copyright (c) 2012 Adam Burkepile. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IODItem : NSObject <NSCopying>

@property (nonatomic,strong) NSString* name;
@property (nonatomic,assign) float price;
@property (nonatomic,strong) NSString* pictureFile;

- (id)initWithName:(NSString*)inName andPrice:(float)inPrice andPictureFile:(NSString*)inPictureFile;
+ (NSArray*)retrieveInventoryItems;
@end
