//
//  SCItemTableViewController.swift
//  ShoppingCart
//
//  Created by Fauad Anwar on 11/11/21.
//

import UIKit
import FZImageCache
import MBProgressHUD

class SCItemTableViewController: UITableViewController {

    var dataSource: UITableViewDiffableDataSource<Section, SCItem>! = nil
    private var listItems = [SCItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

         self.clearsSelectionOnViewWillAppear = false
        
        dataSource = UITableViewDiffableDataSource<Section, SCItem>(tableView: tableView) {
            (tableView: UITableView, indexPath: IndexPath, item: SCItem) -> SCItemsTableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: "SCItemsTableViewCell", for: indexPath) as? SCItemsTableViewCell
            cell?.labelName.text = item.name
            cell?.labelPrice.text = item.price
            /// - Tag: update
            if let itemImage = item.images.first, let url = URL(string: itemImage.image_urls_thumbnail)
            {
                let itemImageCache = Item(image: ImageCache.publicCache.placeholderImage, url: url, identifier: itemImage.image_id)
                
                cell?.imageViewItem.image = itemImageCache.image
                
                ImageCache.publicCache.load(url: itemImageCache.url as NSURL, item: itemImageCache) { (fetchedItem, image) in
                    if let img = image, img != fetchedItem.image {
                        var updatedSnapshot = self.dataSource.snapshot()
                        if let datasourceIndex = updatedSnapshot.indexOfItem(item) {
                            let item = self.listItems[datasourceIndex]
                            itemImageCache.image = img
                            updatedSnapshot.reloadItems([item])
                            self.dataSource.apply(updatedSnapshot, animatingDifferences: true)
                        }
                    }
                }
            }
            return cell
        }
        
        self.dataSource.defaultRowAnimation = .fade
        
        if listItems.isEmpty
        {
            let listItemHandler = SCListItemHandler()
            MBProgressHUD.showAdded(to: self.view, animated: true)
            listItemHandler.fetchListItems(completion: { items in
                DispatchQueue.main.async {
                    MBProgressHUD.hide(for: self.view, animated: true)
                }
                if let listItems = items
                {
                    self.listItems = listItems
                    var initialSnapshot = NSDiffableDataSourceSnapshot<Section, SCItem>()
                    initialSnapshot.appendSections([.main])
                    initialSnapshot.appendItems(self.listItems)
                    self.dataSource.apply(initialSnapshot, animatingDifferences: true)
                }
            })
        }
    }


    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}
