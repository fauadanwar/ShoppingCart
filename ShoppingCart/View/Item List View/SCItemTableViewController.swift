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
        self.title = NSLocalizedString("List_View_Title", comment: "Title Text for List View NavigationBar")
        
        dataSource = UITableViewDiffableDataSource<Section, SCItem>(tableView: tableView) {
            (tableView: UITableView, indexPath: IndexPath, item: SCItem) -> SCItemTableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: "SCItemTableViewCell", for: indexPath) as! SCItemTableViewCell
            cell.labelName.text = item.name
            cell.labelPrice.text = item.price
            /// - Tag: update
            cell.imageViewItem.image = item.imageItem.image
            ImageCache.publicCache.load(url: item.imageItem.url as NSURL, item: item.imageItem) { (fetchedItem, image) in
                if let img = image, img != fetchedItem.image {
                    var updatedSnapshot = self.dataSource.snapshot()
                    if let datasourceIndex = updatedSnapshot.indexOfItem(item) {
                        let item = self.listItems[datasourceIndex]
                        item.imageItem.image = img
                        updatedSnapshot.reloadItems([item])
                        self.dataSource.apply(updatedSnapshot, animatingDifferences: true)
                    }
                }
            }
            return cell
        }
        
        self.dataSource.defaultRowAnimation = .fade
        
        if listItems.isEmpty
        {
            let listItemHandler = SCListItemRequestHandler()
            MBProgressHUD.showAdded(to: self.view, animated: true)
            listItemHandler.fetchListItems(completion: { items, errorString in
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
                else if let message = errorString
                {
                    print(message)
                }
            })
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "SCDetailViewSegue", sender: indexPath);
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "SCDetailViewSegue") {
            let controller = segue.destination as! SCItemDetailViewController
            let row = (sender as! NSIndexPath).row; //we know that sender is an NSIndexPath here.
            let item = listItems[row]
            controller.item = item
        }
    }
    
    
}
