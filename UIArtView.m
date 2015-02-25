//
//  UIArtView.m
//  WordArt
//
//  Created by Andrew Morgan on 2/2/15.
//  Copyright (c) 2015 Andrew Morgan. All rights reserved.
//

#import "UIArtView.h"
#import <CommonCrypto/CommonDigest.h>

#define degreesToRadians(x) (M_PI * x / 180.0)

@implementation UIArtView {
    int hashNumber;
    int rotationMultiplier;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

- (void)drawRect:(CGRect)rect
{
    NSString *s1 = @"a78465aebbe48acf4884f32a0d2d59b2", *s2 = @"bd61f3cf0e0e4010f665ba3035dc258a", *s3 = @"21f63c6e971cd913a9c147e8652ca659";
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    for (int i = 0; i < [self convertObjectIntWithRange:100 andString:[[NSUserDefaults standardUserDefaults] objectForKey:@"generatedHash"]]; i++) {
        [self drawSquiggles:50*i commonX:20*i];
    }
    [self drawAndCloneLinesInContext:context];
    
    /*
    [path2 setLineWidth:3.0];
    [path2 moveToPoint:point2];
    [path2 addCurveToPoint:point3 controlPoint1:controlPoint3 controlPoint2:controlPoint4];
    [lineColor set];
    [path2 stroke];*/
    
    // Choose whether to flip the view or not
    if ([self convertObjectIntWithRange:256 andString:[[NSUserDefaults standardUserDefaults] objectForKey:@"generatedHash"]] > 120) {
        self.transform = CGAffineTransformMakeScale(-1.0, 1.0);
    } else {
        self.transform = CGAffineTransformMakeScale(1.0, -1.0);
    }
    
    NSLog(@"MD5 is %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"generatedHash"]);
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"generatedHash"] isEqualToString:s1]) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.frame];
        imageView.image = [UIImage imageNamed:@"s1.png"];
        [self addSubview:imageView];
    } else if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"generatedHash"] isEqualToString:s2]) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.frame];
        imageView.image = [UIImage imageNamed:@"s2.png"];
        [self addSubview:imageView];
    } else if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"generatedHash"] isEqualToString:s3]) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.frame];
        imageView.image = [UIImage imageNamed:@"s3.png"];
        [self addSubview:imageView];
    }
    
    hashNumber = [self convertObjectIntWithRange:10 andString:[[NSUserDefaults standardUserDefaults] objectForKey:@"generatedHash"]];
    rotationMultiplier = (hashNumber % 10) * 8;
}

-(void)drawSquiggles:(int)commonY commonX:(int)commonX {
    
    CGPoint point1 = CGPointMake(self.frame.size.width/2,self.frame.size.height/2);
    CGPoint point2 = CGPointMake(commonX, commonY);
    CGPoint point3 = CGPointMake(-200, 50);
    CGPoint controlPoint1 = CGPointMake(50, 60);
    CGPoint controlPoint2 = CGPointMake(commonX*2, commonY);
    CGPoint controlPoint3 = CGPointMake(200*hashNumber, commonY * hashNumber);
    CGPoint controlPoint4 = CGPointMake(commonX*4, 75);
    
    UIBezierPath *path1 = [UIBezierPath bezierPath];
    
    UIColor *lineColor = [self convertCurrentTimeToColor]; // Change to invert bg color eventually
    
    [path1 setLineWidth:3.0];
    [path1 moveToPoint:[self rotatePointWithPoint:point1 andDegrees:rotationMultiplier]];
    [path1 addCurveToPoint:[self rotatePointWithPoint:point2 andDegrees:rotationMultiplier] controlPoint1:[self rotatePointWithPoint:controlPoint1 andDegrees:rotationMultiplier] controlPoint2:[self rotatePointWithPoint:controlPoint2 andDegrees:rotationMultiplier]];
    [path1 addCurveToPoint:[self rotatePointWithPoint:point3 andDegrees:rotationMultiplier] controlPoint1:[self rotatePointWithPoint:controlPoint3 andDegrees:rotationMultiplier] controlPoint2:[self rotatePointWithPoint:controlPoint4 andDegrees:rotationMultiplier]];
    [lineColor set];
    [path1 stroke];
}

-(CGPoint)rotatePointWithPoint:(CGPoint)initialPoint andDegrees:(CGFloat) angle
{
    return CGPointApplyAffineTransform(initialPoint, CGAffineTransformMakeRotation(angle));
}

-(void)drawAndCloneLinesInContext:(CGContextRef)context
{
    for (int i = 0; i < [self convertObjectIntWithRange:100 andString:[[NSUserDefaults standardUserDefaults] objectForKey:@"generatedHash"]] + 5; i+=6) {
        [self drawPetalInRect:CGRectMake(125, 230+2i, 9*i, 14*i) inDegrees:0+i inContext:context];
        [self drawPetalInRect:CGRectMake(115, 236+2i, 10*i, 12*i) inDegrees:300+i inContext:context];
        [self drawPetalInRect:CGRectMake(120, 246+2i, 9*i, 14*i) inDegrees:5+i inContext:context];
        [self drawPetalInRect:CGRectMake(128, 246+2i, 9*i, 14*i) inDegrees:350+i inContext:context];
        [self drawPetalInRect:CGRectMake(133, 236+2i, 11*i, 14*i) inDegrees:80+i inContext:context];
    }
}

-(void) drawPetalInRect: (CGRect) rect inDegrees: (NSInteger) degrees inContext: (CGContextRef) context
{
    int transformInt = [self convertObjectIntWithRange:400 andString:[[NSUserDefaults standardUserDefaults] objectForKey:@"generatedHash"]];
    CGContextSaveGState(context);
    CGMutablePathRef flowerPetal = CGPathCreateMutable();
    float midX = CGRectGetMidX(rect);
    float midY = CGRectGetMidY(rect);
    CGAffineTransform transfrom =
    CGAffineTransformConcat(
                            CGAffineTransformConcat(CGAffineTransformMakeTranslation(-midX-transformInt, -midY-transformInt),CGAffineTransformMakeRotation(degreesToRadians(degrees))),
                            CGAffineTransformMakeTranslation(midX+80, midY+80));
    
    CGPathAddEllipseInRect(flowerPetal, &transfrom, rect);
    CGContextAddPath(context, flowerPetal);
    CGContextSetStrokeColorWithColor(context, [self convertCurrentTimeToColor].CGColor);
    CGContextStrokePath(context);
    //CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    CGContextAddPath(context, flowerPetal);
    //CGContextFillPath(context);
    
    CGPathRelease(flowerPetal);
    CGContextRestoreGState(context);
}

-(UIColor*)convertCurrentTimeToColor
{
    NSDateFormatter *formatter;
    NSString        *dateString;
    
    formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"mm:ss.SSS"];
    
    dateString = [formatter stringFromDate:[NSDate date]];
    NSString *md5 = [self convertIntoMD5:dateString];
    long hash = [md5 hash];
    CGFloat hue = ( hash % 256 / 256.0 ); // 0.0 to 1.0
    CGFloat saturation = ( hash % 128 / 256.0 ) + 0.5; // 0.5 to 1.0, away from white
    CGFloat brightness = ( hash % 128 / 256.0 ) + 0.5; // 0.5 to 1.0, away from black
    UIColor *color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
    //NSLog(@"Returning %@\nHash is %lu", color, [dateString hash]);
    return color;
}

-(UIColor*)invertUIColor:(UIColor*)color
{
    CGFloat red = 0.0, green = 0.0, blue = 0.0, alpha =0.0;
    [color getRed:&red green:&green blue:&blue alpha:&alpha];
    
    UIColor *newColor = [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
    return newColor;
}

-(int)convertObjectIntWithRange:(int)range andString:(id)objectToConvert
{
    return [objectToConvert hash] % range;
}

- (NSString *)convertIntoMD5:(NSString *) string{
    const char *cStr = [string UTF8String];
    unsigned char digest[16];
    
    CC_MD5( cStr, (u_int16_t)strlen(cStr), digest ); // This is the md5 call
    
    NSMutableString *resultString = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [resultString appendFormat:@"%02x", digest[i]];
    return  resultString;
}

@end
