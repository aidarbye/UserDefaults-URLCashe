import Foundation
class StorageManager {
    //MARK: Singleton
    static let shared = StorageManager()
    
    private let userDefault = UserDefaults.standard
    private let contactKey = "contact"
    private let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    private var archiveURL: URL
    
    init() {
        archiveURL = documentDirectory
            .appending(component: "contact")
            .appendingPathExtension("plist")
    }
    /*
    func save(_ contact: Contact) {
        var contacts = fetchContacts()
        contacts.append(contact)
        guard let data = try? JSONEncoder().encode(contacts) else { return }
        userDefault.setValue(data, forKey: contactKey)
    }
    func fetchContacts() -> [Contact] {
        guard let data = userDefault.object(forKey: contactKey) as? Data else { return [] }
        guard let contacts = try? JSONDecoder().decode([Contact].self, from: data) else { return [] }
        return contacts
    }
    func deleteContact(at index: Int) {
        var contacts = fetchContacts()
        contacts.remove(at: index)
        guard let data = try? JSONEncoder().encode(contacts) else { return }
        userDefault.setValue(data, forKey: contactKey)
    }
    */
    func saveToFile(with contact: Contact) {
        var contacts = fetchFromFile()
        contacts.append(contact)
        guard let data = try? PropertyListEncoder().encode(contacts) else { return }
        try? data.write(to: archiveURL,options: .noFileProtection)
    }
    func fetchFromFile() -> [Contact] {
        guard let data = try? Data(contentsOf: archiveURL) else { return [] }
        guard let contacts = try? PropertyListDecoder().decode([Contact].self, from: data) else { return [] }
        return contacts
    }
    func deleteFromFile(at index: Int) {
        var contacts = fetchFromFile()
        contacts.remove(at: index)
        guard let data = try? PropertyListEncoder().encode(contacts) else { return }
        try? data.write(to: archiveURL,options: .noFileProtection)
    }
}
