//
//  ArtViewController.m
//  WordArt
//
//  Created by Andrew Morgan on 1/22/15.
//  Copyright (c) 2015 Andrew Morgan. All rights reserved.
//

#import "ArtViewController.h"
#import "UIArtView.h"

@interface ArtViewController ()

@end

@implementation ArtViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor colorWithRed:0 green:255 blue:0 alpha:.3];
    
    [self.navigationItem setHidesBackButton:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self generateColor];
    
    [self.view setNeedsDisplay];
}

-(void)generateColor
{
    long hash = [_generatedHash hash];
    CGFloat hue = ( hash % 256 / 256.0 ); // 0.0 to 1.0
    CGFloat saturation = ( hash % 128 / 256.0 ) + 0.5; // 0.5 to 1.0, away from white
    CGFloat brightness = ( hash % 128 / 256.0 ) + 0.5; // 0.5 to 1.0, away from black
    UIColor *color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
    self.view.backgroundColor = color;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
