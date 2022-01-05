//
//  SCItemDetailViewController.m
//  ShoppingCart
//
//  Created by Fauad Anwar on 11/11/21.
//

#import "SCItemDetailViewController.h"
#import <FZImageCache/FZImageCache.h>
#import "ShoppingCart-Swift.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "ImageSlideshow-Swift.h"

@interface SCItemDetailViewController ()

@property (weak, nonatomic) IBOutlet ImageSlideshow *viewItemSlideShow;
@property (weak, nonatomic) IBOutlet UILabel *labelPriceTitle;
@property (weak, nonatomic) IBOutlet UILabel *labelPrice;
@property (weak, nonatomic) IBOutlet UILabel *labelCreatedAtTitle;
@property (weak, nonatomic) IBOutlet UILabel *labelCreatedAtValue;
@property (nonatomic, strong) NSMutableArray<SCItem *> *imageObjects;
@end

@implementation SCItemDetailViewController
@synthesize item;
@synthesize imageObjects;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = item.name;
    self.labelPrice.text = item.price;
    self.labelCreatedAtValue.text = item.created_at;
    self.labelPriceTitle.text = NSLocalizedString(@"Price_Title", comment: @"Title Text for Price Label");
    self.labelCreatedAtTitle.text = NSLocalizedString(@"Created_At_Title", comment: "Title Text for Created at");
    [self createImageItemsForSlideShow];
}

- (void)createImageItemsForSlideShow
{
    imageObjects = [[NSMutableArray alloc] init];
    NSMutableArray *imageSources = [[NSMutableArray alloc] init];
    
    // Code if we are showing single Image
    //        Item *imagesItem = [[Item alloc] initWithImage:ImageCache.publicCache.placeholderImage url:url identifier: item.images.firstObject.image_id];
    //        self.imageViewItem.image = imagesItem.image;
    //        [MBProgressHUD showHUDAddedTo:self.imageViewItem animated:YES];
    //        [ImageCache.publicCache loadWithUrl: imagesItem.url item: imagesItem completion:^(Item * _Nonnull fetchedItem, UIImage * _Nullable image)
    //         {
    //            [MBProgressHUD hideHUDForView:self.imageViewItem animated:YES];
    //            if (image != fetchedItem.image)
    //            {
    //                imagesItem.image = image;
    //                self.imageViewItem.image = image;
    //            }
    //        }];
   
    // Commeting below code as viewItemSlideShow does not have update image facility.
    //        for (SCItemImage * itemImages in item.images)
    //        {
    //            NSURL *url = [[NSURL alloc] initWithString:itemImages.image_url];
    //            Item *imagesItem = [[Item alloc] initWithImage:ImageCache.publicCache.placeholderImage url:url identifier: item.images.firstObject.image_id];
    //            ImageSource *imagesource = [[ImageSource alloc] initWithImage:imagesItem.image];
    //            [imageSources addObject:imagesource];
    //            [MBProgressHUD showHUDAddedTo:self.viewItemSlideShow animated:YES];
    //            [ImageCache.publicCache loadWithUrl: imagesItem.url item: imagesItem completion:^(Item * _Nonnull fetchedItem, UIImage * _Nullable image)
    //             {
    //                [MBProgressHUD hideHUDForView:self.viewItemSlideShow animated:YES];
    //                if (image != fetchedItem.image)
    //                {
    //                    imagesItem.image = image;
    //                }
    //            }];
    //        }
    
    // Added this code because Some issue with AlamofireSource/API url as other image URL are working fine, but image in API are not getting fetched
    NSURL *url = [[NSURL alloc] initWithString:item.images.firstObject.image_url];
    AlamofireSource *imagesource = [[AlamofireSource alloc] initWithUrl:url placeholder:ImageCache.publicCache.placeholderImage];
    [imageSources addObject:imagesource];
    AlamofireSource *imagesource1 = [[AlamofireSource alloc] initWithUrl:[NSURL URLWithString:@"https://images.unsplash.com/photo-1432679963831-2dab49187847?w=1080"] placeholder:ImageCache.publicCache.placeholderImage];
    [imageSources addObject:imagesource1];
    AlamofireSource *imagesource2 = [[AlamofireSource alloc] initWithUrl:[NSURL URLWithString:@"https://cdn.mos.cms.futurecdn.net/wtqqnkYDYi2ifsWZVW2MT4-1024-80.jpg.webp"] placeholder:ImageCache.publicCache.placeholderImage];
    [imageSources addObject:imagesource2];

    [self.viewItemSlideShow setImageInputs:imageSources];
    self.viewItemSlideShow.pageControl.currentPageIndicatorTintColor = UIColor.lightGrayColor;
    self.viewItemSlideShow.pageControl.pageIndicatorTintColor = UIColor.blackColor;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
