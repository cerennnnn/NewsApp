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
    
    var detailViewModel = DetailViewModel()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var safeNewsArr = [SavedNews]()
    var isSaved = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask ))
        setupNavigationBar()
        
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
        
        if let safeNews = detailViewModel.news {
            if let title = safeNews.title, let description = safeNews.description, let imageURL = safeNews.urlToImage, let indexPath = detailViewModel.indexPath {
                
                
                let new = SavedNews(context: self.context)
                new.title = title
                new.desc = description
                new.image = imageURL
                
                safeNewsArr.append(new)
                
//                isSaved = safeNewsArr.contains{$0.title == new.title}
                if isSaved {
                    saveItems()
                } else {
                    deleteItems(indexPath: indexPath)
                }
                
                setupNavigationBar()
            }
        }
    }
    
    func saveItems() {
        do {
            try context.save()
        } catch {
            print("Error saving context \(error)")
        }
    }
    
    func deleteItems(indexPath: Int) {
        context.delete(safeNewsArr.remove(at: indexPath))
        
        saveItems()
    }
    
    @objc func shareButtonTapped() {
        let vc = UIActivityViewController(activityItems: ["Recommend News to others!"], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItems![1]
        self.present(vc, animated: true)
    }
    
    private func setupNavigationBar() {
        let saveButton = UIBarButtonItem(image: UIImage(systemName: "bookmark"), style: .plain, target: self, action: #selector(saveButtonTapped))
        let shareButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareButtonTapped))
        
        if isSaved {
            saveButton.image = UIImage(systemName: "bookmark")
        } else {
            saveButton.image = UIImage(systemName: "bookmark.fill")
        }

        navigationItem.rightBarButtonItems = [shareButton, saveButton]
    }
}
