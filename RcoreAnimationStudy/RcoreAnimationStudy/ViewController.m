//
//  ViewController.m
//  RcoreAnimationStudy
//
//  Created by 任前辈 on 15-5-18.
//  Copyright (c) 2015年 Renqianbei. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *layerView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage * image = [UIImage imageNamed:@"testImg"];
    self.layerView.layer.contents  = (__bridge id)([image CGImage]) ;
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
