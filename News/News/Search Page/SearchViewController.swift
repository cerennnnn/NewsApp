//
//  SearchViewController.swift
//  News
//
//  Created by Ceren Güneş on 17.09.2023.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var searchTableView: UITableView!
    
    let searchViewModel = SearchViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Search"
        
        setupSearchBar()
        setupTableView()
        
        searchViewModel.loadNews()
        searchViewModel.onSuccess = reloadTableView()
    }
    
    private func setupSearchBar() {
        searchBar.delegate = self
    }
    
    private func setupTableView() {
        searchTableView.delegate = self
        searchTableView.dataSource = self
    }
    
    private func reloadTableView() -> () -> () {
        return {
            DispatchQueue.main.async {
                self.searchTableView.reloadData()
            }
        }
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText == "" {
            searchViewModel.loadNews()
        } else {
            searchViewModel.loadNews(searchText: searchText)
        }
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchViewModel.news?.count ?? 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: SearchBarTableViewCell.identifier, for: indexPath) as? SearchBarTableViewCell {
            if let selectedItem = searchViewModel.cellForRow(at: indexPath) {
                cell.searchTableViewTitleLabel.text = selectedItem.title
                cell.searchTableViewDescriptionLabel.text = selectedItem.description
                
                if selectedItem.urlToImage == nil {
                    cell.searchTableViewImageView.sd_setImage(with: URL(string: "https://i.pinimg.com/474x/95/31/7c/95317ca5719667e280e9861b01577934.jpg"))
                } else {
                    cell.searchTableViewImageView.sd_setImage(with: URL(string: selectedItem.urlToImage!))
                }
            }
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
