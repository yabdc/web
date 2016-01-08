//
//  TouchWebView.m
//  SlideDrawerView
//
//  Created by Richard on 2016/1/7.
//  Copyright © 2016年 Richard. All rights reserved.
//

//http://blog.csdn.net/xyxjn/article/details/43524787
#import "TouchWebView.h"
#if TARGET_IPHONE_SIMULATOR
#import <objc/objc-runtime.h>
#else
#import <objc/runtime.h>
#endif

const char* kUIWebDocumentView= "UIWebDocumentView";

@interface NSObject (TouchWebViewDelegate)
- (void)touchesBegan:(NSSet*)touches inWebView:(UIWebView*)sender withEvent:(UIEvent*)event;
- (void)touchesMoved:(NSSet*)touches inWebView:(UIWebView*)sender withEvent:(UIEvent*)event;
- (void)touchesEnded:(NSSet*)touches inWebView:(UIWebView*)sender withEvent:(UIEvent*)event;
- (void)touchesCancelled:(NSSet*)touches inWebView:(UIWebView*)sender withEvent:(UIEvent*)event;
@end

@interface TouchWebView (private)
- (void)hookedTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)hookedTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)hookedTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)hookedTouchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event;
@end

@implementation UIView (TapHook)

- (void)replacedTouchesBegan:(NSSet*)touches withEvent:(UIEvent*)event {
//    [self replacedTouchesBegan:touches withEvent:event];		// call @selector(touchesBegan:withEvent:)
    if( [self.superview.superview isMemberOfClass:[TouchWebView class]] ) {
        [(TouchWebView*)self.superview.superview hookedTouchesBegan:touches withEvent:event];
    }
}
- (void)replacedTouchesMoved:(NSSet*)touches withEvent:(UIEvent*)event {
    [self replacedTouchesMoved:touches withEvent:event];		// call @selector(touchesMoved:withEvent:)
    if( [self.superview.superview isMemberOfClass:[TouchWebView class]] ) {
        [(TouchWebView*)self.superview.superview hookedTouchesMoved:touches withEvent:event];
    }
}

- (void)replacedTouchesEnded:(NSSet*)touches withEvent:(UIEvent*)event {
    [self replacedTouchesEnded:touches withEvent:event];		// call @selector(touchesEnded:withEvent:)
    if( [self.superview.superview isMemberOfClass:[TouchWebView class]] ) {
        [(TouchWebView*)self.superview.superview hookedTouchesEnded:touches withEvent:event];
    }
}

- (void)replacedTouchesCancelled:(NSSet*)touches withEvent:(UIEvent*)event {
    [self replacedTouchesCancelled:touches withEvent:event];	// call @selector(touchesCancelled:withEvent:)
    if( [self.superview.superview isMemberOfClass:[TouchWebView class]] ) {
        [(TouchWebView*)self.superview.superview hookedTouchesCancelled:touches withEvent:event];
    }
}

@end

static BOOL isAlreaddHookInstalled = NO;

@implementation TouchWebView

#pragma mark Class method setup hookmethod for UIWebDocumentView

+ (void)installHook {
    if( isAlreaddHookInstalled )
        return;
    isAlreaddHookInstalled = YES;
    
    Class klass = objc_getClass( kUIWebDocumentView );
    
    if( klass == nil )
        return;		// if there is no UIWebDocumentView in the future.
    
    // replace touch began event
    method_exchangeImplementations(
                                   class_getInstanceMethod(klass, @selector(touchesBegan:withEvent:)),
                                   class_getInstanceMethod(klass, @selector(replacedTouchesBegan:withEvent:)) );
    
    // replace touch moved event
    method_exchangeImplementations(
                                   class_getInstanceMethod(klass, @selector(touchesMoved:withEvent:)),
                                   class_getInstanceMethod(klass, @selector(replacedTouchesMoved:withEvent:))
                                   );
    
    // replace touch ended event
    method_exchangeImplementations(
                                   class_getInstanceMethod(klass, @selector(touchesEnded:withEvent:)),
                                   class_getInstanceMethod(klass, @selector(replacedTouchesEnded:withEvent:))
                                   );
    
    // replace touch cancelled event
    method_exchangeImplementations(
                                   class_getInstanceMethod(klass, @selector(touchesCancelled:withEvent:)),
                                   class_getInstanceMethod(klass, @selector(replacedTouchesCancelled:withEvent:))
                                   );
}

#pragma mark Original method for call delegate method

- (void)hookedTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if( [self.delegate respondsToSelector:@selector(touchesBegan:inWebView:withEvent:)] )
        [(NSObject*)self.delegate touchesBegan:touches inWebView:self withEvent:event];
}

- (void)hookedTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    if( [self.delegate respondsToSelector:@selector(touchesMoved:inWebView:withEvent:)] )
        [(NSObject*)self.delegate touchesMoved:touches inWebView:self withEvent:event];
}

- (void)hookedTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if( [self.delegate respondsToSelector:@selector(touchesEnded:inWebView:withEvent:)] )
        [(NSObject*)self.delegate touchesEnded:touches inWebView:self withEvent:event];
}

- (void)hookedTouchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    if( [self.delegate respondsToSelector:@selector(touchesCancelled:inWebView:withEvent:)] )
        [(NSObject*)self.delegate touchesCancelled:touches inWebView:self withEvent:event];
}

#pragma mark override

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [TouchWebView installHook];
    }
    return self;
}

- (id)initWithCoder:(NSCoder*)coder {
    if (self = [super initWithCoder:coder]) {
        [TouchWebView installHook];
    }
    return self;
}

@end
