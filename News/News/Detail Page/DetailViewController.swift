//
//  DetailViewController.swift
//  News
//
//  Created by Ceren Güneş on 18.09.2023.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var detailTitleLabel: UILabel!
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var detailPublishLabel: UILabel!
    @IBOutlet weak var detailAuthorLabel: UILabel!
    @IBOutlet weak var detailDescriptionLabel: UILabel!
    @IBOutlet weak var detailContentLabel: UILabel!
    
    var detailViewModel = DetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let saveButton = UIBarButtonItem(image: UIImage(systemName: "bookmark"), style: .plain, target: self, action: #selector(saveButtonTapped))
        let shareButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareButtonTapped))
        
        if detailViewModel.isSaved {
            saveButton.image = UIImage(systemName: "bookmark.fill")
        } else {
            saveButton.image = UIImage(systemName: "bookmark")
        }
        
        navigationItem.rightBarButtonItems = [shareButton, saveButton]
        navigationItem.leftBarButtonItem?.tintColor = UIColor.green
        navigationController?.navigationBar.barTintColor = UIColor.darkGray
        navigationItem.titleView?.tintColor = .darkGray
        
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
    
    @objc func saveButtonTapped() {
        detailViewModel.isSaved.toggle()
    }
    
    
    @objc func shareButtonTapped() {
        let vc = UIActivityViewController(activityItems: ["Recommend News to others!"], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItems![1]
        self.present(vc, animated: true)
    }
}
