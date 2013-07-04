//
//  FlickrTagsTVC.m
//  SPoT
//
//  Created by Hector Enrique Gomez Morales on 7/4/13.
//  Copyright (c) 2013 Hector Enrique Gomez Morales. All rights reserved.
//

#import "FlickrPhotosTagsTVC.h"
#import "FlickrFetcher.h"

@interface FlickrPhotosTagsTVC ()
@property (nonatomic, strong) NSMutableDictionary *photosByTag; // of NSArrays of NSDictionaries
@end

@implementation FlickrPhotosTagsTVC

- (void)setPhotos:(NSArray *)photos
{
    _photos = photos;
    [self splitPhotosInTags];
}

- (void)setTags:(NSMutableDictionary *)photosByTag
{
    _photosByTag = photosByTag;
    [self.tableView reloadData];
}

- (void)splitPhotosInTags
{
    if ([[self.photos lastObject] isKindOfClass:[NSDictionary class]]) {
        NSLog(@"In splitPhotosInTags");
        NSMutableDictionary *tags = [[NSMutableDictionary alloc] init];
        for (NSDictionary *photo in self.photos) {
            NSArray *photoTags = [photo[FLICKR_TAGS] componentsSeparatedByString:@" "];
            NSLog(@"Tags: %@", photoTags);
            for (NSString *tag in photoTags) {
                if ([tag isEqualToString:@"cs193pspot"]) continue;
                if ([tag isEqualToString:@"portrait"]) continue;
                if ([tag isEqualToString:@"landscape"]) continue;
                
                if (!tags[tag]) tags[tag] = [[NSMutableArray alloc] init];
                NSLog(@"Adding photo to tag");
                [tags[tag] addObject:photo];
            }
        }
        self.photosByTag = tags;
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([sender isKindOfClass:[UITableViewCell class]]) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        if (indexPath) {
            NSString *tag = [self tagForRow:indexPath.row];
            if ([segue.identifier isEqualToString:@"Show Photos"]) {
                if ([segue.destinationViewController respondsToSelector:@selector(setPhotos:)]) {
                    [segue.destinationViewController performSelector:@selector(setPhotos:) withObject:self.photosByTag[tag]];
                    [segue.destinationViewController setTitle:[tag capitalizedString]];
                }
            }
        }
    }
}

- (void)viewDidLoad
{
    self.photos = [FlickrFetcher stanfordPhotos];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.photosByTag count];
}

- (NSString *)tagForRow:(NSUInteger)row
{
    return [[self.photosByTag allKeys] sortedArrayUsingSelector:@selector(compare:)][row];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Flickr Tag";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    NSString *tag = [self tagForRow:indexPath.row];
    cell.textLabel.text = [tag capitalizedString];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%d photos", [self.photosByTag[tag] count]];
    
    return cell;
}

@end
