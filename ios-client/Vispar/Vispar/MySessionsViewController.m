//
//  MySessionsViewController.m
//  Vispar
//
//  Created by Howard Wang on 12/11/14.
//  Copyright (c) 2014 Howard Wang. All rights reserved.
//

#import "MySessionsViewController.h"

@interface MySessionsViewController ()

@end

@implementation MySessionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (IBAction)onInviteFriends:(id)sender {
    NSLog(@"----onInviteFriends----");
}

- (IBAction)onStartASession:(id)sender {
    NSLog(@"----onStartASession----");
}

- (IBAction)onViewPastSessions:(id)sender {
    NSLog(@"----onViewPastSessions----");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
