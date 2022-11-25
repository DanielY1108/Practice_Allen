//
//  MusicSaved+CoreDataProperties.swift
//  MusicApp
//
//  Created by JinSeok Yang on 2022/10/19.
//
//

import Foundation
import CoreData


extension MusicSaved {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MusicSaved> {
        return NSFetchRequest<MusicSaved>(entityName: "MusicSaved")
    }
    
    @NSManaged public var artworkUrl100: String?
    @NSManaged public var artistName: String?
    @NSManaged public var trackName: String?
    @NSManaged public var collectionName: String?
    @NSManaged public var previewURL: String?
    @NSManaged public var genreName: String?
    @NSManaged public var releaseDate: String?
    
    @NSManaged public var saveDate: Date?

    
    var saveDateString: String? {
        let myFormatter = DateFormatter()
        myFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = saveDate else { return "" }
        let dateString = myFormatter.string(from: date)
        return dateString
    }
    
    @NSManaged public var myMessege: String?


}

extension MusicSaved : Identifiable {

}
