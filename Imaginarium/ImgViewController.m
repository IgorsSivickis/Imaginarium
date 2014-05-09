//
//  ImgViewController.m
//  Imaginarium
//
//  Created by Igors.Sivickis on 5/9/14.
//  Copyright (c) 2014 accenture. All rights reserved.
//

#import "ImgViewController.h"
#import "ImageViewController.h"

@interface ImgViewController ()

@end

@implementation ImgViewController

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController isKindOfClass:[ImageViewController class]]) {
        ImageViewController *ivc = (ImageViewController *)segue.destinationViewController;
        ivc.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://images.apple.com/v/iphone-5s/gallery/a/images/download/%@.jpg", segue.identifier]];
        ivc.title = segue.identifier;
    }
}

@end
