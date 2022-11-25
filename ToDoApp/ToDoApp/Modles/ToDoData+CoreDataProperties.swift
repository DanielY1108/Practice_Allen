//
//  ToDoData+CoreDataProperties.swift
//  ToDoApp
//
//  Created by JinSeok Yang on 2022/10/18.
//
//

import Foundation
import CoreData


extension ToDoData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDoData> {
        return NSFetchRequest<ToDoData>(entityName: "ToDoData")
    }

    @NSManaged public var color: Int64
    @NSManaged public var date: Date?
    @NSManaged public var memoText: String?


// (출시 정보에 대한 날짜를 잘 계산하기 위해서) 계산 속성으로
    // "2011-07-05T12:00:00Z" ===> "yyyy-MM-dd"
    var dateString: String? {
        // 서버에서 주는 형태 (ISO규약에 따른 문자열 형태)
        guard let isoDate = self.date else { return "" }
        let myFormatter = DateFormatter()
        myFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = myFormatter.string(from: isoDate)
        return dateString
    }
}
    


extension ToDoData : Identifiable {

}
