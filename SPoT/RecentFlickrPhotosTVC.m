//
//  RecentFlickrPhotosTVC.m
//  SPoT
//
//  Created by Hector Enrique Gomez Morales on 7/4/13.
//  Copyright (c) 2013 Hector Enrique Gomez Morales. All rights reserved.
//

#import "RecentFlickrPhotosTVC.h"
#import "FlickrRecentPhotos.h"

@interface RecentFlickrPhotosTVC ()

@end

@implementation RecentFlickrPhotosTVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.sortList = NO;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.photos = [FlickrRecentPhotos photos];
}

@end
