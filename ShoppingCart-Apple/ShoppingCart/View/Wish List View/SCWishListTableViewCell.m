//
//  SCItemTableViewCell.m
//  ShoppingCart
//
//  Created by Fauad Anwar on 22/01/22.
//

#import "SCWishListTableViewCell.h"
#import "FZImageCache/FZImageCache.h"
#import "ShoppingCart-Swift.h"

@interface SCWishListTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *imageViewItem;
@property (weak, nonatomic) IBOutlet UILabel *labelName;
@property (weak, nonatomic) IBOutlet UILabel *labelPriceTitle;
@property (weak, nonatomic) IBOutlet UILabel *labelPrice;
@property (strong, nonatomic) SCItem *item;
@end

@implementation SCWishListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.labelPriceTitle.text = NSLocalizedString(@"Price_Title", comment: @"Title Text for Price Label");
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configureCellWithItem:(SCItem*)item
{
    self.item = item;
    self.labelName.text = item.name;
    self. labelPrice.text = item.price;
    self.imageViewItem.image = ImageCache.publicCache.placeholderImage;
    if (item.images.count > 0)
    {
        NSString *imageItem = item.images.firstObject.image_urls_thumbnail;
        if (imageItem != nil)
        {
            NSURL *url = [NSURL URLWithString:imageItem];
            __weak SCWishListTableViewCell *weakSelf = self;
            [ImageCache.publicCache loadWithUrl:url itemIdentifier:item completion:^(NSObject * recivedItem, UIImage * image)
             {
                if (weakSelf.item == recivedItem)
                {
                    self.imageViewItem.image = image;
                }
            }];
        }
    }
}

@end
