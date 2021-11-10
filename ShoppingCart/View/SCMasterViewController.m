//
//  SCMasterViewController.m
//  ShoppingCart
//
//  Created by Fauad Anwar on 10/11/21.
//

#import "SCMasterViewController.h"
#import <FZImageCache/FZImageCache.h>
#import "ShoppingCart-Swift.h"

@interface SCMasterViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation SCMasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSURL *url = [[NSURL alloc] initWithString:@"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRroxlNTOXyHOlAhJcvPoln60Rk5OEsmml0Dw&usqp=CAU"];
    Item *item = [[Item alloc] initWithImage:ImageCache.publicCache.placeholderImage url:url identifier:@"Kiara"];
    [ImageCache.publicCache loadWithUrl:item.url item:item completion:^(Item * _Nonnull fetchedItem, UIImage * _Nullable fetchedImage) {
        __block SCMasterViewController *blocksafeSelf = self;
        if (fetchedImage != fetchedItem.image)
        {
            item.image = fetchedImage;
            blocksafeSelf.imageView.image = item.image;
        }
    }];
}


@end
