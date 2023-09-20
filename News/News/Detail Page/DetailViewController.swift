//
//  DetailViewController.swift
//  News
//
//  Created by Ceren Güneş on 18.09.2023.
//


import CoreData
import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var detailTitleLabel: UILabel!
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var detailPublishLabel: UILabel!
    @IBOutlet weak var detailAuthorLabel: UILabel!
    @IBOutlet weak var detailDescriptionLabel: UILabel!
    @IBOutlet weak var detailContentLabel: UILabel!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    let context = appDelegate.persistentContainer.viewContext
    var detailViewModel = DetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getDetails()
        fetchFavNews()
    }
    
    private func getDetails() {
        if let detail = detailViewModel.news {
            detailImageView.sd_setImage(with: URL(string: detail.urlToImage ?? "person.fill"))
            detailTitleLabel.text = detail.title
            detailPublishLabel.text = detail.publishedAt
            detailAuthorLabel.text = (detail.author)
            detailDescriptionLabel.text = detail.description
            detailContentLabel.text = detail.content
        }
    }
    
    @IBAction func detailsButtonTapped(_ sender: Any) {
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailLinkViewController" {
            if let destinationVC = segue.destination as? DetailLinkViewController {
                if let urlString = detailViewModel.news?.url {
                    destinationVC.urlString = urlString
                }
            }
        }
    }
    
    private func saveFavNews() {
        detailViewModel.saveNews()
        changeFavButton()
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        if detailViewModel.saveButtonTapped() {
            changeFavButton()
        } else {
            saveFavNews()
        }
    }
    
    @IBAction func shareButtonTapped(_ sender: Any) {
        let vc = UIActivityViewController(activityItems: ["Recommend News to others!"], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItems![1]
        self.present(vc, animated: true)
    }
    
    private func fetchFavNews() {
        if detailViewModel.fetchFavNews() {
            changeFavButton()
        }
    }
    
    
    private func changeFavButton(){
        detailViewModel.changeFavButton(button: saveButton)
    }
}
