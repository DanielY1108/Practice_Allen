//
//  CoreDataManager.swift
//  ToDoApp
//
//  Created by JinSeok Yang on 2022/10/17.
//

import UIKit
import CoreData

class CoreDataManager {
    
    static var shared = CoreDataManager()
    private init() {}
    
    // 앱 델리게이트에 접근
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    // 임시저장소
    lazy var context = appDelegate?.persistentContainer.viewContext
    
    // 엔티티 이름 (코어데이터에 저장된 객체)
    let modelName: String = "ToDoData"
    
    // MARK: - CRUD의 [READ] 코어데이터에 저장된 데이터 모두 읽어오기
    
    func getToDoListFromCoreData() -> [ToDoData] {
        // 쓰고 싶은 데이터를 빈 배열로 만들기
        var toDoList: [ToDoData] = []
        // 임시저장소 있는지 확인 (옵셔널이기 때문에 바인딩)
        if let context = context {
            // 요청서 만들기 "NSManagedObject" 대신 실제 데이터인 "ToDoData" 넣으면 명확하게 나타낼 수 있어서 밑의 타입캐스팅이 필요없긴하다.
            let request = NSFetchRequest<NSManagedObject>(entityName: self.modelName)
            // 정렬순서를 정해서 요청서에 넘겨주기 ("date"를 기준으로 정렬), ascending: 오름차순
            let dateOrder = NSSortDescriptor(key: "date", ascending: false)
            request.sortDescriptors = [dateOrder]
            
            do {
                //
                if let fetchedToDoList = try context.fetch(request) as? [ToDoData] {
                    toDoList = fetchedToDoList
                }
            } catch {
                print("가져오기 실패")
            }
        }
        return toDoList
    }

    // MARK: - CRUD의 [Create] 코어데이터에 데이터 생성하기
    
    // 저장할 속성들을 파라미터로 정의한다
    func saveToDoData(toDoText: String?, colorInt: Int64, completion: @escaping () -> Void) {
        // 임시저장소 있는지 확인
        if let context = context {
            // 임시저장소에 있는 데이터를 그려줄 형태 파악하기
            if let entity = NSEntityDescription.entity(forEntityName: self.modelName, in: context) {
                
                // 임시저장소에 올라가게 할 객체만들기 (NSManagedObject ===> ToDoData)
                // let toDoData = ToDoData(context: context) 이와같이 사용도 가능하다
                if let toDoData = NSManagedObject(entity: entity, insertInto: context) as? ToDoData {
                    
                    // MARK: - ToDoData에 실제 데이터 할당 ⭐️
                    toDoData.memoText = toDoText
                    toDoData.date = Date()   // 날짜는 저장하는 순간의 날짜로 생성
                    toDoData.color = colorInt
                    
                    //appDelegate?.saveContext() // 앱델리게이트의 메서드로 사용해도 됨 ⭐️ 아래의 if문 전체와 같은 기능을 한다
                    if context.hasChanges {
                        do {
                            try context.save()
                            completion()
                        } catch {
                            print(error)
                            completion()
                        }
                    }
                }
            }
        }
        completion()
    }
    
    // MARK: - CRUD의 [Delete] 코어데이터에서 데이터 삭제하기 (일치하는 데이터 찾아서 ===> 삭제)
    
    func deleteToDo(data: ToDoData, completion: @escaping () -> Void) {
        // 날짜 옵셔널 바인딩 (날짜 기준으로 데이터를 만들었으니)
        guard let date = data.date else {
            completion()
            return
        }
        
        // 임시저장소 있는지 확인
        if let context = context {
            // 요청서
            let request = NSFetchRequest<NSManagedObject>(entityName: self.modelName)
            // predicate: 단서 / 찾기 위한 조건 설정
            request.predicate = NSPredicate(format: "date = %@", date as CVarArg)
            
            do {
                // 요청서를 통해서 데이터 가져오기 (조건에 일치하는 데이터 찾기) (fetch메서드)
                if let fetchedToDoList = try context.fetch(request) as? [ToDoData] {
                    
                    // 임시저장소에서 (요청서를 통해서) 데이터 삭제하기 (delete메서드)
                    if let targetToDo = fetchedToDoList.first {
                        context.delete(targetToDo)
                        
                        //appDelegate?.saveContext() // 앱델리게이트의 메서드로 해도됨 ⭐️
                        if context.hasChanges {
                            do {
                                try context.save()
                                completion()
                            } catch {
                                print(error)
                                completion()
                            }
                        }
                    }
                }
                completion()
            } catch {
                print("지우는 것 실패")
                completion()
            }
        }
    }
    
    // MARK: - CRUD의 [Update] 코어데이터에서 데이터 수정하기 (일치하는 데이터 찾아서 ===> 수정)
    
    func updateToDo(newToDoData: ToDoData, completion: @escaping () -> Void) {
        // 날짜 옵셔널 바인딩
        guard let date = newToDoData.date else {
            completion()
            return
        }
        
        // 임시저장소 있는지 확인
        if let context = context {
            // 요청서
            let request = NSFetchRequest<NSManagedObject>(entityName: self.modelName)
            // 단서 / 찾기 위한 조건 설정
            request.predicate = NSPredicate(format: "date = %@", date as CVarArg)
            
            do {
                // 요청서를 통해서 데이터 가져오기
                if let fetchedToDoList = try context.fetch(request) as? [ToDoData] {
                    // 배열의 첫번째
                    if var targetToDo = fetchedToDoList.first {
                        
                        // MARK: - ToDoData에 실제 데이터 재할당(바꾸기) ⭐️
                        targetToDo = newToDoData
                        
                        //appDelegate?.saveContext() // 앱델리게이트의 메서드로 해도됨 ⭐️
                        if context.hasChanges {
                            do {
                                try context.save()
                                completion()
                            } catch {
                                print(error)
                                completion()
                            }
                        }
                    }
                }
                completion()
            } catch {
                print("지우는 것 실패")
                completion()
            }
        }
    }
}
