//
//  ImageViewController.m
//  Imaginarium
//
//  Created by Igors.Sivickis on 5/9/14.
//  Copyright (c) 2014 accenture. All rights reserved.
//

// images.apple.com/v/iphone-5s/gallery/a/images/download/photo_1.jpg

#import "ImageViewController.h"

@interface ImageViewController () <UIScrollViewDelegate>

@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UIImage *image;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;

@end

@implementation ImageViewController

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

-(void)setScrollView:(UIScrollView *)scrollView
{
    _scrollView = scrollView;
    _scrollView.minimumZoomScale = 0.2;
    _scrollView.maximumZoomScale = 2.0;
    _scrollView.delegate = self;
    self.scrollView.contentSize = self ? self.image.size : CGSizeZero;
}

-(void)setImageURL:(NSURL *)imageUrl
{
    _imageURL = imageUrl;
   // self.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:self.imageURL]];
    [self startDownloadingImage];
}

-(void)startDownloadingImage
{
    self.image = nil;
    [self.spinner startAnimating];
    if(self.imageURL) {
        NSURLRequest *request = [NSURLRequest requestWithURL:self.imageURL];
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration ephemeralSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
        NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request
                                          completionHandler:^(NSURL *localfile, NSURLResponse *response, NSError *error) {
                                              if (!error){
                                                  if ([request.URL isEqual:self.imageURL]) {
                                                      UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:localfile]];
                                                      dispatch_async(dispatch_get_main_queue(), ^{ self.image = image; });
                                                     
                                                  }
                                              }
                                          }];
        [task resume];
    }
}

-(UIImageView *) imageView
{
    if (!_imageView) _imageView = [[UIImageView alloc]init];
    return _imageView;
}

-(UIImage *)image
{
    return self.imageView.image;
}

-(void)setImage:(UIImage *)image;
{
    self.imageView.image = image;
    [self.imageView sizeToFit];
    self.scrollView.contentSize = self ? self.image.size : CGSizeZero;
    [self.spinner stopAnimating];
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self.scrollView addSubview:self.imageView];
}

@end
