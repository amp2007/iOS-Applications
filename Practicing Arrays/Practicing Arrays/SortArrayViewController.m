//
//  SortArrayViewController.m
//  Practicing Arrays
//
//  Created by Software Development on 10/16/14.
//  Copyright (c) 2014 ___Allen Perry___. All rights reserved.
//

#import "SortArrayViewController.h"

@interface SortArrayViewController ()

@end

@implementation SortArrayViewController
@synthesize myWebView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

//The website is uploaded to the view when the user has selected to come to this view
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSURL *url = [NSURL URLWithString:@"http://www.youtube.com/watch?v=7cN38y2p4UI"];
    NSURLRequest *requestURL = [NSURLRequest requestWithURL:url];
    [myWebView loadRequest:requestURL];
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
