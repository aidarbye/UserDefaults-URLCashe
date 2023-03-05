import UIKit
/* Tasks in this VC
 Add life cycles methods - layout
 Maybe some more? idk some layout things and UI/UX
*/
protocol AddNewContactViewControllerDelegate {
    func saveContact(_ contact: Contact)
}

class AddNewContactViewController: UIViewController {
    // MARK: Properties
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var doneButton: UIBarButtonItem! { didSet { doneButton.isEnabled = false } }
    @IBOutlet weak var firstNameTextField: UITextField!
    /* Delegate */
    var delegate: AddNewContactViewControllerDelegate!
    override func viewDidLoad() {
        super.viewDidLoad()
        addTargets()
    }
    @IBAction func doneAction(_ sender: Any) {
        saveAndExit()
    }
    @IBAction func cancelAction(_ sender: Any) {
        dismiss(animated: true)
    }
}
// MARK: Functions
extension AddNewContactViewController {
    private func addTargets() {
        firstNameTextField.addTarget(self, action: #selector(didChanged), for: .editingChanged)
        lastNameTextField.addTarget(self, action: #selector(didChanged), for: .editingChanged)
    }
    @objc private func didChanged() {
        guard let first = firstNameTextField.text else { return }
        guard let last  = lastNameTextField.text else { return }
        doneButton.isEnabled = !first.isEmpty && !last.isEmpty ? true : false
    }
    private func saveAndExit() {
        guard let first = firstNameTextField.text else { return }
        guard let last  = lastNameTextField.text else { return }
        let contact: Contact = Contact(firstName: first, lastName: last)
        StorageManager.shared.saveToFile(with: contact)
        delegate.saveContact(contact)
        dismiss(animated: true)
    }
}
