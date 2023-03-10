//
//  DataPersistanceManager.swift
//  Netflix Clone
//
//  Created by 김준혁 on 2023/02/05.
//

import Foundation
import UIKit
import CoreData



class DataPersistanceManager {
    static let shared = DataPersistanceManager()
    
    enum DatabaseError : Error {
        case failedToSaveData
        case failedToFetchData
        case failedToDeleteData
    }
    
    
    func downloadTitleWith(model: Title , completion: @escaping (Result<Void, Error>) -> Void) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext // get the storage
        let item = TitleItem(context: context) // TitleItem -> put it context
        
        item.original_title = model.original_title
        item.id = Int64(model.id)
        item.original_name = model.original_name
        item.overview = model.overview
        item.media_type = model.media_type
        item.poster_path = model.poster_path
        item.release_date = model.release_date
        item.vote_count = Int64(model.vote_count)
        item.vote_average = model.vote_average
        
        do {
            try context.save()
            completion(.success(())) // send empty tuple so it's safe now
        } catch {
            completion(.failure(DatabaseError.failedToSaveData))
        }
    }
    
    func fetchingTitlesFromDataBase(completion: @escaping (Result<[TitleItem], Error>) -> Void) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext // get the storage
        
        let request: NSFetchRequest<TitleItem>
        request = TitleItem.fetchRequest()
        
        do {
            let titles = try context.fetch(request)
            completion(.success(titles))
        
            
        } catch {
            completion(.failure(DatabaseError.failedToFetchData))
        }
        
    }
    
    
    
    func deleteTitleWith(model: TitleItem, completion: @escaping (Result<Void, Error>)-> Void) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext // get the storage
        
        context.delete(model) // hey manager plz delete that model!
        
        do {
            try context.save()
            completion(.success(()))
        } catch {
            completion(.failure(DatabaseError.failedToDeleteData))
        }
        
        
    }
    
}
