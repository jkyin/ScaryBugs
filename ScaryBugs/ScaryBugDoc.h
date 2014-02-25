//
//  ScaryBugDoc.h
//  ScaryBugs
//
//  Created by Yin on 14-2-25.
//  Copyright (c) 2014年 Jack Yin. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ScaryBugsData;

@interface ScaryBugDoc : NSObject

@property (nonatomic, strong) ScaryBugsData *data;
@property (nonatomic, strong) UIImage *thumbImage;
@property (nonatomic, strong) UIImage *fullImage;

- (id)initWithTitle:(NSString *)title rating:(float)rating thumbImage:(UIImage *)thumbImage fullImage:(UIImage *)fullImage;
@end
