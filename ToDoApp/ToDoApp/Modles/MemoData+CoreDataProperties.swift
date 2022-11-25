//
//  MemoData+CoreDataProperties.swift
//  ToDoApp
//
//  Created by JinSeok Yang on 2022/10/17.
//
//

import Foundation
import CoreData


extension MemoData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MemoData> {
        return NSFetchRequest<MemoData>(entityName: "MemoData")
    }

    @NSManaged public var memoText: String?
    @NSManaged public var color: Int64
    @NSManaged public var date: Date?

}

extension MemoData : Identifiable {

}
