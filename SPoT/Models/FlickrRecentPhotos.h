//
//  FlickrRecentPhotos.h
//  SPoT
//
//  Created by Hector Enrique Gomez Morales on 7/7/13.
//  Copyright (c) 2013 Hector Enrique Gomez Morales. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FlickrRecentPhotos : NSObject
+ (NSMutableArray *)photos;
+ (void)addPhoto:(NSDictionary *)photo;
@end
