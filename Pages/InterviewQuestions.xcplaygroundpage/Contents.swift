import UIKit
import Foundation
// Created repo on Github account
var result = [1,2,3,4,5,6]
var nums = [1,2,3,4,5,6]


let sum = nums.reduce(0) { (result, next) in
    return result + next
}
print("====\(sum)====")
extension Collection{
    func mappp<T>(_ transform: (_ Element: T) -> T) -> [T]{
        var result = [T]()
        for element in self{
            result.append(transform(element as! T))
        }
        return result
    }
    
    func filterrr(_ isIncluded: ((Element) -> Bool)) -> [Element]{
        var result = [Element]()
        for element in self{
            if isIncluded(element){
                result.append(element)
            }
        }
        return result
    }
    
    func reduceee<T>(_ initResult: T,_ finalResult: (T,Element)-> T) -> T{
        var result = initResult
        for element in self {
            result = finalResult(result,element)
        }
        return result
    }
}

//Property wrapper...
@propertyWrapper
struct CapsLock {
    private var value: String
    var wrappedValue: String {
        get { value }
        set { value = newValue.uppercased() }
    }
    
    init(wrappedValue: String) {
        self.value = wrappedValue.uppercased()
    }
}

struct UserName{
    @CapsLock var name: String
    var fullName: String = ""{
        return name + "khan"
    }
    //Observe changes in order to uodate UI..
    var temperature: Int = 0 {
        willSet(newTemperature) {
            print("Temperature is about to change to \(newTemperature)")
        }
        didSet {
            print("Temperature has changed from \(oldValue) to \(temperature)")
        }
    }
    var celsius: Double = 0.0
    //Computed property(Only one computed property)
    var fahrenheit: Double {
        get {
            return (celsius * 9/5) + 32
        }
        set {
            celsius = (newValue - 32) * 5/9
        }
    }
    var fahrenheits: Double{
        return (celsius * 9/5) + 32
    }
    lazy var data: String = {
        // Expensive data-loading logic
        return "Loaded Data"
    }()
}
var user = User(username: "johnDoe")
print(user.username)  // Output: "JOHNDOE"

func deferStatement(){
    print("task1")
    defer {
        print("task2")
        defer {
            print("task3")
        }
    }
    print("task4")
}

//func thirdLargestInArray(_ nums: [Int]) -> (Int,Int,Int){
//    var first = 0
//    var second = 0
//    var third = 0
//    for i in 0...nums.count-1{
//        if (nums[i] > first){
//                        third  = second
//                        second = first
//                        first  = nums[i]
//                    }
//                else if (nums[i] > second){
//                        third = second
//                        second = nums[i]
//                    }
//                else if (nums[i] > third){
//                        third = nums[i]
//                }
//    }
//    return (first,second,third)
//}

//print("Third Largest element in given array would be \(thirdLargestInArray([1,3,5,7,9,2,4,6,8,10]))")
//print(mergeTwoSortedArray(arr1: [1,3,5,7,9], arr2: [2,4,6,8,10]))

func removeDuplicates(_ num:  [Int]) -> Int {
    var slow = 0
    var fast = 1
    var nums = num
    if nums.count == 0 || nums.count == 1{
        return nums.count
    }
    
    while (fast<nums.count){
        if nums[slow] != nums[fast]{
            slow += 1
            nums[slow] = nums[fast]
        }
        fast += 1
    }
    return slow + 1
}

func searchInsert(_ nums: [Int], _ target: Int) -> Int {
    var l = 0
    var r = nums.endIndex-1
    var ans = -1
    while (l<=r){
        let mid = (l + r) / 2
        if nums[mid] == target{
            return mid
        } else if (nums[mid] < target) {
            l = mid + 1
            ans = mid + 1
        } else{
            ans = mid
            r   = mid - 1
        }
    }
    return ans
}

//- Kadane Alogorithm
func maxSubArray(_ nums: [Int]) -> Int {
    if nums.count == 0 {
        return 0
    }
    var sum = 0
    var maxi  = nums[0]
    for i in 0...nums.count-1{
        sum = sum + nums[i]
        maxi = max(sum, maxi)
        if sum < 0{
            sum = 0
        }
    }
    return maxi
}

func reverseNumber(_ number: inout Int){
    //123
    //
    var result = 0
    while (number>0){
        result = result * 10 + number % 10
        number /= 10
    }
    print(number)
}

print("reverse number:-\(reverseNumber(123305))")

//func sortArray(_ nums: [Int]) -> [Int] {
//    if nums.isEmpty{
//        return nums
//    }
//    var ct0 = 0
//    var ct1 = 0
//    var num = nums
//    for i in 0...nums.endIndex-1{
//        switch(nums[i]){
//        case 0:
//            ct0 += 1
//            break
//        case 1:
//            ct1 += 1
//            break
//        default:
//            break
//        }
//    }
//    var i = 0
//    print(ct0)
//    print(ct1)
//    while (ct0>0){
//        num[i] = 0
//        i += 1
//        ct0 -= 1
//    }
//
//    while (ct1>0){
//        num[i] = 1
//        i += 1
//        ct1 -= 1
//    }
//
//    return num
//}


func lengthOfLastWord(_ s: String) -> Int {
    if s.isEmpty {
        return 0
    }
    let s = Array(s)
    var length =  s.count
    var lastWordLength = 0
    
    //trim
    while length > 0 && s[length - 1] == " " {
        length -= 1
    }
    
    while length > 0 && s[length - 1] != " " {
        lastWordLength += 1
        length -= 1
    }
    
    return lastWordLength
}

func lengthOfLastWordSwift(_ s: String) -> Int {
    if let lastWord = s.components(separatedBy: " ").filter({ $0 != "" }).last {
        return lastWord.count
    } else {
        return 0
    }
}

func groupByFunction(){
    var numbers = [1,2,3,4,5,6,6,6,7,8,8]
    let dups = Dictionary(grouping: numbers, by: { $0 }) //= [3: [3], 7: [7], 1: [1], 4: [4], 8: [8, 8], 6: [6, 6, 6], 5: [5], 2: [2]]
    
    let result = dups.filter({$1.count > 1}) //  = [8: [8, 8], 6: [6, 6, 6]]
    let keys = result.keys  //   = [6,8]
}

//Longest substringl (abbcdd)
//removeFirst - remove element from array to count
func lengthOfLongestSubstring(_ s: String) -> Int {
    guard  s.count > 1 else { return s.count}
    var maxCount = 0
    var currSubstring: [Character] = []
    for char in s{
        if let index =  currSubstring.firstIndex(of: char){
            currSubstring.removeFirst(index + 1)
        }
        currSubstring.append(char)
        maxCount = max(currSubstring.count,maxCount)
    }
    return maxCount
}

//MARK:- try catch throws error handling...
enum UserDetailError: Error{
    case invalidName
    case invalidAge(_ msg: String)
}

func userTest(_ name: String, _ age: Int) throws{
    if name.count == 0 {
        throw UserDetailError.invalidName
    }
    if age > 18 {
        throw UserDetailError.invalidAge("Invalid age")
    }
}

do {
    try userTest("Asif", 19)
} catch let error{
    print("Error \(error)")
}

//let errorType = try? userTest("Asif", 20)
//print(errorType)


func isPalindrome(_ x: Int) -> Bool {
    if x<0{
        return false
    }
    if String(x).count == 1{
        return true
    }
    let str = String(x)
    let aryChar = Array(str)
    var i = 0
    var j = String(x).count - 1
    while(j>i){
        if aryChar[i] != aryChar[j]{
            return false
        }
        i += 1
        j -= 1
    }
    return true
}
//MIMP.
extension Collection{
    
    func myymap<T>(_ transfrom : (Element) -> T) -> [T]{
        var res  = [T]()
        for element in self{
            res.append(transfrom(element))
        }
        return res
    }
    
    func myFilter(_ isIncluded: (Element)-> Bool) -> [Element] {
        var res : [Element] = []
        for element in self {
            if isIncluded(element){
                res.append(element)
            }
        }
        return res
    }
    
    func myReduce<T>(_ initialResult: T, _ nextPartialResult: (T, Element)-> T) -> T {
        var result = initialResult
        for element in self {
            result = nextPartialResult(result, element)
        }
        return result
    }
    
}



//print(isPalindrome(121))
//print([2,4,5,7,9].myMap({ value in
//    return value*value
//}))
//
//print([2,4,5,7,9].myFilter({ value in
//    return value % 2 == 0
//}))
//print([2,4,6,8,10].(0, { sum, element in
//    sum + element
//}))
func reverseNumber(_ num: Int) -> Int {
    var rev = 0
    var nums = num
    while (nums != 0){
        rev = rev * 10 + nums % 10
        nums /= 10
    }
    return rev
}

//print(reverseNumber(1234))


final class SingletonClass{
    static let shared = SingletonClass()
    private init(){
        
    }
}


print(deferStatement())

//https://www.avanderlee.com/swift/combine/
//https://www.avanderlee.com/swift/combine/
private func getIndexArrOptimized(){
    var target = 5
    var arr = [Int]()
    for i in 0...nums.count-1{
        let dif = target - nums[i]
        if arr.contains(dif){
            print("found")
        } else{
            arr.append(nums[i])
        }
    }
}

struct stack<T> : CustomStringConvertible{
    var description: String{
        return  (items.map({_ in "$0"}).joined(separator: ","))
    }
    
    var items: [T]
    
    mutating func apend(item: T){
        items.insert(item, at: 0)
    }
    
    @discardableResult
    mutating func pop() -> T?{
        if items.isEmpty{ return nil}
        return items.removeFirst()
    }
    
    @discardableResult
    mutating func peek() -> T?{
        if items.isEmpty{ return nil}
        return items.last
    }
}


extension Array where Element: Equatable {
    mutating func removeDuplicates() {
        var result = [Element]()
        for value in self {
            if !result.contains(value) {
                result.append(value)
            }
        }
        self = result
    }
}


var arrr = [4,5,0,1,5,2,7,2,0,8]
var string = "geeks for geeks"
var stringg = Array(string)
print(arrr.removeDuplicates())
print(stringg.removeDuplicates())
print(stringg)
let results = string.components(separatedBy: " ").map { stringg in
    return String(stringg.reversed())
}
var set = Set(arrr)
var orderedSet = NSOrderedSet(array: arrr)
print(results)
print(set)
print(orderedSet)

//    var s = """
//    var arr = Array(s)
//    var result = Dictionary(grouping: arr, by: {$0}).sorted(by: {$0.value.count > $1.value.count}).first?.value.count ?? 0
//    let finalResult = arr.count - result
//    print(finalResult)
//removeLetter()

class ParentClass{
    func abstractFun() {
        print("This method must be overridden")
    }
}

class SubClass : ParentClass {
    override func abstractFun() {
        // Override
    }
}
//
struct User{}
protocol Loadable {
    associatedtype Model
    func load(from url: URL) async throws -> Model
}

class UserLoader: Loadable {
    typealias Model = User
    func load(from url: URL) async throws -> User {
        return User()
    }
}

//
protocol Weapon {
    var name: String { get }
    var canFire: Bool { get }
    var canCut: Bool { get }
}

protocol Fireable {
    var magazineSize: Int { get }
}
protocol Cuttable {
    var weight: Double { get }
    var steel: String { get }
}

struct LongSword: Weapon, Cuttable {
    let name: String
    let steel: String
    let weight = 7.2
    let canFire = false
    let canCut = true
}

// longsword is a weapon with ability to cut.
struct AK47: Weapon, Fireable {
    let name = "AK47"
    let magazineSize = 30
    let canFire = true
    let canCut = false
}


// ak47 is also a weapon with ability to fire bullets.

//===Required init
class A{
    var a :Int = 10
    required init(){
        print("I am in class A")
    }
}

class B: A {
    required init(){
        print("I am in class B")
    }
}
var objRef:B = B()

class AA{
    var a :Int = 10
    required init(_ msg: String){
        print("I am in class AA \(msg)")
    }
}

class BB: AA {
    required init(_ msg: String){
        print("I am in class BB")
        super.init(msg)
    }
}
var objReff:BB = BB("Testing")
// failable init

struct Person {
    var id: String
    
    init?(id: String) {
        if id.count == 9 {
            self.id = id
        } else {
            return nil
        }
    }
}

//== copy on write
struct Employeee{
    var name: String
    var address: String
}

var employee1 = Employeee(name: "Mohit", address: "Delhi")
var employee2 = employee1

//=-=-=-=
protocol Address {
    associatedtype ZipCode
    var country: String { get set }
    func someState()-> ZipCode
    var zipCode: ZipCode { get set }
}


struct USAddress: Address {
    typealias ZipCode = Int
    var zipCode: ZipCode = 95014
    var country: String = "us"
    func someState() -> Int {
        return 1000
    }
}

struct CanadaAddress: Address {
    typealias ZipCode = String
    var zipCode: ZipCode = "M5V 3L9"
    var country: String = "canada"
    func someState() -> String {
        return "1000"
    }
}


func getUSAddress(_ countryCode: String) -> some Address {
    return USAddress()
}

getUSAddress("+971")
