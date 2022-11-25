//
//  MusicManger.swift
//  MusicApp
//
//  Created by JinSeok Yang on 2022/10/19.


import UIKit
import CoreData

final class CoreDataManager {
    
    static var shared = CoreDataManager()
    private init() {}
    
    // 앱 델리게이트에 접근
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    // 임시저장소
    lazy var context = appDelegate?.persistentContainer.viewContext
    
    // 엔티티 이름 (코어데이터에 저장된 객체)
    let modelName: String = "MusicSaved"
    
    // MARK: - CRUD의 [READ] 코어데이터에 저장된 데이터 모두 읽어오기
    
    func getMusicSavedFromCoreData() -> [MusicSaved] {
        // 쓰고 싶은 데이터를 빈 배열로 만들기
        var savedMusicList: [MusicSaved] = []
        // 임시저장소 있는지 확인 (옵셔널이기 때문에 바인딩)
        if let context = context {
            // 요청서 만들기 "NSManagedObject" 대신 실제 데이터인 "ToDoData" 넣으면 명확하게 나타낼 수 있어서 밑의 타입캐스팅이 필요없긴하다.
            let request = NSFetchRequest<NSManagedObject>(entityName: self.modelName)
            // 정렬순서를 정해서 요청서에 넘겨주기 ("date"를 기준으로 정렬), ascending: 오름차순
            let dateOrder = NSSortDescriptor(key: "saveDate", ascending: true)
            request.sortDescriptors = [dateOrder]
            
            do {
                //
                if let fetchedMusicSaved = try context.fetch(request) as? [MusicSaved] {
                    savedMusicList = fetchedMusicSaved
                    print("읽기 성공")
                }
            } catch {
                print("가져오기 실패")
            }
        }
        return savedMusicList
    }

    // MARK: - CRUD의 [Create] 코어데이터에 데이터 생성하기

    // 저장할 속성들을 파라미터로 정의한다
    func saveMusicSavedData(with music: Music, myMessege: String?, completion: @escaping () -> Void) {
        // 임시저장소 있는지 확인
        if let context = context {
            debugPrint(context)
            // 임시저장소에 있는 데이터를 그려줄 형태 파악하기
            if let entity = NSEntityDescription.entity(forEntityName: self.modelName, in: context) {
                
                // 임시저장소에 올라가게 할 객체만들기 (NSManagedObject ===> ToDoData)
                // let toDoData = ToDoData(context: context) 이와같이 사용도 가능하다
                if let MusicSaved = NSManagedObject(entity: entity, insertInto: context) as? MusicSaved {

                    // MARK: - ToDoData에 실제 데이터 할당 ⭐️
                    MusicSaved.trackName = music.trackName
                    MusicSaved.artistName = music.artistName
                    MusicSaved.collectionName = music.collectionName
                    MusicSaved.artworkUrl100 = music.artworkUrl100
                    MusicSaved.genreName = music.genreName
                    MusicSaved.releaseDate = music.releaseDateString
                    MusicSaved.previewURL = music.previewURL
                    
                    MusicSaved.myMessege = myMessege
                    MusicSaved.saveDate = Date()   // 날짜는 저장하는 순간의 날짜로 생성
                    
                    appDelegate?.saveContext()  // 앱델리게이트의 메서드로 사용해도 됨 ⭐️ 아래의 if문 전체와 같은 기능을 한다
                    
                }
            }
        }
        completion()
    }
    
    // MARK: - CRUD의 [Delete] 코어데이터에서 데이터 삭제하기 (일치하는 데이터 찾아서 ===> 삭제)

    func deleteMusicSaved(data: MusicSaved, completion: @escaping () -> Void) {
        // 날짜 옵셔널 바인딩 (날짜 기준으로 데이터를 만들었으니)
        guard let date = data.saveDate else {
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
                if let fetchedMusicSaved = try context.fetch(request) as? [MusicSaved] {
                    
                    // 임시저장소에서 (요청서를 통해서) 데이터 삭제하기 (delete메서드)
                    if let targetMusicSaved = fetchedMusicSaved.first {
                        context.delete(targetMusicSaved)
                        print("삭제 성공")
                        
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

    func updateMusicSaved(newMusicSavedData: MusicSaved, completion: @escaping () -> Void) {
        // 날짜 옵셔널 바인딩
        guard let date = newMusicSavedData.saveDate else {
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
                if let fetchedMusicSaved = try context.fetch(request) as? [MusicSaved] {
                    // 배열의 첫번째
                    if var targetMusicSaved = fetchedMusicSaved.first {
                        
                        // MARK: - ToDoData에 실제 데이터 재할당(바꾸기) ⭐️
                        targetMusicSaved = newMusicSavedData
                        
//                        appDelegate?.saveContext() // 앱델리게이트의 메서드로 해도됨
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
