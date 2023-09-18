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
        
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var safeNewsArr = [SavedNews]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        loadItems()
    }
    
    private func setupTableView() {
        savedNewsTableView.delegate = self
        savedNewsTableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadItems()
    }
    
    func loadItems() {
        let request: NSFetchRequest<SavedNews> = SavedNews.fetchRequest()
        
        do {
             safeNewsArr = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
        savedNewsTableView.reloadData()
    }
}

extension SavedNewsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return safeNewsArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SavedNewsTableViewCell", for: indexPath) as!
        SavedNewsTableViewCell
        let selectedNew = safeNewsArr[indexPath.row]
        
        cell.savedNewsTitleLabel.text = selectedNew.title
        cell.savedNewsDescriptionLabel.text = selectedNew.desc
        cell.savedNewsImageView.sd_setImage(with: URL(string: selectedNew.image ?? "people.fill"))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        
    }
    
}
