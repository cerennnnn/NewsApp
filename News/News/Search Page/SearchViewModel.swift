//
//  SearchViewModel.swift
//  News
//
//  Created by Ceren Güneş on 18.09.2023.
//

import Foundation

//https://newsapi.org/v2/everything?q=Apple&from=2023-09-11&sortBy=popularity&apiKey=a04d4753e1b0457a9da5fe7e632614c1

final class SearchViewModel {
    
    var onSuccess: (() -> ())?
    var onError: ((_ errorStr: String) -> ())?
    var news: [News]?
    
    func loadNews() {
        NetworkManager.shared.fetchNews(url: URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=cb8a8fa75db0409d9d6658979e7ac5d6")!) {
            result in
            switch result {
            case .success(let success):
                self.news = success.articles
                self.onSuccess?()
            case .failure(let failure):
                self.onError?(failure.localizedDescription)
            }
        }
    }
    
    func loadNews(searchText: String) {
        NetworkManager.shared.fetchNews(url: URL(string: "https://newsapi.org/v2/everything?q=\(searchText)&from=2023-09-11&sortBy=popularity&apiKey=cb8a8fa75db0409d9d6658979e7ac5d6")!) { result in
            switch result {
            case .success(let success):
                self.news = success.articles
                self.onSuccess?()
            case .failure(let failure):
                self.onError?(failure.localizedDescription)
            }
        }
    }
    
    func cellForRow(at indexPath: IndexPath) -> News? {
        return news?[indexPath.row]
    }
    
    func numberOfRows(in section: Int) -> Int {
        return news?.count ?? 0
    }
}

