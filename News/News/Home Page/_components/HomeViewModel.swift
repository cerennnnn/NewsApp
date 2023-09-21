//
//  HomeViewModel.swift
//  News
//
//  Created by Ceren Güneş on 18.09.2023.
//

import Foundation

final class HomeViewModel {
    
    var onSuccess: (() -> ())?
    var onError: ((_ errorStr: String) -> ())?
    var news: [News]?
    var indexPathNew: News?
    var indexPath: Int?
    
    func loadNews() {
        NetworkManager.shared.fetchNews(url: URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=cb8a8fa75db0409d9d6658979e7ac5d6")!) { result in
            
            switch result {
            case .success(let success):
                self.news = success.articles
                self.onSuccess?()
            case .failure(let failure):
                self.onError?(failure.localizedDescription)
            }
        }
    }
    
    func loadNews(category: String) {
        NetworkManager.shared.fetchNews(url: URL(string: "https://newsapi.org/v2/everything?q=\(category)&from=2023-09-11&sortBy=popularity&apiKey=cb8a8fa75db0409d9d6658979e7ac5d6")!) { result in
            switch result {
            case .success(let success):
                self.news = success.articles
                self.onSuccess?()
            case .failure(let failure):
                self.onError?(failure.localizedDescription)
            }
        }
    }
    
    func cellForItem(at indexPath: IndexPath) -> News {
        self.indexPathNew = news![indexPath.row]
        return news![indexPath.row]
    }
    
    func numberOfItems(in section: Int) -> Int {
        return news?.count ?? 0
    }
}
