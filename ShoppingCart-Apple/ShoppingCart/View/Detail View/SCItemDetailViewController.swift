//
//  SCItemDetailViewController.swift
//  ShoppingCart
//
//  Created by Fauad Anwar on 22/01/22.
//

import UIKit
import FZImageCache
import MBProgressHUD

class SCItemDetailViewController: UIViewController {

    @IBOutlet weak var labelPriceTitle: UILabel!
    @IBOutlet weak var labelPrice: UILabel!
    @IBOutlet weak var labelCreatedAtTitle: UILabel!
    @IBOutlet weak var labelCreatedAtValue: UILabel!
    @IBOutlet weak var imageCollectionView: UICollectionView!

    @IBOutlet weak var viewPageControl: UIView!
    @IBOutlet weak var pageControlImages: UIPageControl!
    @IBOutlet weak var buttonPriviousImage: UIButton!
    @IBOutlet weak var buttonNextImage: UIButton!
    @IBOutlet weak var constraintPageControlHeight: NSLayoutConstraint!
    
    var item: SCItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = item?.name
        self.labelPrice.text = item?.price
        self.labelCreatedAtValue.text = item?.created_at
        self.labelPriceTitle.text = NSLocalizedString("Price_Title", comment: "Title Text for Price Label")
        self.labelCreatedAtTitle.text = NSLocalizedString("Created_At_Title", comment: "Title Text for Created at")
        self.createImageItemsForSlideShow()
    }
    
    func createImageItemsForSlideShow()
    {
        imageCollectionView.showsHorizontalScrollIndicator = false
        if item?.images.count == 1
        {
            viewPageControl.isHidden = true
            constraintPageControlHeight.constant = 0
            imageCollectionView.isScrollEnabled = false
        }
        else
        {
            pageControlImages.numberOfPages = item!.images.count
            pageControlImages.currentPage = 0
            buttonPriviousImage.isEnabled = false
            imageCollectionView.isPagingEnabled = true
        }
    }
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if let layout = imageCollectionView.collectionViewLayout as? UICollectionViewFlowLayout
        {
            layout.itemSize = CGSize(width: imageCollectionView.frame.width, height: imageCollectionView.frame.height)
            layout.invalidateLayout()
        }
    }
    
    @IBAction func buttonPriviousImageClicked(_ sender: Any) {
        buttonPriviousImage.isEnabled = true
        buttonNextImage.isEnabled = true
        var current = pageControlImages.currentPage
        current -= 1
        if current <= 0
        {
            buttonPriviousImage.isEnabled = false
        }
        let indexPath = IndexPath(item: current, section: 0)
        imageCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
    }
    
    @IBAction func buttonNextImageClicked(_ sender: Any) {
        buttonPriviousImage.isEnabled = true
        buttonNextImage.isEnabled = true
        var current = pageControlImages.currentPage
        current += 1
        if current >= item!.images.count - 1
        {
            buttonNextImage.isEnabled = false
        }
        let indexPath = IndexPath(item: current, section: 0)
        imageCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
    }
    
    @IBAction func pageControlImagesValueChaned(_ sender: Any) {
        buttonPriviousImage.isEnabled = true
        buttonNextImage.isEnabled = true
        let current = pageControlImages.currentPage
        if current >= item!.images.count - 1
        {
            buttonNextImage.isEnabled = false
        }
        else if current <= 0
        {
            buttonPriviousImage.isEnabled = false
        }
        let indexPath = IndexPath(item: current, section: 0)
        imageCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}

extension SCItemDetailViewController: UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 0
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        buttonPriviousImage.isEnabled = true
        buttonNextImage.isEnabled = true
        let scrollPos = scrollView.contentOffset.x / imageCollectionView.frame.width
        let current = Int(scrollPos)
        if current >= item!.images.count - 1
        {
            buttonNextImage.isEnabled = false
        }
        else if current <= 0
        {
            buttonPriviousImage.isEnabled = false
        }
        pageControlImages.currentPage = current
    }
}

extension SCItemDetailViewController: UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return item!.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SCImageCollectionViewCell", for: indexPath) as! SCImageCollectionViewCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let cellItem = cell as! SCImageCollectionViewCell
        cellItem.configureCellWithItem(imageItem: self.item!.images[indexPath.item])
    }
}
