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

    let items: [Items] = [.business, .entertainment, .general, .health, .science, .sports, .technology]
    let color = UIColor(red: 33/255.0, green: 33/255.0, blue: 33/255.0, alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = color
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.textColor = .white
        cell.textLabel?.text = items[indexPath.row].rawValue
        cell.backgroundColor = color
        
        return cell
    }
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//
//        let selectedItem = items[indexPath.row]
//        let storyboard = UIStoryboard(name: "HomeViewController", bundle: nil)
//
//        guard let tabBar = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController else { return }
//
//
//        tabBar.homeViewModel.loadNews(category: selectedItem.rawValue.lowercased())
//            navigationController?.pushViewController(tabBar, animated: true)
//        }
        
    }


