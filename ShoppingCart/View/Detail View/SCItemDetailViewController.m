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

@interface SCItemDetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageViewItem;
@property (weak, nonatomic) IBOutlet UILabel *labelPriceTitle;
@property (weak, nonatomic) IBOutlet UILabel *labelPrice;
@property (weak, nonatomic) IBOutlet UILabel *labelCreatedAtTitle;
@property (weak, nonatomic) IBOutlet UILabel *labelCreatedAtValue;

@end

@implementation SCItemDetailViewController
@synthesize item;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = item.name;
    self.labelPrice.text = item.price;
    self.labelCreatedAtValue.text = item.created_at;
    self.labelPriceTitle.text = NSLocalizedString(@"Price_Title", comment: @"Title Text for Price Label");
    self.labelCreatedAtTitle.text = NSLocalizedString(@"Created_At_Title", comment: "Title Text for Created at");
    NSURL *url = [[NSURL alloc] initWithString:item.images.firstObject.image_url];
    Item *imagesItem = [[Item alloc] initWithImage:ImageCache.publicCache.placeholderImage url:url identifier: item.images.firstObject.image_id];
    self.imageViewItem.image = imagesItem.image;
    [MBProgressHUD showHUDAddedTo:self.imageViewItem animated:YES];
    [ImageCache.publicCache loadWithUrl: imagesItem.url item: imagesItem completion:^(Item * _Nonnull fetchedItem, UIImage * _Nullable image)
     {
        [MBProgressHUD hideHUDForView:self.imageViewItem animated:YES];
        if (image != fetchedItem.image)
        {
            imagesItem.image = image;
            self.imageViewItem.image = image;
        }
    }];
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
