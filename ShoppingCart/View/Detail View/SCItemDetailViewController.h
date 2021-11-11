//
//  SCItemDetailViewController.h
//  ShoppingCart
//
//  Created by Fauad Anwar on 11/11/21.
//

#import <UIKit/UIKit.h>
@class SCItem;

NS_ASSUME_NONNULL_BEGIN

@interface SCItemDetailViewController : UIViewController
@property (nonatomic, strong) SCItem* item;
@end

NS_ASSUME_NONNULL_END
