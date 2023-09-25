//
//  HomeViewController.swift
//  News
//
//  Created by Ceren Güneş on 17.09.2023.
//

import SDWebImage
import SideMenu
import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var homeCollectionView: UICollectionView!
    
    var activityIndicator: UIActivityIndicatorView!
    private var menu: SideMenuNavigationController?
    var homeViewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        setupSideMenu()
        generateActivityIndicator()
        
        homeViewModel.loadNews()
        homeViewModel.onSuccess = reloadCollectionView()
        homeViewModel.onError = showError()
        
    }
    
    func reloadCollectionView() -> () -> () {
        tabBarController?.tabBar.isHidden = false
        activityIndicator.startAnimating()
        return {
            DispatchQueue.main.async {
                self.homeCollectionView.reloadData()
                self.activityIndicator.stopAnimating()
            }
        }
    }
    
    func showError() -> (_ errorStr: String) -> () {
        return { errorStr in
            DispatchQueue.main.async {
                self.showError(errorStr)
            }
        }
    }
    
    private func setupCollectionView() {
        homeCollectionView.delegate = self
        homeCollectionView.dataSource = self
    }
    
    private func setupSideMenu() {
        menu = SideMenuNavigationController(rootViewController: MenuListController())
        menu?.leftSide = true
        menu?.setNavigationBarHidden(true, animated: true)
        
        SideMenuManager.default.leftMenuNavigationController?.navigationBar.topItem?.setHidesBackButton(true, animated: true)
        SideMenuManager.default.leftMenuNavigationController = menu
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
    }
    
    private func generateActivityIndicator() {
        activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.center = view.center
        activityIndicator.color = .gray
        view.addSubview(activityIndicator)
    }
    
    @IBAction func SideMenuButtonTapped(_ sender: Any) {
        if let menu {
            present(menu, animated: true)
        }
    }
}


extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homeViewModel.numberOfItems(in: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell", for: indexPath) as? HomeCollectionViewCell {
            let selectedItem = homeViewModel.cellForItem(at: indexPath)
            
            
            cell.homeTitleLabel.text = selectedItem.title
            cell.homeDescriptionLabel.text = selectedItem.description
            
            if selectedItem.urlToImage == nil {
                cell.homeImageView.sd_setImage(with: URL(string: "https://i.pinimg.com/474x/95/31/7c/95317ca5719667e280e9861b01577934.jpg"))
            } else {
                cell.homeImageView.sd_setImage(with: URL(string: selectedItem.urlToImage!))
            }
            
            cell.layer.masksToBounds = false
            cell.layer.shadowColor = UIColor.black.cgColor
            cell.layer.shadowOpacity = 0.5
            cell.layer.shadowOffset = CGSize(width: -1, height: 1)
            cell.layer.shadowRadius = 1
            cell.layer.shouldRasterize = true
            
            return cell
            
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "DetailViewController", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = sender as? IndexPath {
            if segue.identifier == "DetailViewController" {
                if let destinationVC = segue.destination as? DetailViewController {
                    destinationVC.detailViewModel.news = homeViewModel.cellForItem(at: indexPath)
                    destinationVC.detailViewModel.indexPath = indexPath.row
                }
            }
        }
    }
}


extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.bounds.size.width - 40) / 2, height: collectionView.bounds.size.height / 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}


class CustomTabbarController : UITabBarController {
    
}
