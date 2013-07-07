//
//  HawaiiImageViewController.m
//  SPoT
//
//  Created by Hector Enrique Gomez Morales on 7/4/13.
//  Copyright (c) 2013 Hector Enrique Gomez Morales. All rights reserved.
//

#import "HawaiiImageViewController.h"
#import "FlickrFetcher.h"

@interface HawaiiImageViewController ()

@end

@implementation HawaiiImageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.imageURL = [[NSURL alloc] initWithString:@"http://images.apple.com/v/iphone/gallery/a/images/photo_3.jpg"];
}

@end
