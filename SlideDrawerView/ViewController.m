//
//  ViewController.m
//  SlideDrawerView
//
//  Created by Richard on 2016/1/7.
//  Copyright © 2016年 Richard. All rights reserved.
//

#import "ViewController.h"
#import "SlideDrawerView.h"
#import "UIView+LoadNib.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)viewWillAppear:(BOOL)animated{
    SlideDrawerView *view =[SlideDrawerView loadFromNib];
    [SlideDrawerView presentPopup:view view:self.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
