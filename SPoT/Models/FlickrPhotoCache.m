//
//  FlickrPhotoCache.m
//  SPoT
//
//  Created by Hector Enrique Gomez Morales on 7/11/13.
//  Copyright (c) 2013 Hector Enrique Gomez Morales. All rights reserved.
//

#import "FlickrPhotoCache.h"

@interface FlickrPhotoCache()
@end

@implementation FlickrPhotoCache

#define ALL_CACHED_PHOTOS_KEY @"Flickr Cached Photos Key"

+ (NSMutableDictionary *)cacheJournal
{
    NSMutableDictionary *cacheJournal = [[[NSUserDefaults standardUserDefaults] dictionaryForKey:ALL_CACHED_PHOTOS_KEY] mutableCopy];
    if (!cacheJournal) cacheJournal = [[NSMutableDictionary alloc] init];
    return cacheJournal;
}

+ (void)addPhoto:(NSData *)photo key:(NSURL *)key
{
    //NSFileManager *manager = [[NSFileManager alloc] init];
    //NSArray *urls = [manager URLsForDirectory:NSCachesDirectory inDomains:NSUserDomainMask];
}

+ (UIImage *)getPhoto:(NSString *)key
{
    return nil;
}

+ (BOOL)photoInCache:(NSURL *)key
{
    return [FlickrPhotoCache cacheJournal][[key absoluteString]] ? YES : NO;
}
@end
