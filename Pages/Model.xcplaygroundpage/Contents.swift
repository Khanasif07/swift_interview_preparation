//: [Previous](@previous)

import Foundation
import Network
var postUrl = "https://jsonplaceholder.typicode.com/posts"
//: [Next](@next)
enum NetworkError: Error {
    case badURL
    case requestFailed
    case invalidResponse
    case decodingError
}
public struct PostModel: Codable{
    var body,title: String?
    var id,userId: Int
}

//Basic approch
func fetchData<T:Codable>(url: String,completion: @escaping (Result<T,Error>) -> Void){
    if let url = URL(string: postUrl){
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let err = error{
                print(err.localizedDescription)
                completion(.failure(err))
                return
            }
            guard let data = data else{
                print("No data")
                return
            }
            do{
                //                if let json = try JSONSerialization.jsonObject(with: data,options: []) as? [Any]{
                //                    print("response json:\(json)")
                //                }
                let model = try JSONDecoder().decode(T.self, from: data)
                completion(.success(model))
            }catch let error{
                print("failed to parsed")
                print(error.localizedDescription)
                completion(.failure(error))
            }
        }
        task.resume()
    }
}

//async await..
func getDataFromServer<T: Codable>(urlStr: String) async throws -> T{
    guard let url = URL(string: urlStr) else { throw NetworkError.badURL }
    let urlRequest = URLRequest(url: url)
    let (data,response) = try await URLSession.shared.data(for: urlRequest)
    guard let response = response as? HTTPURLResponse,response.statusCode == 200 else {
        throw NetworkError.invalidResponse
    }
    do{
        let result = try JSONDecoder().decode(T.self, from: data)
        return result
    }catch let err{
        throw err
    }
}

/*
fetchData(url: postUrl) { (result: Result<[PostModel],Error>) in
//  Result<Decodable & Encodable, Error> in
    switch result {
    case .success(let success):
        print(success)
    case .failure(let failure):
        print(failure.localizedDescription)
    }
}
*/

Task{
    do{
        let result:[PostModel] = try await getDataFromServer(urlStr: postUrl)
        print(result)
    }catch let err{
        print(err)
    }
   
}
// different data type in json parsing...
enum StringOrInt: Codable {
    case string(String)
    case int(Int)
    // Custom decoding logic
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let intValue = try? container.decode(Int.self) {
            self = .int(intValue)
        } else if let stringValue = try? container.decode(String.self) {
            self = .string(stringValue)
        } else {
            throw DecodingError.typeMismatch(StringOrInt.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Expected String or Int"))
        }
    }
    
    // Custom encoding logic
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .string(let stringValue):
            try container.encode(stringValue)
        case .int(let intValue):
            try container.encode(intValue)
        }
    }
}

// lazy var..
class DataLoader {
    lazy var data: String = {
        // Expensive data-loading logic
        return "Loaded Data"
    }()
}

//Init
class Rectangle {
    var width: Double
    var height: Double
    // Designated Initializer
    init(width: Double, height: Double) {
        self.width = width
        self.height = height
    }
    // Convenience Initializer
    convenience init(side: Double) {
        self.init(width: side, height: side)
    }
}

let square = Rectangle(side: 5.0)

//Optionals
enum Optional<T> {
    case none  // Represents nil
    case some(T)  // Represents a value of the wrapped type
}

//delegate
protocol SendDataDelegate: NSObject{
    func sendData()
}
class A:NSObject,SendDataDelegate{
    var b: B?
    init(_ objB: B){
        super.init()
        self.b = objB
        b?.delegate = self
    }
    func sendData() {
        print("received Data")
    }
}
class B{
    weak var delegate: SendDataDelegate?
    func sendDataToB(){
        self.delegate?.sendData()
    }
}

var objB = B()
var objA = A(objB)
objB.sendDataToB()

//closure;- A closure is a self-contained block of code that can be passed around and used in your code.
func performOperation(with value: Int, operation: (Int) -> Int) -> Int {
    return operation(value)
}

let result = performOperation(with: 5, operation: {$0 * 2}
print(result)  // Outputs: 10

// private or fileprivate
class MyClass {
    private var secret = 42
    fileprivate var secretSize = 42
    func revealSecret() -> Int {
        return secret
    }
}

extension MyClass{
    func printSecret(){
        print(secret)
        print(secretSize)
    }
}

class yourClass{
    let obj = MyClass()
    func printSecret(){
        print(obj.secretSize)
    }
}
//let obj = MyClass()
//let objY = yourClass()
//objY.obj.secretSize
//obj.secretSize
