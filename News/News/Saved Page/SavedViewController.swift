//
//  SavedViewController.swift
//  News
//
//  Created by Ceren Güneş on 17.09.2023.
//

import CoreData
import UIKit

class SavedNewsViewController: UIViewController {
    
    @IBOutlet weak var savedNewsTableView: UITableView!
        
    let savedNewsViewModel = SavedNewsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        loadItems()
    }
    
    private func setupTableView() {
        savedNewsTableView.delegate = self
        savedNewsTableView.dataSource = self
    }
    
    private func saveItems() {
        savedNewsViewModel.saveItems()
    }
    
    private func deleteItems(indexPath: Int) {
        savedNewsViewModel.deleteItems(indexPath: indexPath)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadItems()
    }
    
    func loadItems() {
        savedNewsViewModel.fetchNews()
        savedNewsTableView.reloadData()
    }
}

extension SavedNewsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedNewsViewModel.safeNewsArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SavedNewsTableViewCell", for: indexPath) as!
        SavedNewsTableViewCell
        let selectedNew = savedNewsViewModel.safeNewsArr[indexPath.row]
        
        cell.savedNewsTitleLabel.text = selectedNew.title
        cell.savedNewsDescriptionLabel.text = selectedNew.desc
        cell.savedNewsImageView.sd_setImage(with: URL(string: selectedNew.image ?? "people.fill"))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
  
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            savedNewsViewModel.deleteItems(indexPath: savedNewsViewModel.indexPath ?? 0)
            tableView.deleteRows(at: [indexPath], with: .bottom)
        }
    }
}
