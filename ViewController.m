//
//  ViewController.m
//  WordArt
//
//  Created by Andrew Morgan on 1/22/15.
//  Copyright (c) 2015 Andrew Morgan. All rights reserved.
//

#import "ViewController.h"
#import <CommonCrypto/CommonDigest.h>
#import "ArtViewController.h"

@interface ViewController ()
{
    NSString *generatedHash;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    generatedHash = @"";
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)artButtonPressed:(id)sender {
    generatedHash = [self convertIntoMD5: _wordTextField.text];
    
    [self performSegueWithIdentifier:@"showArt" sender:self];
}

- (NSString *)convertIntoMD5:(NSString *) string{
    const char *cStr = [string UTF8String];
    unsigned char digest[16];
    
    CC_MD5( cStr, (u_int32_t)strlen(cStr), digest ); // This is the md5 call
    
    NSMutableString *resultString = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [resultString appendFormat:@"%02x", digest[i]];
    return  resultString;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Make sure your segue name in storyboard is the same as this line
    if ([[segue identifier] isEqualToString:@"showArt"])
    {
        // Get reference to the destination view controller
        ArtViewController *vc = [segue destinationViewController];
        
        // Pass any objects to the view controller here, like...
        [vc setGeneratedHash:generatedHash];
        [[NSUserDefaults standardUserDefaults] setObject:generatedHash forKey:@"generatedHash"];
        NSLog(@"Hash is %lu", [generatedHash hash]);
    }
}

@end
