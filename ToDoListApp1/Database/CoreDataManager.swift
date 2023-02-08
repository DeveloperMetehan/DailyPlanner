import UIKit
import CoreData

protocol DataBaseProtocol {
    func fetchAll<M: DataBaseEntity>(entityType: M.Type, completion: @escaping (Result<[M], DataBaseError>) -> Void)
    func insert<M: DataBaseEntity>(entity: M) -> M
    func update<M: DataBaseEntity>(entity: M) -> M
    func delete<M: DataBaseEntity>(entity: M)
}

final class CoreDataManager: DataBaseProtocol {
    static let shared = CoreDataManager(modelName: "ToDoListApp1")
    private let modelName: String
    
    private init(modelName: String) {
        self.modelName = modelName
        setupNotificationHandling()
    }
    
    private lazy var container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: modelName)
        container.loadPersistentStores { description, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    func fetchAll<M: DataBaseEntity>(entityType: M.Type, completion: @escaping (Result<[M], DataBaseError>) -> Void) {
        do {
            let result = try container.viewContext.fetch(entityType.getFetchRequest())
            guard let convertedResult = (result as? [M.DBObject])?.convert() as? [M] else {
                completion(.failure(.casting("Could not casted to \(String(describing: entityType))")))
                return
            }
            completion(.success(convertedResult))
        } catch {
            completion(.failure(.fetching(error.localizedDescription)))
        }
    }
    
    func insert<M: DataBaseEntity>(entity: M) -> M {
        let newEntity = entity.insertToDB(context: container.viewContext)
        return newEntity
    }
    
    func update<M: DataBaseEntity>(entity: M) -> M {
        let updatedEntity = entity.updateInDb(context: container.viewContext)
        return updatedEntity
    }
    
    func delete<M: DataBaseEntity>(entity: M) {
        guard let id = entity.dbId else {
            print("DBId is nil")
            return
        }
        let objectWillBeDeleted = container.viewContext.object(with: id)
        container.viewContext.delete(objectWillBeDeleted)
    }
    
    private func setupNotificationHandling() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self,
                                       selector: #selector(saveChanges),
                                       name: UIApplication.willTerminateNotification,
                                       object: nil)

        notificationCenter.addObserver(self,
                                       selector: #selector(saveChanges),
                                       name: UIApplication.didEnterBackgroundNotification,
                                       object: nil)
    }
    
    @objc private func saveChanges() {
        container.viewContext.perform {
            do {
                if self.container.viewContext.hasChanges {
                    try self.container.viewContext.save()
                }
            } catch {
                print("Unable to Save Changes of Managed Object Context")
                print("\(error), \(error.localizedDescription)")
            }
        }
    }
}

protocol DataBaseEntity {
    var dbId: NSManagedObjectID? {get set}
    static func getFetchRequest<M: NSManagedObject>() -> NSFetchRequest<M>
    typealias DBObject = DBEntityConvertable
    func insertToDB(context: NSManagedObjectContext) -> Self
    func updateInDb(context: NSManagedObjectContext) -> Self
}

protocol DBEntityConvertable {
    func convert() -> DataBaseEntity
}

extension Array where Element == DBEntityConvertable {
    func convert() -> [DataBaseEntity] {
        return self.map { $0.convert() }
    }
}

enum DataBaseError: Error {
    case fetching(String)
    case casting(String)
}
