//
//  DetailViewController.h
//  ScaryBugs
//
//  Created by Yin on 14-2-25.
//  Copyright (c) 2014年 Jack Yin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
