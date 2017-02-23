//
//  SectionView.m
//  CustomTableTest
//
//  Created by Punit Sindhwani on 7/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SectionView.h"
#import <QuartzCore/QuartzCore.h>
#import "appShareManager.h"

@implementation SectionView
{
    BOOL btnClick;
    UIButton *button1;
      UIImageView *ceckboximg;
    
     appShareManager *objappShareManager;
}

@synthesize section;
@synthesize sectionTitle;
@synthesize discButton;
@synthesize delegate;

+ (Class)layerClass {
    
    return [CAGradientLayer class];
}

- (id)initWithFrame:(CGRect)frame WithTitle: (NSString *) title Section:(NSInteger)sectionNumber delegate: (id <SectionView>) Delegate andselected:(NSInteger)slec
{
    objappShareManager=[appShareManager sharedManager];
    btnClick=YES;
    
    self = [super initWithFrame:frame];
    if (self) {
   
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(discButtonPressed:)];
        [self addGestureRecognizer:tapGesture];
        
        self.userInteractionEnabled = YES;

        self.section = sectionNumber;
        self.delegate = Delegate;

        CGRect LabelFrame =CGRectMake(50, 0, self.bounds.size.width,  self.bounds.size.height); //self.bounds;
        LabelFrame.size.width -= 50;
        CGRectInset(LabelFrame, 0.0, 5.0);
        
        UILabel *label = [[UILabel alloc] initWithFrame:LabelFrame];
        label.text = title;
        label.font = [UIFont boldSystemFontOfSize:16.0];
        label.backgroundColor = [UIColor whiteColor];
        label.textColor = [UIColor blackColor];
        label.textAlignment = UITextAlignmentLeft;
        [self addSubview:label];
        self.sectionTitle = label;
        
        CGRect buttonFrame = CGRectMake(LabelFrame.size.width+12.5,12.5, 25,25);
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = buttonFrame;
        self.discButton = button;
        
        [button setImage:[UIImage imageNamed:@"img_list-arrow"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"img_listDownArrow"] forState:UIControlStateSelected];
        [button addTarget:self action:@selector(discButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
        
        if (slec==1) {
            
            self.discButton.selected=YES;

        }
      
        CGRect buttonFrame1 = CGRectMake(12.5, 12.5,25 , 25);
        button1 = [UIButton buttonWithType:UIButtonTypeCustom];
        button1.frame = buttonFrame1;
        ceckboximg=[[UIImageView alloc] initWithFrame:CGRectMake(12.5, 12.5, 25, 25)];
        
        if([[[objappShareManager.TransportFlageArray  objectAtIndex:self.section]objectAtIndex:0]isEqualToString:[NSString stringWithFormat:@"1"]])
        {
            [ceckboximg setAccessibilityIdentifier:@"check.png"];
            ceckboximg.image = [UIImage imageNamed:@"check.png"];
        }
        else
        {
            [ceckboximg setAccessibilityIdentifier:@"uncheck.png"];
            ceckboximg.image = [UIImage imageNamed:@"uncheck.png"];
        }
        
        
        
        [button1 addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button1];
       [self addSubview:ceckboximg];
        
//
//        static NSMutableArray *colors = nil;
//        if (colors == nil) {
//            colors = [[NSMutableArray alloc] initWithCapacity:3];
//            UIColor *color = nil;
//            color = [UIColor colorWithRed:0.61 green:0.74 blue:0.78 alpha:1];
//            [colors addObject:(id)[color CGColor]];
//            color = [UIColor colorWithRed:0.50 green:0.54 blue:0.58 alpha:1];
//            [colors addObject:(id)[color CGColor]];
//            color = [UIColor colorWithRed:0.15 green:0.20 blue:0.23 alpha:1];
//            [colors addObject:(id)[color CGColor]];
//        }
//        [(CAGradientLayer *)self.layer setColors:colors];
//        [(CAGradientLayer *)self.layer setLocations:[NSArray arrayWithObjects:[NSNumber numberWithFloat:0.0], [NSNumber numberWithFloat:0.48], [NSNumber numberWithFloat:1.0], nil]];
        
        self.layer.backgroundColor=[UIColor whiteColor].CGColor;
    }
    return self;
}
-(void)btnClick
{
    objappShareManager=[appShareManager sharedManager];
    NSString *file_name = [ceckboximg accessibilityIdentifier] ;
    if ([file_name isEqualToString:[NSString stringWithFormat:@"uncheck.png"]])
    {
        [[objappShareManager.TransportFlageArray  objectAtIndex:self.section]replaceObjectAtIndex:0 withObject:@"1"];

        
        for (int j=0; j< [[[objappShareManager.TransportFlageArray  objectAtIndex:self.section]objectAtIndex:1] count ];j++)
        {
            
            [[[objappShareManager.TransportFlageArray  objectAtIndex:self.section]objectAtIndex:1]replaceObjectAtIndex:j withObject:@"1"];
            
            
        }
       
        ceckboximg.image = [UIImage imageNamed:@"check.png"];
        [ceckboximg setAccessibilityIdentifier:@"check.png"] ;

        [self toggleButtonPressed:TRUE];
    }
    else
    {
        [[objappShareManager.TransportFlageArray  objectAtIndex:self.section]replaceObjectAtIndex:0 withObject:@"0"];
        
        for (int j=0; j< [[[objappShareManager.TransportFlageArray  objectAtIndex:self.section]objectAtIndex:1] count ];j++)
        {
            [[[objappShareManager.TransportFlageArray  objectAtIndex:self.section]objectAtIndex:1]replaceObjectAtIndex:j withObject:@"0"];
            
            
        }
        
       
        ceckboximg.image = [UIImage imageNamed:@"uncheck.png"];
        [ceckboximg setAccessibilityIdentifier:@"uncheck.png"] ;
        [self toggleButtonPressed:TRUE];
    }
    
//    if ([button1 imageForState:UIControlStateNormal]==[UIImage imageNamed:@"uncheck.png"]) {
//        
//        [[objappShareManager.TransportFlageArray  objectAtIndex:self.section]replaceObjectAtIndex:0 withObject:@"1"];
//        
//        for (int j=0; j< [[[objappShareManager.TransportFlageArray  objectAtIndex:self.section]objectAtIndex:1] count ];j++)
//        {
//            
//            
//            [[[objappShareManager.TransportFlageArray  objectAtIndex:self.section]objectAtIndex:1]replaceObjectAtIndex:j withObject:@"1"];
//            
//            
//        }
//
//        
//        
//        [button1 setImage:[UIImage imageNamed:@"check.png"] forState:UIControlStateNormal];
//        //btnClick=NO;
//    }
//    else
//    {
//        [[objappShareManager.TransportFlageArray  objectAtIndex:self.section]replaceObjectAtIndex:0 withObject:@"0"];
//        
//        for (int j=0; j< [[[objappShareManager.TransportFlageArray  objectAtIndex:self.section]objectAtIndex:1] count ];j++)
//        {
//            [[[objappShareManager.TransportFlageArray  objectAtIndex:self.section]objectAtIndex:1]replaceObjectAtIndex:j withObject:@"0"];
//            
//            
//        }
//
//        
//        
//        [button1 setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
//       // btnClick=YES;
//    }
    
}
- (void) discButtonPressed : (id) sender
{
    [self toggleButtonPressed:TRUE];
}

- (void) toggleButtonPressed : (BOOL) flag
{
    self.discButton.selected = !self.discButton.selected;
    if(flag)
    {
        if (self.discButton.selected) 
        {
            if ([self.delegate respondsToSelector:@selector(sectionOpened:)]) 
            {
                [self.delegate sectionOpened:self.section];
            }
        } else
        {
            if ([self.delegate respondsToSelector:@selector(sectionClosed:)]) 
            {
                [self.delegate sectionClosed:self.section];
            }
        }
    }
}

@end
