//
//  OptionsButton.h
//  testButton
//
//  Created by Kenton on 2015/12/7.
//  Copyright © 2015年 Kenton. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OptionsButtonDelegate;

typedef NS_ENUM(NSUInteger, OptionsButtonLocation) {
    OptionsButtonLocationTop,
    OptionsButtonLocationUpperLeft,
    OptionsButtonLocationLeft
};

typedef NS_ENUM(NSUInteger, ManyOptionsButtonState) {
    ManyOptionsButtonStateOpen,    /// The state for when all of the buttons on the view are showing.
    ManyOptionsButtonStateClosed,  /// The state for when only the center button is showing.
};

@interface OptionsButton : UIControl

@property (strong, nonatomic) UIImage *leftButtonImage,
                                      *upperLeftButtonImage,
                                      *topButtonImage;
@property (strong, nonatomic) UIImage *centerButtonImage;
@property (strong, nonatomic) UIImage *centerCollapseButtonImage;
@property (strong, nonatomic) UIImage *deviceCountImage;

@property (nonatomic) ManyOptionsButtonState currentManyOptionsButtonState;
@property (weak, nonatomic) id<OptionsButtonDelegate> delegate;


- (instancetype)initWithFrame:(CGRect)frame
            centerButtonImage:(UIImage *)centerButtonImage
    centerCollapseButtonImage:(UIImage *)centerCollapseButtonImage
              leftButtonImage:(UIImage *)leftButtonImage
         upperLeftButtonImage:(UIImage *)upperLeftButtonImage
               topButtonImage:(UIImage *)topButtonImage
             deviceCountImage:(UIImage *)deviceCountImage
                  clientCount:(NSInteger)clientCount;

- (instancetype)initWithCenterButtonImage:(UIImage *)centerButtonImage
                centerCollapseButtonImage:(UIImage *)centerCollapseButtonImage
                          leftButtonImage:(UIImage *)leftButtonImage
                     upperLeftButtonImage:(UIImage *)upperLeftButtonImage
                           topButtonImage:(UIImage *)topButtonImage
                         deviceCountImage:(UIImage *)deviceCountImage
                              clientCount:(NSInteger)clientCount;

@end

@protocol OptionsButtonDelegate <NSObject>

- (void)manyOptionsButton:(OptionsButton *)button didSelectButtonAtLocation:(OptionsButtonLocation)location;

@end
