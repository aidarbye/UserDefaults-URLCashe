import UIKit

class ContactsTableViewController: UITableViewController {
    @IBOutlet weak var MainTableView: UITableView!
    private var contacts: [Contact] = []
    override func viewDidLoad() { contacts = StorageManager.shared.fetchFromFile() }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let AddNewVC = segue.destination as! AddNewContactViewController
        AddNewVC.delegate = self
    }
}
extension ContactsTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contact_cell", for: indexPath) as! ContactTableViewCell
        let contact = contacts[indexPath.row]
        cell.fullNameText.text = contact.fullname
        return cell
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            contacts.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            StorageManager.shared.deleteFromFile(at: indexPath.row)
        }
    }
}
extension ContactsTableViewController: AddNewContactViewControllerDelegate {
    func saveContact(_ contact: Contact) {
        contacts.append(contact)
        MainTableView.reloadData()
    }
}
