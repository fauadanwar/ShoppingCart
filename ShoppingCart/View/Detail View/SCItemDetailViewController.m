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
@property (nonatomic, strong) NSMutableArray<Item *> *imageObjects;
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
    for (SCItemImage * itemImages in item.images)
    {
        // Some issue with data source as other image URL are working fine, but image in API resone are not getting fetched
        NSURL *url = [[NSURL alloc] initWithString:@"https://images.unsplash.com/photo-1432679963831-2dab49187847?w=1080"];//itemImages.image_url];
        AlamofireSource *imagesource = [[AlamofireSource alloc] initWithUrl:url placeholder:ImageCache.publicCache.placeholderImage];
        [imageSources addObject:imagesource];
    }
    [self.viewItemSlideShow setImageInputs:imageSources];
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
