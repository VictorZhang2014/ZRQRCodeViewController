//
//  ZRTmpViewController.m
//  ZRQRCodeViewController
//
//  Created by Victor Zhang on 7/14/16.
//  Copyright © 2016 XiaoRuiGeGe. All rights reserved.
//

#import "ZRTmpViewController.h"
#import "ZRQRCodeViewController.h"

@interface ZRTmpViewController()

@property (nonatomic, strong) UIImageView *myImgView;

@end

@implementation ZRTmpViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Long-press this picture";

    CGRect rect = self.view.frame;
    CGFloat x = 10;
    CGFloat w = rect.size.width - x * 2;
    CGFloat h = w + 80;
    CGFloat y = (rect.size.height - h) / 2;
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, w, h)];
    [imgView setImage:[UIImage imageNamed:@"ZR_Victor0"]];
    [self.view addSubview:imgView];
    self.myImgView = imgView;
    
    self.view.backgroundColor = [UIColor blackColor];
    
    if (self.type == 1) {
        [self RecognizedByLongPressFromTheIndicatedImage];
    } else {
        [self RecognizedFromTheIndicatedImage];
    }
}

- (void)RecognizedByLongPressFromTheIndicatedImage
{
    ZRQRCodeViewController *qrCode = [[ZRQRCodeViewController alloc] initWithScanType:ZRQRCodeScanTypeReturn];
    qrCode.cancelButton = @"Cancel";
    qrCode.actionSheets = @[];
    qrCode.extractQRCodeText = @"Extract QR Code";
    NSString *savedImageText = @"Save Image";
    qrCode.saveImaegText = savedImageText;
    [qrCode extractQRCodeByLongPressViewController:self Object:self.myImgView actionSheetCompletion:^(int index, NSString * _Nonnull value) {
        if ([value isEqualToString:savedImageText]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Result" message:@"Saved Image Successfully!" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [alert show];
        }
    } completion:^(NSString * _Nonnull strValue) {
        NSLog(@"strValue = %@ ", strValue);
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Result" message:[NSString stringWithFormat:@"Result: %@", strValue] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
        
    } failure:^(NSString *message) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Note" message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
        NSLog(@"Error Message = %@", message);
    }];
}

- (void)RecognizedFromTheIndicatedImage
{
    NSString *result = [[[ZRQRCodeViewController alloc] init] canRecognize:self.myImgView.image];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Result by the picture" message:result delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [alert show];
}

@end
