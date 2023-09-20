//
//  SavedNewsViewModel.swift
//  News
//
//  Created by Ceren Güneş on 19.09.2023.
//

import CoreData
import UIKit

final class SavedNewsViewModel {
    let context = appDelegate.persistentContainer.viewContext
    var safeNewsArr = [SavedNews]()
    var indexPath: Int?
    
    func fetchNews() {
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
    
    func deleteItems(indexPath: Int) {
        context.delete(safeNewsArr.remove(at: indexPath))
        
        saveItems()
    }
}


