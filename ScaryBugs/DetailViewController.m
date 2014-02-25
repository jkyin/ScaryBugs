//
//  DetailViewController.m
//  ScaryBugs
//
//  Created by Yin on 14-2-25.
//  Copyright (c) 2014年 Jack Yin. All rights reserved.
//

#import "DetailViewController.h"
#import "ScaryBugDoc.h"
#import "ScaryBugsData.h"
#import "UIImageExtras.h"
#import <SVProgressHUD/SVProgressHUD.h>

@interface DetailViewController ()
- (void)configureView;
@end

@implementation DetailViewController

@synthesize picker = _picker;

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    self.rateView.notSelectedImage = [UIImage imageNamed:@"shockedface2_empty.png"];
    self.rateView.halfSelectedImage = [UIImage imageNamed:@"shockedface2_half.png"];
    self.rateView.fullSelectedImage = [UIImage imageNamed:@"shockedface2_full.png"];
    self.rateView.editable = YES;
    self.rateView.maxRating = 5;
    self.rateView.delegate = self;
    
    if (self.detailItem) {
        self.titleField.text = self.detailItem.data.title;
        self.rateView.rating = self.detailItem.data.rating;
        self.imageView.image = self.detailItem.fullImage;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}


- (IBAction)addPictureTapped:(id)sender {
    if (self.picker == nil) {
        // 显示状态
        [SVProgressHUD showWithStatus:@"Loading picker..."];
        
        // 从系统中获取一个并行队列
        dispatch_queue_t concurrentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        
        // 在后台线程创造图像选择器
        dispatch_async(concurrentQueue, ^{
        
        self.picker = [[UIImagePickerController alloc] init];
        self.picker.delegate = self;
        self.picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        self.picker.allowsEditing = NO;
        
        // 在主线程中显示那个图像选择器
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.navigationController presentModalViewController:_picker animated:YES];
                [SVProgressHUD dismiss];
            });
        });
    } else {
        [self.navigationController presentModalViewController:_picker animated:YES];
    }
}

#pragma mark UIImagePickerControllerDelegate

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissModalViewControllerAnimated:YES];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    [self dismissModalViewControllerAnimated:YES];
    
    UIImage *fullImage = (UIImage *) [info objectForKey:UIImagePickerControllerOriginalImage];
    
    // 显示状态
    [SVProgressHUD showWithStatus:@"Resizing image..."];
    
    // 从系统获取一个并行队列
    dispatch_queue_t concurrentQueue =
    dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    // 在后台完成修改图片大小的运算
    dispatch_async(concurrentQueue, ^{
        
        UIImage *thumbImage = [fullImage imageByScalingAndCroppingForSize:CGSizeMake(44, 44)];
        
        // 在主线程显示图片
        dispatch_async(dispatch_get_main_queue(), ^{
            self.detailItem.fullImage = fullImage;
            self.detailItem.thumbImage = thumbImage;
            self.imageView.image = fullImage;
            [SVProgressHUD dismiss];
        });
        
    });
}

- (IBAction)titleFieldTextChanged:(id)sender {
    self.detailItem.data.title = self.titleField.text;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - RateViewDelegate

- (void)rateView:(RateView *)rateView ratingDidChange:(float)rating
{
    self.detailItem.data.rating = rating;
}



@end
