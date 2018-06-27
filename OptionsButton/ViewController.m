//
//  ViewController.m
//  OptionsButton
//
//  Created by Kenton on 27/06/2018.
//  Copyright © 2018 com.kenton. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

static OptionsButton *optbutton;

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self addOptionsButton];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - many options button
- (void) addOptionsButton{
    UIImage *center      = [UIImage imageNamed:@"btn_shortcut_expand_n"];
    UIImage *cenCollpase = [UIImage imageNamed:@"btn_shortcut_collapse_n"];
    UIImage *left        = [UIImage imageNamed:@"shortcut_settings_n"];
    UIImage *top         = [UIImage imageNamed:@"shortcut_zap_n"];
    UIImage *upperLeft   = [UIImage imageNamed:@"shortcut_devices_list_n"];
    UIImage *deviceCount = [UIImage imageNamed:@"ico_notification_num"];
    
    
//    [optbutton removeFromSuperview];
    optbutton = [[OptionsButton alloc] initWithCenterButtonImage:center
                                       centerCollapseButtonImage:cenCollpase
                                                 leftButtonImage:left
                                            upperLeftButtonImage:upperLeft
                                                  topButtonImage:top
                                                deviceCountImage:deviceCount
                                                     clientCount:5];
    optbutton.delegate = self;
    
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    if (screenSize.height == 812.f) {
        NSLog(@"This is iPhone X");
        optbutton.center = CGPointMake([UIScreen mainScreen].bounds.size.width, screenSize.height - 62 - 44);
    } else {
        optbutton.center = CGPointMake([UIScreen mainScreen].bounds.size.width, screenSize.height - 62);
    }
    
    [self.view addSubview:optbutton];
    
}

#pragma mark OptionsButtonDelegate
- (void)manyOptionsButton:(OptionsButton *)button didSelectButtonAtLocation:(OptionsButtonLocation)location
{
    switch (location) {
        case OptionsButtonLocationTop:
            NSLog(@"OptionsButtonLocationTop");

            break;
        case OptionsButtonLocationUpperLeft:
            NSLog(@"OptionsButtonLocationUpperLeft");

            break;
        case OptionsButtonLocationLeft:
            NSLog(@"OptionsButtonLocationLeft");

            break;
        default:
            break;
    }
}

@end
