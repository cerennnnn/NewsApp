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
    var indexPath: Int?
    var safeNewsArr = [SavedNews]()
    
    func changeSaveButton(button: UIBarButtonItem, isSaved: Bool){
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
        }
    }
    
    func fetchNews(isSaved: Bool) -> Bool {
        do {
            let id = news?.source?.id
            let results = try context.fetch(SavedNews.fetchRequest())
            if let savedNew = results.first(where: { $0.id == id }) {
                context.delete(savedNew)
                appDelegate.saveContext()
            }
        } catch {
            print(error.localizedDescription)
        }
        return isSaved
    }
}
