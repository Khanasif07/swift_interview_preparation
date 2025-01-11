//: [Previous](@previous)

import Foundation
import UIKit

//: [Next](@next)
//The Singleton pattern ensures that only one instance of a class is created and provides a global point of access to that instance. This is useful when you need to share resources, like network managers or configuration files, across the app.
final class NetworkManager {
    static let shared = NetworkManager() // Singleton instance

    private init() {}  // Private initializer to prevent instantiation

    func fetchData(from url: URL, completion: @escaping (Data?, Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            completion(data, error)
        }
        task.resume()
    }
}

// Usage
NetworkManager.shared.fetchData(from: URL(string: "https://example.com")!) { data, error in
    // Handle the response
}

//The Factory pattern provides a way to create objects without specifying the exact class of object that will be created. This is useful when the object creation process is complex or when subclasses are involved.
//Creating different types of UIView based on a condition.
//Daily Use Example: Creating ViewControllers based on screen flow
protocol Button {
    func render() -> String
}

class PrimaryButton: Button {
    func render() -> String {
        return "Primary Button Rendered"
    }
}

class SecondaryButton: Button {
    func render() -> String {
        return "Secondary Button Rendered"
    }
}

class ButtonFactory {
    static func createButton(ofType type: String) -> Button {
        switch type {
        case "Primary":
            return PrimaryButton()
        case "Secondary":
            return SecondaryButton()
        default:
            return PrimaryButton()
        }
    }
}
//The Adapter pattern allows incompatible interfaces to work together. It acts as a bridge between two objects that are incompatible with each other.
//
//Real-world example: Adapting data from an API to fit into your model.

// Third-party library class (incompatible)
class ThirdPartyJSONService {
    func fetchJSONData() -> [String: Any] {
        return ["id": 123, "name": "Alice"]
    }
}

// Target model that our app uses
struct UserModel {
    let id: Int
    let name: String
}

// Adapter class
class JSONAdapter {
    let jsonService: ThirdPartyJSONService

    init(service: ThirdPartyJSONService) {
        self.jsonService = service
    }

    func getUserModel() -> UserModel {
        let data = jsonService.fetchJSONData()
        let id = data["id"] as! Int
        let name = data["name"] as! String
        return UserModel(id: id, name: name)
    }
}

// Usage
let jsonService = ThirdPartyJSONService()
let adapter = JSONAdapter(service: jsonService)
let user = adapter.getUserModel()
print(user.name)  // Output: Ali


//Real-world example: Facade for networking, database, and authentication in an e-commerce app
//Imagine an e-commerce app that needs to handle user login, fetching products from a server, and storing them in a local database (Core Data). These tasks are typically handled by separate components (authentication service, network service, and database service). By using the Facade Pattern, we can hide these complexities and expose a simple API to the rest of the app.

//SSl-> CA-> certificate authority -> exm :) DigiCert..create signature with the help of self p.key and server.key.
//TLS
//integrity
//authentication
//confidentiality

//The Decorator pattern allows behavior to be added to an individual object, dynamically, without affecting the behavior of other objects from the same class.


// Basic UIView
class SimpleView: UIView {
    override func draw(_ rect: CGRect) {
        print("Drawing simple view...")
    }
}

// Decorator for adding a border
class BorderedView: UIView {
    private let decoratedView: UIView

    init(view: UIView) {
        self.decoratedView = view
        super.init(frame: view.frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func draw(_ rect: CGRect) {
        decoratedView.draw(rect)
        addBorder()
    }

    private func addBorder() {
        print("Adding border to the view...")
    }
}

// Usage
let simpleView = SimpleView()
let borderedView = BorderedView(view: simpleView)
borderedView.draw(CGRect(x: 0, y: 0, width: 100, height: 100))
// Output:
// Drawing simple view...
// Adding border to the view...


// Open closed principle
enum DeeplinkType {
    case home
    case profile
    case setting // modifiction
}

protocol Deeplink {
    var type: DeeplinkType { get }
    func execute()
}

class HomeDeeplink: Deeplink {
    let type: DeeplinkType = .home

    func executeHome() {
        // Presents the main screen
    }
    
    func execute() {
        print(type)
    }
}

class SettingDeepLink: Deeplink{
    var type: DeeplinkType = .setting
    func executeSetting() {
        // Presents the main screen
    }
    
    func execute() {
        print(type)
    }
}
class ProfileDeeplink: Deeplink {
    let type: DeeplinkType = .profile

    func executeProfile() {
        // Presents the profile screen
    }
    
    func execute() {
        print(type)
    }
}

final class Router {
    init(){}
    static let shared = Router()
    func execute(_ deeplink: Deeplink) {
        deeplink.execute()
        //        switch deeplink.type {
        //        case .home:
        //            (deeplink as? HomeDeeplink)?.executeHome()
        //        case .profile:
        //            (deeplink as? ProfileDeeplink)?.executeProfile()
        //        case .setting:
        //            (deeplink as? SettingDeepLink)?.executeSetting()
        //        }
    }
}

let setting = SettingDeepLink()
Router.shared.execute(setting.self)

//vvimp
//liskov substitution principle
protocol Payment {
    func process(amount: Double)
}

class CreditCardPayment: Payment {
    func process(amount: Double) {
        print("Processing credit card payment of $\(amount)")
    }
}

class PayPalPayment: Payment {
    func process(amount: Double) {
        print("Processing PayPal payment of $\(amount)")
    }
}

// Now, let's introduce a special class that requires additional setup:
class CryptoPayment: Payment {
    var isWalletSetUp: Bool = false
    func setUpWallet() {
        // Setup crypto wallet
        isWalletSetUp = true
        print("Crypto wallet setup complete.")
    }
    func process(amount: Double) {
        if !isWalletSetUp {
            print("Cannot process payment: Wallet is not set up.")
            return
        }
        print("Processing crypto payment of $\(amount)")
    }
}


//Dependency Inversion
// Define the abstraction (protocol) High-level modules (business logic) should not depend on low-level modules (implementation details). Both should depend on abstractions (e.g., protocols).
protocol DataFetching {
    func fetchData()
}

// Create the concrete implementation of the protocol
class APIService: DataFetching {
    func fetchData() {
        print("Fetching data from network...")
    }
}

// Mock implementation for testing
class MockAPIService: DataFetching {
    func fetchData() {
        print("Mock data for testing.")
    }
}

// ViewController depends on abstraction (DataFetching) rather than concrete implementation
class ViewController {
    let dataFetcher: DataFetching

    // Injecting the dependency via initializer
    init(dataFetcher: DataFetching) {
        self.dataFetcher = dataFetcher
    }

    func displayData() {
        dataFetcher.fetchData()
        // Display data in the UI
    }
}
