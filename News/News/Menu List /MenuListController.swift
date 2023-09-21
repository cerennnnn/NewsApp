//
//  MenuListController.swift
//  News
//
//  Created by Ceren Güneş on 18.09.2023.
//

import UIKit

enum Items: String {
    case business = "Business"
    case entertainment = "Entertainment"
    case general = "General"
    case health = "Health"
    case science = "Science"
    case sports = "Sports"
    case technology = "Technology"
}

class MenuListController: UITableViewController {
    
    let menuListViewModel = MenuListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = .systemOrange
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuListViewModel.items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.textColor = .white
        cell.textLabel?.text = menuListViewModel.items[indexPath.row].rawValue
        cell.backgroundColor = .systemOrange
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let selectedItem = menuListViewModel.items[indexPath.row]
        let storyboard = UIStoryboard(name: "HomeViewController", bundle: nil)
        
        guard let vc = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController else { return }
        vc.homeViewModel.loadNews(category: selectedItem.rawValue.lowercased())
        vc.title = selectedItem.rawValue.uppercased()

        self.navigationController?.pushViewController(vc, animated: true)
    }
}



