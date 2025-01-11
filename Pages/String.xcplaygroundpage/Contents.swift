//: [Previous](@previous)


import Foundation

["",""].joined(separator: "")
"".components(separatedBy: " ")
"".split(separator: " ")
var numbers = [0,0,1,0,0,1,0,0]
print(palindrome("abcdedcba"))

func palindrome(_ input: String)-> Bool{
    let char  = Array(input)
    var i = 0
    var j = char.count - 1
    while (i<j) {
        if char[i] == char[j]{
            i += 1
            j -= 1
        } else {
            return false
        }
    }
    return true
}

struct Stack<T> : CustomStringConvertible{
    var description: String{
        return  (items.map({_ in "$0"}).joined(separator: ","))
    }
    
    var items: [T]
    
    mutating func apend(item: T){
        items.insert(item, at: 0)
    }
    
    mutating func pop() -> T?{
        if items.isEmpty{ return nil}
        return items.removeFirst()
    }
    
    func peek() -> T?{
        if items.isEmpty{ return nil}
        return items.first
    }
}


func validExpression() -> Bool{
    let s = "{{{({[]})}}}]"
    var stack = Stack<Character>(items: [])
    for char in s{
        if char == "{" || char == "("  || char == "[" {
            stack.apend(item: char)
        }else{
            if stack.items.isEmpty {
                return false
            }
            if String(stack.peek() ?? Character("")) + String(char) == "{}" || String(stack.peek() ?? Character("")) + String(char) == "()" || String(stack.peek() ?? Character("")) + String(char) == "[]"{
                stack.pop()
            } else {
                return false
            }
        }
    }
    return stack.items.isEmpty
}

//print(validExpression())

//Maximum Consecutive Repeating Character In String
func maximumConsecutiveRepeatingCharacterInString(_ str: String){
    if str.isEmpty{
        return
    }
    var hashInt:[Character:Int] = [:]
    var hash:[Int] = [Int](Array(repeating: 0, count: 26))
    var maxCount = 0
    var currCount = 0
    var currentChar: Character?
    for char in str{
        if currentChar == nil{
            currentChar = char
        }
        if currentChar == char{
            currCount += 1
            maxCount = max(maxCount,currCount)
        }else{
            currentChar = char
            currCount = 1
        }
        hashInt[char, default: 0] += 1
        hash[Int(char.asciiValue!-Character("a").asciiValue!)] += 1
    }
    print(hashInt)
    print(hash)
    print(maxCount)
}
let strs = "baaaaabbcccbbb"
maximumConsecutiveRepeatingCharacterInString(strs)

//Longest common prefix
//vvimp
func longestCommonPrefix(_ strs: [String]) -> String {
    guard !strs.isEmpty else { return "" }
    // Sort the array
    let sortedStrs = strs.sorted()
    // Take the first and the last string from the sorted array
    let first = sortedStrs.first!
    let last = sortedStrs.last!
    // Compare characters one by one until a mismatch is found
    var index = 0
    for (fChar, lChar) in zip(first, last) {
        if fChar == lChar {
            index += 1
        } else {
            break
        }
    }
    // Return the common prefix
    let prefix = String(first.prefix(index))
    return prefix
}

// Example Usage:
//let strss = ["flower", "flow", "flight"]
//let resultt = longestCommonPrefix(strss)
//print(resultt)  // Output: "fl"

//Longest common prefix with binary search
func longestCommonPrefixWithBinarySearch(_ strs: [String]) -> String {
    guard !strs.isEmpty else { return "" }
    // Sort the strings
    let sortedStrs = strs.sorted()
    print(sortedStrs)
    // Get the first and last string after sorting
    let first = sortedStrs.first!
    let last = sortedStrs.last!
    // Binary search on the prefix length
    var low = 0
    var high = min(first.count, last.count)
    
    while low <= high {
        let mid = (low + high) / 2
        let prefix = first.prefix(mid)
        if last.hasPrefix(prefix) {
            // If the current prefix works, try a longer one
            low = mid + 1
        } else {
            // If it doesn't match, try a shorter one
            high = mid - 1
        }
    }
    
    // The longest common prefix will be the first `high` characters of the first string
    return String(first.prefix(high))
}

// Example Usage:
let strss = ["flower", "flow", "flight"]
let result = longestCommonPrefixWithBinarySearch(strss)
//print(result)  // Output: "fl"

func generateSubsets<T>(_ array: [T], _ index: Int, _ currentSubset: [T]) {
    // Base case: If we've processed all elements, print the current subset
    if index == array.count {
        print(currentSubset)
        return
    }
    // Option 1: Exclude the current element and move to the next
    generateSubsets(array, index + 1, currentSubset)
    // Option 2: Include the current element in the subset and move to the next
    generateSubsets(array, index + 1, currentSubset + [array[index]])
}

// Helper function to kick off the recursive process
func printAllSubsets<T>(_ array: [T]) {
    generateSubsets(array, 0, [])
}

// Example usage
let nums = ["a", "b"]
printAllSubsets(nums)

//Word patterns String
//"abba" "dog cat cat dog"
func wordPattern()->Bool{
    var str1 = "abba"
    var str2 = "dog cat cat dog"
    var hashMap: [Character:String] = [:]
    let str2Arr = str2.split(separator: " ")// this will always give arr of substring
    if str1.count == str2Arr.count{
        for (i, char) in str1.enumerated() {
            if let StrExist = hashMap[char]{
                if StrExist != String(str2Arr[i]){
                    return false
                }
            }else{
                hashMap[char] = String(str2Arr[i])
            }
        }
    }else {
        return false
    }
    print(str2Arr)
    print(hashMap)
    return true
}

print(wordPattern())



//without repeating characters as we move the window.
func lengthOfLongestSubstring(_ s: String) -> Int {
    var left = 0
    var right = 0
    var maxLength = 0
    var charIndexArr = [Int](repeating: 0, count: 26)
    let characters = Array(s)
    while  right < characters.count {
        let currentChar = characters[right]
        charIndexArr[Int(currentChar.asciiValue! - Character("a").asciiValue!)] += 1
        while charIndexArr[Int(currentChar.asciiValue! - Character("a").asciiValue!)] > 1{
            //sort the current window where count is > 1
            charIndexArr[Int(currentChar.asciiValue! - Character("a").asciiValue!)] -= 1
            left += 1
        }
//        print(charIndexArr)
        maxLength = max(maxLength, right - left + 1)
        right += 1
    }
    return maxLength
}

let input = "abcdabcbb"
print("lengthOfLongestSubstring:-\(lengthOfLongestSubstring(input))")

//vvimp
func longestPalindromeOfString(_ s: String) -> String{
    if(s.count == 0){return ""}
    if(s.count == 1){return s}
    var start = 0, maxLen = 1, stringArray = Array(s), l = 0,r = 0
    for i in 1..<stringArray.count{
        //odd case || "ababade"
        print("maxLen\(maxLen)")
        l = i - 1
        r = i + 1
        while (l >= 0 && r < stringArray.count && stringArray[l] == stringArray[r]){
            if r-l+1 > maxLen{
                maxLen = r-l+1
                start = l
            }
            l -= 1
            r += 1
        }
        //Even case || "abba"
        l = i - 1
        r = i
        print("\(l)-=-=-\(r)")
        while (l >= 0 && r < stringArray.count && stringArray[l] == stringArray[r]){
            print("\(stringArray[l])-=-=-\(stringArray[r])")
            if r-l+1 > maxLen{
                maxLen = r-l+1
                start = l
            }
            l -= 1
            r += 1
        }
    }
    return String(stringArray[start..<maxLen])
}
var inputt =  "abba"
//"ababade"
print("longestPalindromeOfString-=-=-\(longestPalindromeOfString(inputt))")

func findAnagramsOfString(_ s: String, _ p: String) -> [Int] {
    var result = [Int]()
    let sArray = Array(s)
    let pArray = Array(p)
    let sLength = sArray.count
    let pLength = pArray.count
    // If p is longer than s, there can't be any anagrams
    if pLength > sLength {
        return result
    }
    // Create frequency count for p
    var pCount = [Int](repeating: 0, count: 26)
    for char in pArray {
        pCount[Int(char.asciiValue! - Character("a").asciiValue!)] += 1
    }
    print(pCount)
    // Create frequency count for the first window in s
    var sCount = [Int](repeating: 0, count: 26)
    for i in 0..<pLength {
        sCount[Int(sArray[i].asciiValue! - Character("a").asciiValue!)] += 1
    }
    print(sCount)
    // Check if the first window matches
    if sCount == pCount {
        result.append(0)
    }
    // Slide the window across s
    for i in pLength..<sLength {
        // Add the next character to the window
        sCount[Int(sArray[i].asciiValue! - Character("a").asciiValue!)] += 1
        // Remove the first character of the previous window
        sCount[Int(sArray[i - pLength].asciiValue! - Character("a").asciiValue!)] -= 1
        // Check if current window matches the frequency count of p
        if sCount == pCount {
            result.append(i - pLength + 1)
        }
    }
    return result
}

// Example usage
let s = "abaebabadcd"
let p = "aba"
print(findAnagramsOfString(s, p))  // Output: [0, 6]

//String related questions
func reverseString(str: inout String)-> String{
    if str.isEmpty{ return ""}
    var start:Int = 0
    var last = str.count - 1
    var strArr = Array(str)
    while start < last{
        let startStr = strArr[start]
        let lastStr = strArr[last]
        strArr[last] = startStr
        strArr[start] = lastStr
        start += 1
        last -= 1
    }
    return String(strArr)
}
var inputStr = "abcef"
let reverseOutput = reverseString(str: &inputStr)
print("reverseOutput \(reverseOutput)")

//imp
func beautyOfAllSubstringOfString(_ str: String) -> Int{
    var strArr = Array(str)
    var hashMap:[Int] = []
    var sum = 0
    for i in 0..<str.count{
        hashMap = [Int](Array(repeating: 0, count: 26))
        for j in i..<str.count{
            hashMap[Int((strArr[j]).asciiValue! - Character("a").asciiValue!)] += 1
            let range = i...j
            let mySubstring = strArr[range]
            let sortedHashMap = hashMap.sorted(by: { $0 > $1 }).filter({ $0 > 0})
            let beautyDiff = (sortedHashMap.first ?? 0) - (sortedHashMap.last ?? 0)
            if beautyDiff > 0 {
                print(mySubstring)
                sum += 1
            }
        }
    }
    return sum
}
print("beautyOfAllSubstringOfString")
print(beautyOfAllSubstringOfString("aabcb"))

//
func createSubSet(_ array: [Int], index: Int, cumulative: [Int]){
    if index==array.count{
        print(cumulative)
        return
    }
    createSubSet(array, index: index+1, cumulative: cumulative)
    createSubSet(array, index: index+1, cumulative: cumulative + [array[index]])
}
    
createSubSet([1,2,3,4], index: 0, cumulative: [])
