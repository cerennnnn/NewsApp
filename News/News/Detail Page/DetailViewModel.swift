//
//  DetailViewModel.swift
//  News
//
//  Created by Ceren Güneş on 18.09.2023.
//

import UIKit

final class DetailViewModel {
    let context = appDelegate.persistentContainer.viewContext
    var savedNews: SavedNews?
    var news: News?
    var dbNews: [SavedNews]?
    var isSaved: Bool = false
    var indexPath: Int?
    var safeNewsArr = [SavedNews]()
    
    func changeFavButton(button: UIBarButtonItem){
        if isSaved == true {
            button.image = UIImage(systemName: "bookmark.fill")
        } else {
            button.image = UIImage(systemName: "bookmark")
        }
    }

    
    func getSavedNews() -> SavedNews? {
        savedNews = SavedNews(context: context)
        return savedNews
    }
    
    
    func saveNews() {
        if let safeNews = news, let news = getSavedNews() {
            news.title = safeNews.title
            news.desc = safeNews.description
            news.image = safeNews.urlToImage
            news.id = safeNews.source?.id
            
            appDelegate.saveContext()
            isSaved = true
        }
    }
    
    func fetchFavNews() -> Bool {
        do {
            let results = try context.fetch(SavedNews.fetchRequest())
            if let title = news?.title {
                isSaved = results.contains { $0.title == title }
            }
        } catch {
            print(error.localizedDescription)
        }
        
        return isSaved
    }
    
    func saveButtonTapped() -> Bool {
        if isSaved {
            do {
                let title = news?.title
                let results = try context.fetch(SavedNews.fetchRequest())
                if let savedNew = results.first(where: { $0.title == title }) {
                    context.delete(savedNew)
                    appDelegate.saveContext()
                    isSaved = false
                }
            } catch {
                print(error.localizedDescription)
            }
        }
        
        return isSaved
    }
    
    init() {
        
    }
}
