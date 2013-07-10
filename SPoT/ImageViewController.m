//
//  ImageViewController.m
//  SPoT
//
//  Created by Hector Enrique Gomez Morales on 7/4/13.
//  Copyright (c) 2013 Hector Enrique Gomez Morales. All rights reserved.
//

#import "ImageViewController.h"

@interface ImageViewController () <UIScrollViewDelegate, UISplitViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) UIImageView *imageView;
@property (nonatomic) BOOL maxContent;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *titleBarButtonItem;
@property (nonatomic, strong) UIBarButtonItem *splitViewBarButtonItem;
@property (retain, nonatomic) UIPopoverController *popover;
@end

@implementation ImageViewController

-(void)setTitle:(NSString *)title
{
    super.title = title;
    self.titleBarButtonItem.title = title;
}

- (void)setImageURL:(NSURL *)imageURL
{
    _imageURL = imageURL;
    [self resetImage];
}

- (void)resetImage
{
    if (self.scrollView) {
        self.scrollView.contentSize = CGSizeZero;
        self.imageView.image = nil;
        NSLog(@"Starting download of image data");
        NSData *imageData = [[NSData alloc] initWithContentsOfURL:self.imageURL];
        NSLog(@"Finished download of image data");  
        UIImage *image = [[UIImage alloc] initWithData:imageData];
        if (image) {
            self.scrollView.zoomScale = 1.0;
            self.scrollView.contentSize = image.size;
            self.imageView.image = image;
            self.maxContent = YES;
            self.imageView.frame = CGRectMake(0, 0, image.size.width, image.size.height);
        }
    }
    
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    UIImage *image = self.imageView.image;
    if (image && self.maxContent) {
        CGFloat wScale = self.scrollView.bounds.size.width / image.size.width;
        CGFloat hScale = self.scrollView.bounds.size.height / image.size.height;
        if (wScale > hScale)
            self.scrollView.zoomScale = wScale;
        else
            self.scrollView.zoomScale = hScale;
    }
}

- (void)setSplitViewBarButtonItem:(UIBarButtonItem *)splitViewBarButtonItem
{
    NSMutableArray *toolbarItems = [self.toolbar.items mutableCopy];
    if (_splitViewBarButtonItem) {
        [toolbarItems removeObject:_splitViewBarButtonItem];
    }
    if (splitViewBarButtonItem) {
        [toolbarItems insertObject:splitViewBarButtonItem atIndex:0];
    }
    self.toolbar.items = toolbarItems;
    _splitViewBarButtonItem = splitViewBarButtonItem;
}

- (void)splitViewController:(UISplitViewController *)svc
     willHideViewController:(UIViewController *)aViewController
          withBarButtonItem:(UIBarButtonItem *)barButtonItem
       forPopoverController:(UIPopoverController *)pc
{
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:barButtonItem.target action:barButtonItem.action];
    barButtonItem = barButton;
    self.splitViewBarButtonItem = barButton;
    self.popover = pc;
}

- (void)splitViewController:(UISplitViewController *)svc
     willShowViewController:(UIViewController *)aViewController
  invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    self.splitViewBarButtonItem = nil;
    self.popover = nil;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    if (self.scrollView.zooming) {
        self.maxContent = NO;
    }
}

- (UIImageView *)imageView
{
    if (!_imageView) _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    return _imageView;
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.scrollView addSubview:self.imageView];
    self.scrollView.minimumZoomScale = 0.2;
    self.scrollView.maximumZoomScale = 5.0;
    self.scrollView.delegate = self;
    self.splitViewController.delegate = self;
    self.titleBarButtonItem.title = self.title;
    if (self.splitViewBarButtonItem) [self setSplitViewBarButtonItem:self.splitViewBarButtonItem];
    [self resetImage];
}

@end
