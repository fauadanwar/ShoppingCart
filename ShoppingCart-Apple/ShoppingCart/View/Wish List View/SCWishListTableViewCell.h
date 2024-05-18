//
//  SCItemTableViewCell.h
//  ShoppingCart
//
//  Created by Fauad Anwar on 22/01/22.
//

#import <UIKit/UIKit.h>
@class SCItem;
NS_ASSUME_NONNULL_BEGIN


@interface SCWishListTableViewCell : UITableViewCell
- (void)configureCellWithItem:(SCItem *)item;
@end

NS_ASSUME_NONNULL_END
