//
//  SlideDrawerView.m
//  SlideDrawerView
//
//  Created by Richard on 2016/1/7.
//  Copyright © 2016年 Richard. All rights reserved.
//

#import "SlideDrawerView.h"
#import "SUtility.h"
#import "TouchWebView.h"


#define kFSMassageNoticeTag (0xdeadbeef)
#define kAnimationTime 0.8
@interface SlideDrawerView(){
    CGPoint startPoint;
    
}

@property (weak, nonatomic) IBOutlet TouchWebView *webview;

@end

@implementation SlideDrawerView

- (void)awakeFromNib {
    // Pan
    NSURL * url = [NSURL URLWithString:@"https://www.google.com.tw/"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webview loadRequest:request];
    _webview.scrollView.scrollEnabled = NO;
    for (UIView* view in self.subviews) {
        for (UIGestureRecognizer* recognizer in view.gestureRecognizers) {
            [recognizer addTarget:self action:@selector(touchEvent:)];
        }
        for (UIView* sview in view.subviews) {
            for (UIGestureRecognizer* recognizer in sview.gestureRecognizers) {
                [recognizer addTarget:self action:@selector(touchEvent:)];
            }
        }
    }
}

+ (void)presentPopup:(SlideDrawerView *)popup view:(UIView *)view{
    
    popup.tag = kFSMassageNoticeTag;
    
    UIView *topView = view;
    popup.frame = topView.bounds; //---for autosizing---
    [topView addSubview:popup];
    
}

#pragma mark - UITouchEvent
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    //取得觸控點
    CGPoint clickPoint = [[touches anyObject]locationInView:self];
    startPoint = clickPoint;
    
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint point = [[touches anyObject] locationInView:self];
    CGRect newFrame = self.frame;
    newFrame.origin.y = newFrame.origin.y + point.y - startPoint.y;
    [self setFrame:newFrame];
}



-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGFloat changeDistance = self.frame.origin.y;
    NSLog(@"%f",changeDistance);
    [self viewMoveDistance:changeDistance];
}

-(void)viewMoveDistance:(CGFloat)distance{
    CGRect newFrame = self.frame;
    CGFloat scale = distance / CGRectGetHeight(newFrame);
    if (distance >= self.frame.size.height / 3) {
        newFrame.origin.y = newFrame.size.height;
    }else{
        newFrame.origin.y = 0;
    }
    
    [UIView animateWithDuration:kAnimationTime * scale
                          delay:0.0
                        options: UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         [self setFrame:newFrame];
                     }
                     completion:^(BOOL finished){
                         
                     }];

}

-(void)touchEvent:(UIGestureRecognizer *)a{
    NSLog(@"%@",a);
}


@end
