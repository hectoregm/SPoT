//
//  FlickrPhotoTVC.m
//  SPoT
//
//  Created by Hector Enrique Gomez Morales on 7/4/13.
//  Copyright (c) 2013 Hector Enrique Gomez Morales. All rights reserved.
//

#import "FlickrPhotosTVC.h"
#import "FlickrFetcher.h"
#import "FlickrRecentPhotos.h"

@interface FlickrPhotosTVC ()

@end

@implementation FlickrPhotosTVC

- (void)setPhotos:(NSArray *)photos
{
    _photos = photos;
    [self.tableView reloadData];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([sender isKindOfClass:[UITableViewCell class]]) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        if (indexPath) {
            if ([segue.identifier isEqualToString:@"Show Image"]) {
                if ([segue.destinationViewController respondsToSelector:@selector(setImageURL:)]) {
                    NSDictionary *photo = [self PhotoForRow:indexPath.row];
                    NSURL *url = [FlickrFetcher urlForPhoto:photo format:FlickrPhotoFormatLarge];
                    [segue.destinationViewController performSelector:@selector(setImageURL:) withObject:url];
                    [segue.destinationViewController setTitle:[self titleForRow:photo]];
                    [FlickrRecentPhotos addPhoto:photo];
                }
            }
        }
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.sortList = YES;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.photos count];
}

- (NSString *)titleForRow:(NSDictionary *)photo
{
    return [photo[FLICKR_PHOTO_TITLE] description];
}

- (NSString *)subtitleForRow:(NSDictionary *)photo
{
    return [[photo valueForKeyPath:FLICKR_PHOTO_DESCRIPTION] description];
}

- (NSDictionary *)PhotoForRow:(NSUInteger)row
{
    NSDictionary *photo;
    if (self.sortList) {
        NSSortDescriptor *titleDescriptor = [[NSSortDescriptor alloc] initWithKey:FLICKR_PHOTO_TITLE ascending:YES];
        photo = [self.photos sortedArrayUsingDescriptors:@[titleDescriptor]][row];
    } else {
        photo = self.photos[row];
    }
    return photo;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Flickr Photo";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    NSDictionary *photo = [self PhotoForRow:indexPath.row];
    cell.textLabel.text = [self titleForRow:photo];
    cell.detailTextLabel.text = [self subtitleForRow:photo];
    return cell;
}

@end
