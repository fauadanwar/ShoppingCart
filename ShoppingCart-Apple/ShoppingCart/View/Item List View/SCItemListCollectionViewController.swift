//
//  SCItemsCollectionViewController.swift
//  ShoppingCart
//
//  Created by Fauad Anwar on 06/04/22.
//

import UIKit
import FZImageCache
import MBProgressHUD

class SCItemListCollectionViewController: UICollectionViewController {

    // MARK: - Properties
    private var searchController = UISearchController(searchResultsController: nil)
    private var itemSections = [SCItemSection]()
    private var itemSectionsResponse = [SCItemSection]()
    private lazy var dataSource = setupDataSource()
    
    // MARK: - Value Types
    typealias DataSource = UICollectionViewDiffableDataSource<SCItemSection, SCItem>
    typealias Snapshot = NSDiffableDataSourceSnapshot<SCItemSection, SCItem>
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.clearsSelectionOnViewWillAppear = false
        self.title = NSLocalizedString("List_View_Title", comment: "Title Text for List View NavigationBar")
        self.collectionView.accessibilityIdentifier = "SCItemListCollectionViewController"
        generateItems()
        configureSearchController()
        configureLayout()
    }

    // MARK: - Functions
    func setupDataSource() -> DataSource {
      // 1
      let dataSource = DataSource(
        collectionView: collectionView,
        cellProvider: { (collectionView, indexPath, item) ->
          UICollectionViewCell? in
          // 2
          let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "SCItemListCollectionViewCell",
            for: indexPath) as? SCItemListCollectionViewCell
          cell?.item = item
          return cell
      })
      dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
        guard kind == UICollectionView.elementKindSectionHeader else {
          return nil
        }
        let itemSection = self.dataSource.snapshot()
          .sectionIdentifiers[indexPath.section]
        let view = collectionView.dequeueReusableSupplementaryView(
          ofKind: kind,
          withReuseIdentifier: SCItemListCollectionReusableView.reuseIdentifier,
          for: indexPath) as? SCItemListCollectionReusableView
        view?.itemSection = itemSection
        return view
      }
      return dataSource
    }
    
    func applySnapshot(animatingDifferences: Bool = true) {
        var snapshot = Snapshot()
        snapshot.appendSections(itemSections)
        itemSections.forEach { itemSection in
            snapshot.appendItems(itemSection.items, toSection: itemSection)
        }
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }
    
    func generateItems()
    {
        if itemSections.isEmpty
        {
            let listItemHandler = SCListItemRequestHandler()
            MBProgressHUD.showAdded(to: self.view, animated: true)
            listItemHandler.fetchListItems(completion: { [unowned self] itemsSections, errorString in
                DispatchQueue.main.async {
                    MBProgressHUD.hide(for: self.view, animated: true)
                }
                if let listItems = itemsSections
                {
                    self.itemSectionsResponse = listItems
                    self.itemSections = Array(listItems)
                    self.applySnapshot(animatingDifferences: false)
                }
                else if let message = errorString
                {
                    print(message)
                }
            })
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
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

// MARK: - UICollectionViewDataSource Implementation
extension SCItemListCollectionViewController
{
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "SCDetailViewSegue", sender: indexPath);
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

// MARK: - UISearchResultsUpdating Delegate
extension SCItemListCollectionViewController: UISearchResultsUpdating
{
    func updateSearchResults(for searchController: UISearchController)
    {
        itemSections = filteredSections(for: searchController.searchBar.text)
        applySnapshot()
    }
    
    func filteredSections(for queryOrNil: String?) -> [SCItemSection]
    {
        var searchedSections = Array(itemSectionsResponse)
        guard let query = queryOrNil, !query.isEmpty else {
            return searchedSections
        }
        var remeiningSection = [SCItemSection]()
        searchedSections = searchedSections.filter { itemSection in
            if itemSection.title.lowercased().contains(query.lowercased())
            {
                return true
            }
            else
            {
                remeiningSection.append(itemSection)
                return false
            }
        }
        
        var filteredSection = [SCItemSection]()
        
        for section in remeiningSection
        {
            var filteredItems = [SCItem]()
            
            for item in section.items
            {
                if item.name.lowercased().contains(query.lowercased())
                {
                    filteredItems.append(item)
                }
            }
            if filteredItems.count > 0
            {
                filteredSection.append(SCItemSection(items: filteredItems))
            }
        }
        searchedSections.append(contentsOf: filteredSection)
        return searchedSections
    }
    
    func configureSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Items"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
}

// MARK: - Layout Handling
extension SCItemListCollectionViewController
{
    private func configureLayout()
    {
        collectionView.register(
            SCItemListCollectionReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: SCItemListCollectionReusableView.reuseIdentifier
        )
        collectionView.collectionViewLayout = UICollectionViewCompositionalLayout(sectionProvider: { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            let isPhone = layoutEnvironment.traitCollection.userInterfaceIdiom == UIUserInterfaceIdiom.phone
            let size = NSCollectionLayoutSize(
                widthDimension: NSCollectionLayoutDimension.fractionalWidth(1),
                heightDimension: isPhone ? NSCollectionLayoutDimension.fractionalWidth(1) : NSCollectionLayoutDimension.fractionalWidth(1/3) 
            )
            let itemCount = isPhone ? 1 : 3
            let item = NSCollectionLayoutItem(layoutSize: size)
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: size, subitem: item, count: itemCount)
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
            section.interGroupSpacing = 10
            // Supplementary header view setup
            let headerFooterSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .estimated(20)
            )
            let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: headerFooterSize,
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top
            )
            section.boundarySupplementaryItems = [sectionHeader]
            return section
        })
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator)
    {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: { context in
            self.collectionView.collectionViewLayout.invalidateLayout()
        }, completion: nil)
    }
}
