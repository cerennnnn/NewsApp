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
    
    
    func fetchNews() {
        let request: NSFetchRequest<SavedNews> = SavedNews.fetchRequest()
        
        do {
             safeNewsArr = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
    }
}


