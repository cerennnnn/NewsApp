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
    var isSaved = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getDetails()
        fetchSavedNews()
    }
    
    private func getDetails() {
        if let detail = detailViewModel.news {
            
            if detail.urlToImage == nil {
                detailImageView.sd_setImage(with: URL(string: "https://i.pinimg.com/474x/95/31/7c/95317ca5719667e280e9861b01577934.jpg"))
            } else {
                detailImageView.sd_setImage(with: URL(string: detail.urlToImage!))
            }
            detailTitleLabel.text = detail.title
            detailPublishLabel.text = detail.publishedAt
            detailAuthorLabel.text = (detail.author)
            detailDescriptionLabel.text = detail.description
            detailContentLabel.text = detail.content
        }
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
    
    func saveNews(){
        let context = appDelegate.persistentContainer.viewContext
        let news = SavedNews(context: context)
        
        if let safeNews = detailViewModel.news {
            news.title = safeNews.title
            news.desc = safeNews.description
            news.image = safeNews.urlToImage
            news.id = safeNews.source?.id
            
            appDelegate.saveContext()
            isSaved = true
            changeSaveButton()
            
        }
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        if isSaved {
            do {
                let id = detailViewModel.news?.source?.id
                let results = try context.fetch(SavedNews.fetchRequest())
                if let savedNew = results.first(where: { $0.id == id }) {
                    context.delete(savedNew)
                    appDelegate.saveContext()
                    isSaved = false
                    changeSaveButton()
                }
            } catch {
                print(error.localizedDescription)
            }
        } else {
            saveNews()
        }
    }
    
    @IBAction func shareButtonTapped(_ sender: Any) {
        let vc = UIActivityViewController(activityItems: ["Recommend News to others!"], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItems![1]
        self.present(vc, animated: true)
    }
    
    private func fetchSavedNews(){
        do {
            let results = try context.fetch(SavedNews.fetchRequest())
            if let id = detailViewModel.news?.source?.id {
                isSaved = results.contains { $0.id == id }
                if isSaved {
                    changeSaveButton()
                }
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func changeSaveButton(){
        if isSaved == true {
            saveButton.image = UIImage(systemName: "bookmark.fill")
        } else {
            saveButton.image = UIImage(systemName: "bookmark")
        }
    }
}
