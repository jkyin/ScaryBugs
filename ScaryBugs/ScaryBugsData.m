//
//  ScaryBugsData.m
//  ScaryBugs
//
//  Created by Yin on 14-2-25.
//  Copyright (c) 2014年 Jack Yin. All rights reserved.
//

#import "ScaryBugsData.h"

@implementation ScaryBugsData

@synthesize title = _title;
@synthesize rating = _rating;

- (id)initWithTitle:(NSString *)title rating:(float)rating
{
    self = [super init];
    if (self) {
        self.title = title;
        self.rating = rating;
    }
    return self;
}

@end
