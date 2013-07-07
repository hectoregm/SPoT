//
//  FlickrRecentPhotos.m
//  SPoT
//
//  Created by Hector Enrique Gomez Morales on 7/7/13.
//  Copyright (c) 2013 Hector Enrique Gomez Morales. All rights reserved.
//

#import "FlickrRecentPhotos.h"

#define MAX_HISTORY 15
#define RECENT_FLICKR_PHOTOS_KEY @"RecentWatchedPhotos_Key"


@implementation FlickrRecentPhotos
+ (NSMutableArray *)photos
{
    NSMutableArray *array = [[[NSUserDefaults standardUserDefaults] arrayForKey:RECENT_FLICKR_PHOTOS_KEY] mutableCopy];
    if (!array) array = [NSMutableArray array];
    return array;
}

+ (void)addPhoto:(NSDictionary *)photo
{
    NSMutableArray *photos = [self photos];
    [photos removeObject:photo];
    [photos insertObject:photo atIndex:0];
    if ([photos count] > MAX_HISTORY) {
        [photos removeLastObject];
    }
    [[NSUserDefaults standardUserDefaults] setObject:photos forKey:RECENT_FLICKR_PHOTOS_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
@end
