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
    
    enum Section {
      case main
    }
    typealias DataSource = UITableViewDiffableDataSource<Section, SCItem>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, SCItem>

    private lazy var dataSource = setupDataSource()

    private var searchController = UISearchController(searchResultsController: nil)
    
    private var listItems = [SCItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.clearsSelectionOnViewWillAppear = false
        self.title = NSLocalizedString("List_View_Title", comment: "Title Text for List View NavigationBar")
        self.tableView.accessibilityIdentifier = "ItemTableViewController"
        generateItems()
    }
     
    func setupDataSource() -> DataSource
    {
        let dataSource = DataSource(tableView: tableView) { tableView, indexPath, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: "SCItemTableViewCell", for: indexPath) as! SCItemTableViewCell
            cell.configureCell(item: item)
            return cell
        }
        dataSource.defaultRowAnimation = .fade
        return dataSource
    }
    
    func applySnapshot(animatingDifferences: Bool = true)
    {
        var initialSnapshot = Snapshot()
        initialSnapshot.appendSections([.main])
        initialSnapshot.appendItems(self.listItems)
        self.dataSource.apply(initialSnapshot, animatingDifferences: animatingDifferences)
    }
    
    func generateItems()
    {
        if listItems.isEmpty
        {
            let listItemHandler = SCListItemRequestHandler()
            MBProgressHUD.showAdded(to: self.view, animated: true)
            listItemHandler.fetchListItems(completion: { [unowned self] items, errorString in
                DispatchQueue.main.async {
                    MBProgressHUD.hide(for: self.view, animated: true)
                }
                if let listItems = items
                {
                    self.listItems = listItems
                    self.applySnapshot()
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
            let indexPath = (sender as! IndexPath); //we know that sender is an NSIndexPath here.
            guard let item = dataSource.itemIdentifier(for: indexPath) else {
              return
            }
            controller.item = item
        }
    }
    
    
}
