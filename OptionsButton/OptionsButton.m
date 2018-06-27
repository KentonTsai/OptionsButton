//
//  OptionsButton.m
//  testButton
//
//  Created by Kenton on 2015/12/7.
//  Copyright © 2015年 Kenton. All rights reserved.
//

#import "OptionsButton.h"

@interface OptionsButton ()

#pragma mark Private Properties
@property (strong, nonatomic) UIImageView *centerButtonImageView;
@property (strong, nonatomic) UIImageView *leftButtonImageView,
                                          *upperLeftButtonImageView,
                                          *topButtonImageView;
@property (strong, nonatomic) UIImageView *deviceCountImageView;

@property (readonly, nonatomic) CGRect openBounds;
@property (readonly, nonatomic) CGRect closedBounds;

- (void)commonInitWithClientCount:(NSInteger)clientCount;
- (void)openMultiSelectMode;
- (void)closeMultiSelectMode;
@end


@implementation OptionsButton

#pragma mark Constants

#define BUTTON_RADIUS ((BUTTON_DIAMETER * 1.0) / 2)
#define CENTER_DIAMETER 67
#define BUTTON_DIAMETER 57
#define DEVICE_COUNT_DIAMETER 20
#define OPEN_SIZE_HEIGHT 150
#define TIME_TO_OPEN_AND_CLOSE_VIEW 0.5
#define HEIGHT_LOCATION 48
#define WIDTH_LOCATION 40
- (instancetype)initWithFrame:(CGRect)frame
            centerButtonImage:(UIImage *)centerButtonImage
    centerCollapseButtonImage:(UIImage *)centerCollapseButtonImage
              leftButtonImage:(UIImage *)leftButtonImage
         upperLeftButtonImage:(UIImage *)upperLeftButtonImage
               topButtonImage:(UIImage *)topButtonImage
             deviceCountImage:(UIImage *)deviceCountImage
                  clientCount:(NSInteger)clientCount
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self commonInitWithClientCount:clientCount];
        self.leftButtonImage = leftButtonImage;
        self.upperLeftButtonImage = upperLeftButtonImage;
        self.topButtonImage = topButtonImage;
        self.centerButtonImage = centerButtonImage;
        self.centerCollapseButtonImage = centerCollapseButtonImage;
        self.deviceCountImage = deviceCountImage;
    }
    return self;
}

- (instancetype)initWithCenterButtonImage:(UIImage *)centerButtonImage
                centerCollapseButtonImage:(UIImage *)centerCollapseButtonImage
                          leftButtonImage:(UIImage *)leftButtonImage
                     upperLeftButtonImage:(UIImage *)upperLeftButtonImage
                           topButtonImage:(UIImage *)topButtonImage
                         deviceCountImage:(UIImage *)deviceCountImage
                              clientCount:(NSInteger)clientCount
{
    CGRect frame = self.frame;
//    frame.size = CGSizeMake(BUTTON_DIAMETER, BUTTON_DIAMETER);
    self = [self initWithFrame:frame
             centerButtonImage:centerButtonImage
            centerCollapseButtonImage:centerCollapseButtonImage
               leftButtonImage:leftButtonImage
          upperLeftButtonImage:upperLeftButtonImage
                topButtonImage:topButtonImage
              deviceCountImage:deviceCountImage
                   clientCount:clientCount];
//    [self drawRect:self.bounds];
    return self;
}

- (void)commonInitWithClientCount:(NSInteger)clientCount
{
    self.currentManyOptionsButtonState = ManyOptionsButtonStateClosed;
    
    //  initialize all of the image views
    self.leftButtonImageView       = [UIImageView new];
    self.upperLeftButtonImageView  = [UIImageView new];
    self.topButtonImageView        = [UIImageView new];
    self.centerButtonImageView     = [UIImageView new];
    self.deviceCountImageView      = [UIImageView new];
    
    // set the size of each of the image view rectangles
    CGRect bounds = CGRectMake(0, 0, BUTTON_DIAMETER, BUTTON_DIAMETER);
    self.leftButtonImageView.bounds       = bounds;
    self.upperLeftButtonImageView.bounds  = bounds;
    self.topButtonImageView.bounds        = bounds;
    CGRect centerBound = CGRectMake(0, 0, CENTER_DIAMETER, CENTER_DIAMETER);
    self.centerButtonImageView.bounds     = centerBound;
    CGRect bound = CGRectMake(0, 0, DEVICE_COUNT_DIAMETER, DEVICE_COUNT_DIAMETER);
    self.deviceCountImageView.bounds      = bound;
    UILabel *label = [[UILabel alloc] initWithFrame:bound];
    label.text = [NSString stringWithFormat:@"%d", (int)clientCount];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:14];
    [self.deviceCountImageView addSubview:label];
    
    // set the centers for each of the image view rectangles
    CGPoint center = CGPointMake(0, 0);
    self.leftButtonImageView.center       = center;
    self.upperLeftButtonImageView.center  = center;
    self.topButtonImageView.center        = center;
    self.centerButtonImageView.center     = center;
    self.deviceCountImageView.center      = center;
    
    // set the view so it only shows what is visible
//    self.clipsToBounds       = YES;
//    self.layer.masksToBounds = YES;
    
    // set the bounds to be the correct bounds for when the button is closed
    self.bounds = self.closedBounds;
    
    // set all of the extra images to have an alpha of 0
    self.leftButtonImageView.alpha       = 0;
    self.upperLeftButtonImageView.alpha  = 0;
    self.topButtonImageView.alpha        = 0;
    self.deviceCountImageView.alpha      = 0;
    
    self.backgroundColor = [UIColor clearColor];
    
    // set the center button to be .75 smaller than usual
//    self.transform  = CGAffineTransformMakeScale(.8, .8);
}

#pragma mark Selectors
- (void)openMultiSelectMode
{
    if (self.currentManyOptionsButtonState != ManyOptionsButtonStateOpen) {
        
        // get the coordinates to move the extra views to
        int offset = BUTTON_RADIUS - OPEN_SIZE_HEIGHT;
        CGPoint centerForTopImage        = CGPointMake(-WIDTH_LOCATION      , offset - HEIGHT_LOCATION );
        CGPoint centerForLeftImage       = CGPointMake(offset-WIDTH_LOCATION , -HEIGHT_LOCATION);
        CGPoint centerForUpperLeftImage  = CGPointMake(offset*cos(45*M_PI/180)-WIDTH_LOCATION , offset*sin(45*M_PI/180)-HEIGHT_LOCATION);
        CGPoint centerForCenterImage     = CGPointMake(-WIDTH_LOCATION      , -HEIGHT_LOCATION      );
        offset = offset - 25;
        CGPoint centerForDeviceCountImage= CGPointMake(offset*cos(45*M_PI/180)-WIDTH_LOCATION , offset*sin(45*M_PI/180)-HEIGHT_LOCATION);
        
        
        // animate the opening of the view
        [UIView animateWithDuration:TIME_TO_OPEN_AND_CLOSE_VIEW
                         animations:^{
                             // create the new bounds
                             self.bounds = self.openBounds;
                             
                             // animate each of the extra views to their new location
                             self.leftButtonImageView.center       = centerForLeftImage;
                             self.upperLeftButtonImageView.center  = centerForUpperLeftImage;
                             self.topButtonImageView.center        = centerForTopImage;
                             self.centerButtonImageView.center     = centerForCenterImage;
                             self.centerButtonImageView.image      = self.centerCollapseButtonImage;
                             self.deviceCountImageView.center      = centerForDeviceCountImage;
                             
                             // make all of the buttons full alpha values
                             self.topButtonImageView.alpha        = 1;
                             self.leftButtonImageView.alpha       = 1;
                             self.upperLeftButtonImageView.alpha  = 1;
                             self.deviceCountImageView.alpha      = 1;
                             
                             // set the background circle to have a full opcaity as well
//                             self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
                            
                             UIGraphicsBeginImageContext([UIScreen mainScreen].bounds.size);
                             [[UIImage imageNamed:@"bg_shortcut_mask"] drawInRect:[UIScreen mainScreen].bounds];

                             UIImage *bgImage = UIGraphicsGetImageFromCurrentImageContext();
                             UIGraphicsEndImageContext();
                             self.backgroundColor = [UIColor colorWithPatternImage:bgImage];
                         }
                         completion:nil];
        // set the current state of the view to be open
        self.currentManyOptionsButtonState = ManyOptionsButtonStateOpen;
    }
    
}

- (void)closeMultiSelectMode
{
    if (self.currentManyOptionsButtonState != ManyOptionsButtonStateClosed) {
        
        // get the center to move everything back to
        CGPoint center = CGPointMake(0, 0);
        
        // animate everythign to close
        [UIView animateWithDuration:TIME_TO_OPEN_AND_CLOSE_VIEW
                         animations:^{
                             // put the bounds to be the closed bounds
                             self.bounds = self.closedBounds;
                            
                             // move all of the extra views back to the center
                             self.leftButtonImageView.center       = center;
                             self.upperLeftButtonImageView.center  = center;
                             self.topButtonImageView.center        = center;
                             self.centerButtonImageView.center     = center;
                             self.centerButtonImageView.image      = self.centerButtonImage;
                             self.deviceCountImageView.center      = center;
                             
                             // make all the buttons 0 alpha values
                             self.topButtonImageView.alpha        = 0;
                             self.leftButtonImageView.alpha       = 0;
                             self.upperLeftButtonImageView.alpha  = 0;
                             self.deviceCountImageView.alpha      = 0;
                         }
                         completion:^(BOOL finished) {
                             if (finished) {
                                 // set the background circle to have no opacity
                                 self.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
                                 
                                 // set all of the images back to normal
                                 self.topButtonImageView.image        = self.topButtonImage;
                                 self.upperLeftButtonImageView.image  = self.upperLeftButtonImage;
                                 self.leftButtonImageView.image       = self.leftButtonImage;
                                 self.deviceCountImageView.image      = self.deviceCountImage;
                             }
                         }];
        // set the current state of the view to be closed
        self.currentManyOptionsButtonState = ManyOptionsButtonStateClosed;
    }
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    [self addSubview:self.leftButtonImageView];
    [self addSubview:self.upperLeftButtonImageView];
    [self addSubview:self.topButtonImageView];
    [self addSubview:self.centerButtonImageView];
    [self addSubview:self.deviceCountImageView];
}

#pragma mark Getters
- (CGRect)openBounds
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    return CGRectMake(-width, -height, width * 2, height * 2);
}

- (CGRect)closedBounds
{
    return CGRectMake(-BUTTON_RADIUS, -BUTTON_RADIUS, BUTTON_DIAMETER+80, BUTTON_DIAMETER+96);
}

#pragma mark Setters
- (void)setLeftButtonImage:(UIImage *)leftButtonImage
{
    _leftButtonImage = leftButtonImage;
    self.leftButtonImageView.image = leftButtonImage;
}

- (void)setUpperLeftButtonImage:(UIImage *)upperLeftButtonImage
{
    _upperLeftButtonImage = upperLeftButtonImage;
    self.upperLeftButtonImageView.image = upperLeftButtonImage;
}

- (void)setTopButtonImage:(UIImage *)topButtonImage
{
    _topButtonImage = topButtonImage;
    self.topButtonImageView.image = topButtonImage;
}

- (void)setCenterButtonImage:(UIImage *)centerButtonImage
{
    _centerButtonImage = centerButtonImage;
    self.centerButtonImageView.image = centerButtonImage;
}

- (void)setDeviceCountImage:(UIImage *)deviceCountImage
{
    _deviceCountImage = deviceCountImage;
    self.deviceCountImageView.image = deviceCountImage;
}

#pragma mark UIControlDelegate
- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint touchPoint = [touch locationInView:self];
    
    // if it is closed and we jsut started the touch, we need to open the controller
    if (self.currentManyOptionsButtonState == ManyOptionsButtonStateClosed) {
        [self openMultiSelectMode];

    } else {
        if (CGRectContainsPoint(self.topButtonImageView.frame, touchPoint)) {
            [self topButtonSelected:self];
        } else if (CGRectContainsPoint(self.upperLeftButtonImageView.frame, touchPoint)) {
            [self upperLeftButtonSelected:self];
        } else if (CGRectContainsPoint(self.leftButtonImageView.frame, touchPoint)) {
            [self leftButtonSelected:self];
        }
        [self closeMultiSelectMode];
    }
    return YES;
}

- (void)topButtonSelected:(id)sender
{
    if (self.delegate && self.topButtonImage) {
        [self.delegate manyOptionsButton:self didSelectButtonAtLocation:OptionsButtonLocationTop];
    }
}

- (void)upperLeftButtonSelected:(id)sender
{
    if (self.delegate && self.upperLeftButtonImage) {
        [self.delegate manyOptionsButton:self didSelectButtonAtLocation:OptionsButtonLocationUpperLeft];
    }
}

- (void)leftButtonSelected:(id)sender
{
    if (self.delegate && self.leftButtonImage) {
        [self.delegate manyOptionsButton:self didSelectButtonAtLocation:OptionsButtonLocationLeft];
    }
}

@end
