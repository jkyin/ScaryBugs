//
//  ScaryBugsData.h
//  ScaryBugs
//
//  Created by Yin on 14-2-25.
//  Copyright (c) 2014年 Jack Yin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScaryBugsData : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) float rating;

- (id)initWithTitle:(NSString *)title rating:(float)rating;

@end
