import Foundation

struct Contact: Codable {
    let firstName: String
    let lastName: String
    var fullname: String {
        "\(firstName) \(lastName)"
    }
}
