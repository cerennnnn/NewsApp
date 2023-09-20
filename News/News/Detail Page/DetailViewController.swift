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
    var safeNewsArr = [SavedNews]()
    var isSaved = false
    
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
    
    func saveFavNews(){
        let context = appDelegate.persistentContainer.viewContext
        let news = SavedNews(context: context)
        
        if let safeNews = detailViewModel.news {
            news.title = safeNews.title
            news.desc = safeNews.description
            news.image = safeNews.urlToImage
            news.id = safeNews.source?.id
            
            appDelegate.saveContext()
            isSaved = true
            changeFavButton()
            
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
                    changeFavButton()
                }
            } catch {
                print(error.localizedDescription)
            }
        } else {
            saveFavNews()
        }
    }
    
    @IBAction func shareButtonTapped(_ sender: Any) {
        let vc = UIActivityViewController(activityItems: ["Recommend News to others!"], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItems![1]
        self.present(vc, animated: true)
    }
    
    private func fetchFavNews(){
        do {
            let results = try context.fetch(SavedNews.fetchRequest())
            if let id = detailViewModel.news?.source?.id {
                isSaved = results.contains { $0.id == id }
                if isSaved {
                    changeFavButton()
                }
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func changeFavButton(){
        if isSaved == true {
            saveButton.image = UIImage(systemName: "bookmark.fill")
        } else {
            saveButton.image = UIImage(systemName: "bookmark")
        }
    }
}
