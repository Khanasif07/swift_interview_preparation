//: [Previous](@previous)

import Foundation
//: [Next](@next)
func largestElementInArray(_ nums: inout [Int]) -> Int{
    if !nums.isEmpty{
        var maxE = nums[0]
        for i in 1..<nums.count{
            maxE = max(maxE,nums[i])
        }
        return maxE
    }
    return 0
    
}
//var nums = [5,4,3,0,9,3,8]
//print(largestElementInArray(&nums))

func secondLargestElementInArray(_ nums: inout [Int]) -> Int{
    if !nums.isEmpty{
        var firstMaxE = nums[0]
        var secondMaxE = nums[0]
        for i in 1..<nums.count{
            if nums[i] > firstMaxE{
                firstMaxE = nums[i]
            }else if (nums[i] > secondMaxE) && (nums[i] != firstMaxE){
                secondMaxE = nums[i]
            }
        }
        return secondMaxE
    }
    return 0
}
//var nums1 = [5,4,3,0,9,3,8,9]
//print(secondLargestElementInArray(&nums1))

func removeDuplicatesfromSortedArray(_ nums: inout [Int]){
    var j  = 0
    if !nums.isEmpty{
        var prev = nums[0]
        for i in 1..<nums.count{
            if prev == nums[i]{
                nums[j] = nums[i]
                prev = nums[j]
                j += 1
            }else{
                nums[j] = nums[i]
                prev = nums[j]
            }
        }
    }
    print("distinct element: \(j)")
    print(nums)
}
//var nums2 = [1,1,2,2,3,3,3,4]
//print(removeDuplicatesfromSortedArray(&nums2))

// reverseArray
func reverseArray(_ arr: inout [Int],i: Int, j: Int){
    if i>=j{
        print(arr)
        return
    }
    arr.swapAt(i, j)
    reverseArray(&arr, i: i+1, j: j-1)
}
//var nums234 = [1,4,2,5,9,6]
//print("reverse array:-\(reverseArray(&nums234, i: 0, j: nums234.count-1))")

//Rotate array by 1
func rotateArrayBy1(_ arr: inout [Int]){
    guard !arr.isEmpty else { return}
    let last = arr[arr.count-1]
    for i in stride(from: arr.count-1, through: 1, by: -1){
        arr[i] = arr[i-1]
    }
    arr[0] = last
    print(arr)
}
//[1,2,3,4,5] -> [5,1,2,3,4]
//var arrrr = [1,2,3,4,5]
//print("Rotate Array By 1:-\(rotateArrayBy1(&arrrr))")


func findMaxConsecutiveOnes(_ nums: inout [Int]) -> Int{
    var currentMax = 1
    var maxValue = 0
    for i in 0..<nums.count-1{
        if nums[i] == 1 && nums[i+1] == 1{
            currentMax += 1
            maxValue =  max(maxValue,currentMax)
        }else{
            currentMax = 1
            maxValue =  max(currentMax,maxValue)
        }
    }
    return maxValue
}
//var nums4 = [0,0,1,1,1,0,1,3,1,1]
//print(findMaxConsecutiveOnes(&nums4))

func rotate(_ nums: inout [Int], _ k: Int) {
    let n = nums.count
    let steps = k % n  // Handle cases where k is greater than the array size
    // Edge case: If steps == 0, no rotation needed
    guard steps > 0 else { return }
    // Perform the rotation by rearranging the two parts of the array
    let rotatedPart = nums[(n - steps)...]      // Last 'steps' elements
    let remainingPart = nums[..<(n - steps)]    // First 'n - steps' elements
    nums = Array(rotatedPart) + Array(remainingPart) // Combine both parts
}
//var nums5 = [1, 2, 3, 4, 5, 6, 7]
//rotate(&nums5, 10)
//print(nums5)

//VVIMP:- n2,nlogn, n..
func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
    var map = [Int: Int]()
    for (index, value) in nums.enumerated() {
        let diff = target - value
        if let j = map[diff] {
            return [index, j]
        }
        map[value] = index
        print(map)
    }
    return []
}

//var nums6 = [4,6,7,8,1]
//print("two sum:-\(twoSum(nums6, 5))")


//Maximum subarray sum
//Maximum subarray sum refers to finding the sum of a contiguous subarray with the largest sum.
func kadane(_ arr: [Int]) -> Int {
    guard !arr.isEmpty else { return 0 }
    var maxSoFar = arr[0]
    var currentMax = arr[0]
    for i in 1..<arr.count {
        currentMax = max(arr[i], currentMax + arr[i])
        maxSoFar = max(maxSoFar, currentMax)
    }
    return maxSoFar
}

//let nums7 = [-2, 1, -3, 4, -2, 2, 1, -5, 4]
//let result = kadane(nums7)
//print("Maximum subarray sum: \(result)")

func maxSubsequenceSum(_ nums: [Int]) -> Int {
    let maxElement = nums.max() ?? 0
    let positiveSum = nums.filter { $0 > 0 }.reduce(0, +)
    // If the array contains only negative numbers, return the largest single number
    return positiveSum > 0 ? positiveSum : maxElement
}

let numsArr = [-2, 1, -3, 4, -1, 2, 1, -5, 4]
let resultData = maxSubsequenceSum(numsArr)
print(resultData)  // Output: 12 (sum of [1, 4, 2, 1, 4])


//Three way partitioning 🔥| Array | Dutch Algorithm
//Move all negative numbers to beginning and positive to end with constant extra space
//sort 0,1,2
func segregate0_1_2_inArray(_ arr: inout [Int]){
    var start = 0
    var last = arr.count-1
    var mid = start
    while (mid<=last){
        switch arr[mid]{
        case 0:
            arr.swapAt(start, mid)
            start += 1
            mid += 1
            break
        case 1:
            mid += 1
            break
        case 2:
            arr.swapAt(mid, last)
            last -= 1
            break
        default:
            break
        }
    }
    print(arr)
}
var nums8 = [2,0,1,2,2,1,2,1,0,0,2,2,1,0]
//start and mid starts from 0, if zero comes swap  start and mid and increament both
// if 1 comes increament mid
// if 2 comes swap mid and last and  decreament last
//segregate0_1_2_inArray(&nums8)

func moveZerosToRight(_ nums: inout [Int]){
    var j = 0
    for i in 0..<nums.count{
        if nums[i] != 0{
            nums.swapAt(i, j)
            j += 1
        }
    }
    print(nums)
}
//var nums3 = [0,0,0,1,0,0,3,0,3,4]
//print(moveZerosToRight(&nums3))



//minSofar and profit --
func buyAndSellStock(){
    let arr = [5,2,6,1,4]
    var maxProfit = 0
    var minSoFar = arr[0]
    for i in 0..<arr.count{
        minSoFar = min(minSoFar, arr[i])
        let profit = arr[i] - minSoFar
        maxProfit = max(profit, maxProfit)
    }
    print(maxProfit)
}

//buyAndSellStock()

//count is even
//equal pos and neg in arr
//oupput arr starts from pos then nega again -> + - + -
func reArrangeArrayValueBySign(_ arr: inout [Int]){
    var plusPos:Int = 0
    var negPos = 1
    var output:[Int] = [Int](Array(repeating: 0, count: arr.count))
    for item in arr{
        if item > 0{
            output[plusPos] = item
            plusPos += 2
        }else{
            output[negPos] = item
            negPos += 2
        }
    }
    print(output)
}
//var nums9 = [-2,1,-5,3,4,-7]
//reArrangeArrayValueBySign(&nums9)

//need to try one more time..
func spiralMatrix(_ matrix: inout [[Int]]) -> [Int] {
    guard !matrix.isEmpty else { return [] }
    
    var result = [Int]()
    
    var top = 0
    var bottom = matrix.count - 1
    var left = 0
    var right = matrix[0].count - 1
    
    while top <= bottom && left <= right {
        // Traverse from left to right along the top row
        for i in stride(from: left, through: right, by: 1) {
            result.append(matrix[top][i])
        }
        print(result)
        top += 1
        
        // Traverse from top to bottom along the right column
        for i in stride(from: top, through: bottom, by: 1) {
            result.append(matrix[i][right])
        }
        print(result)
        right -= 1
        
        if top <= bottom {
            // Traverse from right to left along the bottom row
            for i in stride(from: right, through: left, by: -1) {
                result.append(matrix[bottom][i])
            }
            print(result)
            bottom -= 1
        }
        
        if left <= right {
            // Traverse from bottom to top along the left column
            for i in stride(from: bottom, through: top, by: -1) {
                result.append(matrix[i][left])
            }
            print(result)
            left += 1
        }
    }
    
    return result
}

//var nums10 = [[1,2,3],[4,5,6],[7,8,9]]
//print(spiralMatrix(&nums10))

//from right every El should be greater than right
func leadersOfArray(_ arr: inout [Int]) -> [Int]{
    var maxFromRight = 0
    var output = [Int]()
    for j in stride(from: arr.count-1, through: 0, by: -1){
        if arr[j] > maxFromRight{
            output.append(arr[j])
            maxFromRight = max(maxFromRight,arr[j])
        }
    }
    return output
}
//var nums11 = [16,17,4,3,5,2]//otp:- [17,5,2]
//print(leadersOfArray(&nums11))

func generatePascal(_ numRows: Int) -> [[Int]] {
    // Base case: if numRows is 0, return an empty array
    guard numRows > 0 else { return [] }
    var triangle = [[1]]
    // Generate rows from the 2nd to numRows
    for row in 1..<numRows {
        var newRow = [Int](Array(repeating: 1, count: row+1)) // Start and end each row with a '1
        let previousRow = triangle[row - 1]
        // Generate the middle values for the row
        for j in 1..<(row) {
            newRow[j] = (previousRow[j - 1] + previousRow[j])
        }
        triangle.append(newRow)
    }
    return triangle
}

let numRows = 5
//let result = generatePascal(numRows)
//print(result)
// Output: [
//   [1],
//   [1, 1],
//   [1, 2, 1],
//   [1, 3, 3, 1],
//   [1, 4, 6, 4, 1]
// ]

//overlaps
func mergeIntervals(_ intervals: [[Int]]) -> [[Int]] {
    guard intervals.count > 0 else { return [] }
    let sortedIntervals = intervals.sorted { $0[0] < $1[0] }
    // Initialize the merged array with the first interval
    var merged: [[Int]] = [sortedIntervals[0]]
    // Loop through each interval in the sorted list
    for i in 1..<sortedIntervals.count {
        let current = sortedIntervals[i]
        let lastMerged = merged[merged.count - 1]
        // If the current interval overlaps with the last merged interval, merge them
        if current[0] <= lastMerged[1] {
            merged[merged.count - 1][1] = max(lastMerged[1], current[1])
        } else {
            // If they don't overlap, add the current interval to the merged list
            merged.append(current)
        }
    }
    return merged
}

// Example usage:
//let intervals = [[1,3], [2,6], [8,10], [9,18]]
//let result = mergeIntervals(intervals)
//print(result)  // Output: [[1, 6], [8, 10], [15, 18]]


//Missing and Repeating in an Array
func missingAndRepeatingElementInArray(_ nums: [Int]){
    //first approch visisted array
    var visitedArr = [Bool](Array(repeating: false, count: nums.count+1))
    for (index,item) in nums.enumerated(){
        if visitedArr[item]{
            print("repeating: \(item)")
        }else{
            visitedArr[item] = true
        }
    }
    for i in 1..<nums.count{
        if !visitedArr[i]{
            print("missing: \(i)")
        }
    }
    //second approch
}
//let nums15 = [1,3,3,4,5]
//let result = missingAndRepeatingElementInArray(nums15)

//
func findMissingAndRepeating(_ arr: [Int]) -> (Int, Int) {
    let n = arr.count
    // Calculate expected sum and sum of squares for numbers 1 to n
    let expectedSum = n * (n + 1) / 2
    let expectedSumOfSquares = n * (n + 1) * (2 * n + 1) / 6
    // Calculate the actual sum and sum of squares from the given array
    var sumOfArray = 0
    var sumOfSquaresOfArray = 0
    for num in arr {
        sumOfArray += num
        sumOfSquaresOfArray += num * num
    }
    // The difference in sums
    let sumDiff = expectedSum - sumOfArray  // (missing - repeating)
    // The difference in sums of squares
    let squareSumDiff = expectedSumOfSquares - sumOfSquaresOfArray  // (missing^2 - repeating^2)
    // Now we can solve the system of equations:
    // missing - repeating = sumDiff
    // missing^2 - repeating^2 = squareSumDiff
    // We use the identity a^2 - b^2 = (a - b)(a + b)
    // So: (missing + repeating) = squareSumDiff / sumDiff
    let sumPlus = squareSumDiff / sumDiff  // (missing + repeating)
    // Now we can calculate missing and repeating
    let missing = (sumPlus + sumDiff) / 2
    let repeating = sumPlus - missing
    return (missing, repeating)
}

//let arr = [1, 3, 3, 4, 5]
//let res = findMissingAndRepeating(arr)
//print("Missing number: \(res.0), Repeating number: \(res.1)")
// Output: Missing number: 2, Repeating number: 3

//Maximum Product Subarray |
//L to Right and right to Left and if product becomes zero update it to 1
func maxProductSubArray(_ nums: inout [Int]) -> Int{
    //[3,-1,0,4]
    var currProduct = 1
    var maxProduct = 0
    for i in 0..<nums.count{
        currProduct = currProduct * nums[i]
        maxProduct = max(currProduct,maxProduct)
        if currProduct ==  0{
            currProduct = 1
        }
    }
    
    currProduct = 1
    for i in (0..<nums.count).reversed(){
        currProduct = currProduct * nums[i]
        maxProduct = max(currProduct,maxProduct)
        if currProduct ==  0{
            currProduct = 1
        }
    }
    return maxProduct
}
var numArr = [3,-1,0,4]
print(maxProductSubArray(&numArr))

//"First Missing Positive
func firstMissingPositive(_ nums: inout [Int]) -> Int {
    let n = nums.count
    // Place each number in its correct position if it's in the range [1...n]
    for i in 0..<n {
        while nums[i] > 0 && nums[i] <= n && nums[nums[i] - 1] != nums[i] {
            nums.swapAt(i, nums[i] - 1)
        }
    }
    // Find the first index where the value is not i+1
    for i in 0..<n {
        if nums[i] != i + 1 {
            return i + 1
        }
    }
    // If all positions are correct, return n + 1
    return n + 1
}

//var numss1 = [3, 4, -1, 1,0]
//print(firstMissingPositive(&numss1))  // Output: 2


//form largest number from array of int
func formLargestNumberFromArrray(_ nums: [Int]) -> String {
    let numStrings = nums.map { String($0) }
    // Sort the numbers based on custom comparator
    let sortedStrings = numStrings.sorted { (a, b) -> Bool in
        return a + b > b + a
    }
    let result = sortedStrings.joined(separator: "")
    // Handle the case where the numbers are all zeros
    return result.first == "0" ? "0" : result
}

//let nums1 = [3, 30, 34, 5, 9]
//print(formLargestNumberFromArrray(nums1))

//sliding window..Done
func maxSumOfSubarrayOfSize(arr: [Int], k: Int) -> Int {
    var windowSum = 0
    var maxSum = 0
    // Calculate the sum of the first window
    for i in 0..<k {
        windowSum += arr[i]
    }
    maxSum = windowSum
    // Slide the window, subtract the element going out, and add the new element
    for i in k..<arr.count {
        windowSum += arr[i] - arr[i - k]
        maxSum = max(maxSum, windowSum)
        print(windowSum)
    }
    return maxSum
}

//let arrr = [2, 1, 5, 1, 3, 2]
//[-2, 1, -3, 4, -2, 2, 1, -5, 4]
//let k = 4
//let ress = maxSumOfSubarrayOfSize(arr: arrr, k: k)
//print("max Sum Of Subarray with K:- \(ress)")

func maxWaterProblem(heights: [Int])-> Int{
    var leftIndex: Int  = 0
    var rightIndex = heights.count - 1
    var maxArea = 0
    while (leftIndex < rightIndex){
        let width = rightIndex - leftIndex
        let leftHeight = heights[leftIndex]
        let rightHeight = heights[rightIndex]
        let minHeight = min(leftHeight, rightHeight)
        let area = width * minHeight
        maxArea = max(area, maxArea)
        if (leftHeight <= rightHeight) {
            leftIndex += 1
        } else {
            rightIndex -= 1
        }
    }
    return maxArea
}
//let maxwater = maxWaterProblem(heights: [2,1,5,7,0,9,3])
//print("max water area:\(maxwater)")

//VVIMP
//subarray sum problem
func subarraySumToTarget(_ nums: [Int], _ k: Int) -> Int {
    var cumulativeSum = 0
    var count = 0
    var sumFrequency: [Int: Int] = [0: 1]  // To handle case when cumulativeSum equals k at any index
    for num in nums {
        // Update cumulative sum
        cumulativeSum += num
        let diff = cumulativeSum - k
        // Check if there's a subarray that sums to k
        if let frequency = sumFrequency[diff] {
            count += frequency
        }
        // Update the frequency of the cumulative sum in the hashmap
        sumFrequency[cumulativeSum, default: 0] += 1
//        print(sumFrequency)
    }
    return count
}

let nums23 = [1,2,2,3,4,5,2,3,4,1]
let k = 5
let resultt = subarraySumToTarget(nums23, k)
print(resultt)

func twoSumWithBinarySearchApproch(_ nums: [Int], _ target: Int) -> [Int] {
    nums.sorted()
    var s: Int = 0
    var l:Int = nums.count-1
    while (s<l){
        let middle = nums[s] + nums[l]
        if middle == target{
            return [s,l]
        }
        if middle < target{
            s += 1
        }else{
            l -= 1
        }
    }
    return []
}
//print("two sum binary search approch:-\(twoSumWithBinarySearchApproch([4,6,7,8,1], 5))")

// Done
func topKFrequent(_ nums: [Int], _ k: Int) -> [Int] {
    var frequencyMap = [Int: Int]()
    // Count the frequency of each element
    print(frequencyMap)
    for num in nums {
        frequencyMap[num, default: 0] += 1
    }
    // Convert the frequency map to an array of (element, frequency) tuples
    let sortedByFrequency = frequencyMap.sorted { $0.value > $1.value }
    // Extract the top K elements by their frequency
    let result = sortedByFrequency.prefix(k).map { $0.key }
    return result
}

//let numss = [1, 1, 1, 2, 2, 3]
//let k = 2
//print(topKFrequent(numss, k))

// longest Consecutive sequence
func longestConsecutivesequence(_ nums: [Int]) -> Int {
    guard !nums.isEmpty else { return 0 }
    let numSet = Set(nums)  // Store all numbers in a Set
    var longestStreak = 0
    
    for num in numSet {
        // Only start counting if `num` is the beginning of a sequence
        if !numSet.contains(num - 1) {
            var currentNum = num
            var currentStreak = 1
            
            // Count how long the sequence is
            while numSet.contains(currentNum + 1) {
                currentNum += 1
                currentStreak += 1
            }
            // Update the maximum streak length
            longestStreak = max(longestStreak, currentStreak)
        }
    }
    
    return longestStreak
}

//let nums24 = [100, 4, 200, 1, 3, 2]
//print(longestConsecutivesequence(nums24))  // Output: 4


func minOperationsToMakePalindrome(_ arr: [Int]) -> Int {
    var arr = arr
    var left = 0
    var right = arr.count - 1
    var operations = 0
    
    while left < right {
        if arr[left] == arr[right] {
            // If both sides are already equal, just move the pointers
            left += 1
            right -= 1
        } else if arr[left] < arr[right] {
            // If left side is smaller, merge left and left + 1
            arr[left + 1] += arr[left]
            left += 1
            operations += 1
        } else {
            // If right side is smaller, merge right and right - 1
            arr[right - 1] += arr[right]
            right -= 1
            operations += 1
        }
    }
    return operations
}


//let arr21 = [1, 4, 5, 1]
//let result = minOperationsToMakePalindrome(arr21)
//print(result)  // Output: 1

//difference of pair is K.
func findPairs(_ nums: [Int], _ k: Int) -> Int {
    if k < 0 {
        return 0  // There can't be a negative difference, so return 0
    }
    
    var count = 0
    var frequencyMap = [Int: Int]()
    
    // Step 1: Count the frequency of each element
    for num in nums {
        frequencyMap[num, default: 0] += 1
    }
    
    // Step 2: Check for valid pairs
    for (num, freq) in frequencyMap {
        if k == 0 {
            // If k == 0, we are looking for duplicates
            if freq > 1 {
                count += 1
            }
        } else {
            // If k > 0, check if the complement num + k exists
            if frequencyMap[num + k] != nil {
                count += 1
            }
        }
    }
    
    return count
}

//let nums20 = [3, 1, 4, 1, 5]
//let kk = 2
//print(findPairs(nums20, kk))  // Output: 2

// sum of square of two number to K..a2 + b2 = k
//a = 0 , b = k, if a2+b2 > k , b-- else a++


//count more than n/k occurance in array

//
func findSubarrayToSortToSortArray(_ arr: [Int])-> Int{
    if arr.isEmpty{
        return 0
    }
    if arr.count == 1{
        return 0
    }
    var prevElement: Int = arr[0]
    var start: Int = 0
    var last: Int = 0
    for i in 1..<arr.count{
        let currentElement = arr[i]
        if prevElement > currentElement{
            start = i-1
            break
        }
        prevElement = currentElement
    }
    prevElement = arr[arr.count-1]
    for i in stride(from: arr.count-2, through: start, by: -1){
        let currentElement = arr[i]
        if prevElement < currentElement{
            last = i+1
            break
        }
        prevElement = currentElement
    }
    if last>0{
        print(Array(arr[start...last]))
        return last - start + 1
    }
    print(Array(arr[start..<last]))
    return 0
}
//var nums19 = [2,6,4,8,10,9,15]
//print(findSubarrayToSortToSortArray(nums19))

//Count frequencies of all elements in array in O(1) extra space and O(n) time
// VVImp..
func findCounts(_ arr: [Int]){
    if arr.isEmpty { return }
    var hash:[Int:Int] = [:]
    for i in 0..<arr.count {
        hash[i] = 0
    }
    for i in 0..<arr.count{
        hash[arr[i] - 1,default: 0] += 1
    }
    for i in 0..<arr.count{
        print(" \(i + 1) -> \(hash[i]) ")
    }
    print(hash)
}
//print("findCounts")
//findCounts([2, 3, 3, 2, 5])

// vvimp
func factorial(of n: Int) -> [Int] {
    // The array to store the factorial result, starting with 1
    var result = [1]
    // Perform multiplication from 2 to n
    for i in 2...n {
        multiply(&result, by: i)
    }
    // The result array contains the digits of the factorial in reverse order
    return result.reversed()
}

// Helper function to multiply a number with the digits array
private func multiply(_ result: inout [Int], by multiplier: Int) {
    var carry = 0
    // Multiply each digit of the result by the multiplier
    for i in 0..<result.count {
        let product = result[i] * multiplier + carry
        result[i] = product % 10  // Store the last digit of the product
        carry = product / 10      // Carry over the rest
    }
    // Handle the remaining carry by appending digits to the result
    while carry > 0 {
        result.append(carry % 10)
        print(result)
        carry /= 10
    }
}

//let largeFactorial = factorial(of: 10)  // Computing 100!
//print("largeFactorial:-:")
//print(largeFactorial)

//Find a peak element which is not smaller than its neighbours
func findPeakElementInArray(_ arr: [Int])-> Int{
    if arr.isEmpty{
        return 0
    }
    if arr.count == 1{
        return arr[0]
    }
    if arr[0] >= arr[1]{
        return arr[0]
    }
    if arr[arr.count-1] >= arr[arr.count-2]{
        return arr[arr.count-1]
    }
    for i in 1..<arr.count-1{
        if arr[i] >= arr[i+1]  && arr[i] >= arr[i-1]{
            return arr[i]
        }
    }
    return 0
}
//print("findPeakElementInArray:-\(findPeakElementInArray([5, 10, 20, 15]))")

//Search in Sorted Rotated Array//[4,5,6,7,0,1,2]
func search(_ nums: [Int], _ target: Int) -> Int {
    var left = 0
    var right = nums.count - 1
    while left <= right {
        let mid = left + (right - left) / 2
        print("mid:-\(mid)")
        // If the target is found, return its index
        if nums[mid] == target {
            return mid
        }
        // Determine which half is sorted
        // If the left half is sorted
        if nums[left] <= nums[mid] {
            // Check if the target lies within the sorted left half
            if nums[left] <= target && target < nums[mid] {
                right = mid - 1  // Search in the left half
            } else {
                left = mid + 1   // Search in the right half
            }
        }
        // If the right half is sorted
        else {
            // Check if the target lies within the sorted right half
            if nums[mid] < target && target <= nums[right] {
                left = mid + 1   // Search in the right half
            } else {
                right = mid - 1  // Search in the left half
            }
        }
    }
    // If the target is not found, return -1
    return -1
}

//let numsss = [4,5,6,7,0,1,2]
//let targett = 5
//print("search in sorted rotated array:- \(search(numsss, targett))")

//merge two sorted arr
func mergeTwoSortedArray(arr1: [Int],arr2: [Int]) -> [Int]{
    if arr1.isEmpty { return arr2}
    if arr2.isEmpty { return arr1}
    var i = 0
    var j = 0
    var finalArr = [Int]()
    while(i<arr1.endIndex && j<arr2.endIndex){
        if arr1[i] < arr2[j]{
            finalArr.append(arr1[i])
            i += 1
        } else{
            finalArr.append(arr2[j])
            j += 1
        }
    }
    while (i<arr1.endIndex){
        finalArr.append(arr1[i])
        i += 1
    }
    while (j<arr2.endIndex){
        finalArr.append(arr2[j])
        j += 1
    }
    return finalArr
}

//remove duplicates  in sorted arr
func removeDuplicates(_ nums: inout  [Int]) -> Int {
    var slow = 0
    var fast = 1
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
    print(nums.prefix(slow + 1))
    return slow + 1
}
//var nums122 = [2,5,5,6,7,7,8,9]
//print(removeDuplicates(&nums122))

//Sort an array in wave form-first sort arr then swap i and i+1 with 2 interval..
//[1,2,3,4,5] -> [2,1,4,3,5]


//Trapping Rain Water Problem
func trappingRainWaterProblem(_ arr: inout [Int])->Int{
    var currSum = 0
    for i in 1..<arr.count-1{
        if (findLeftMax(arr, currentIndex: i) > arr[i] && findRightMax(arr, currentIndex: i) > arr[i]){
            let min = min(findLeftMax(arr, currentIndex: i),findRightMax(arr, currentIndex: i))
            let diff = min - arr[i]
            currSum += diff
        }
    }
    print(currSum)
    return currSum
    func findLeftMax(_ arr: [Int],currentIndex:  Int)->Int{
        var i = currentIndex
        var currE = arr[i]
        var max = -1
        while (i>0) {
            i -= 1
            if currE < arr[i]{
                currE = arr[i]
                max = arr[i]
            }
        }
        return max
    }
    
    func findRightMax(_ arr: [Int],currentIndex: Int)->Int{
        var i = currentIndex
        var currE = arr[i]
        var max = -1
        while (i<arr.count-1) {
            i += 1
            if currE < arr[i]{
                currE = arr[i]
                max = arr[i]
            }
        }
        return max
    }
}
var inputA = [10, 9, 0, 5]
print("trappingRainWaterProblem:-\(trappingRainWaterProblem(&inputA))")
