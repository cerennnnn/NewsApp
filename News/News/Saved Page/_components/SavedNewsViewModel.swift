//
//  SavedNewsViewModel.swift
//  News
//
//  Created by Ceren Güneş on 19.09.2023.
//

import CoreData
import UIKit

final class SavedNewsViewModel {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var indexPath: Int?
    var safeNewsArr = [SavedNews]()
    
    func loadItems() {
        let request: NSFetchRequest<SavedNews> = SavedNews.fetchRequest()
        
        do {
             safeNewsArr = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
    }
    
    func saveItems() {
        do {
            try context.save()
        } catch {
            print("Error saving context \(error)")
        }
    }
    
//    func cellForItem(at indexPath: IndexPath) -> News {
//        self.indexPathNew = news![indexPath.row]
//        return news![indexPath.row]
//    }
//    
//    func numberOfItems(in section: Int) -> Int {
//        return news?.count ?? 0
//    }
    
    func editingStyle() {
        
    }
}


