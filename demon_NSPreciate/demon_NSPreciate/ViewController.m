//
//  ViewController.m
//  demon_NSPreciate
//
//  Created by Bruce on 2017/8/16.
//  Copyright © 2017年 BruceZhu. All rights reserved.
//

#import "ViewController.h"
#import "NSPreciateController.h"
#import "NSSortDescriptorController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    NSPreciateController *vc = [[NSPreciateController alloc] init];
    
    NSSortDescriptorController *vc = [[NSSortDescriptorController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
}

@end
