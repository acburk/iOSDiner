//
//  IODItem.m
//  iOSDiner
//
//  Created by Adam Burkepile on 1/29/12.
//  Copyright (c) 2012 Adam Burkepile. All rights reserved.
//

#import "IODItem.h"

@implementation IODItem

@synthesize name;
@synthesize price;
@synthesize pictureFile;

- (id)initWithName:(NSString*)inName andPrice:(float)inPrice andPictureFile:(NSString*)inPictureFile {
    if (self = [self init]) {
        [self setName:inName];
        [self setPrice:inPrice];
        [self setPictureFile:inPictureFile];
    }
    
    return self;
}

-(id)copyWithZone:(NSZone *)zone {
    IODItem* newItem = [IODItem new];
    [newItem setName:[self name]];
    [newItem setPrice:[self price]];
    [newItem setPictureFile:[self pictureFile]];
    
    return newItem;
}

@end
