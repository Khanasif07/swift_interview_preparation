//: [Previous](@previous)

import Foundation

var greeting = "Hello, playground"

//: [Next](@next)
//MARK:- Linked List

public class Node<T: Equatable>{
    var value: T
    var next: Node?
    var previous : Node?
    
    public init(value: T){
        self.value = value
    }
}

extension Node: Equatable{
    public static func == (lhs: Node<T>, rhs: Node<T>) -> Bool {
        return lhs.value == rhs.value
    }
}

public class LinkedList<T: Equatable>{
    public var head: Node<T>?
    
    public var isEmpty: Bool {
        return head ==  nil
    }
    
    public var first : Node<T>?{
        return head
    }
    
    public var last: Node<T>?{
        guard var node = head else {
            return nil
        }
        
        while let next = node.next {
            node = next
        }
        return node
    }
    
    public func append(value: T){
        let newNode = Node(value: value)
        if let lastNode = last{
            newNode.previous = lastNode
            lastNode.next = newNode
        }else{
            head = newNode
        }
    }
   
    
    public func count() -> Int{
        guard var node = head else { return 0}
        var count = 1
        while let next = node.next {
            node = next
            count += 1
        }
        return count
    }
    
    public var printList: String{
        var s = ""
        var node = head
        while node != nil{
            s += "\(node!.value)"
            node = node?.next
            if node != nil {
                s += "->"
            }
        }
        return s + ""
    }
    
    public func getNodeAt(atIndex index: Int) -> Node<T>{
        if index == 0 {
            return head!
        }
        var node = head
        var count = 0
        while node != nil{
            node = node?.next
            if node != nil {
                count += 1
                if count == index{
                    return node!
                }
            }
        }
        return node!
    }
    
    public func insertNodeAt(value: T,atIndex index: Int){
        let newNode = Node(value: value)
        //Insert as a head
        if index == 0 {
            newNode.next = head
            head?.previous = newNode
            head = newNode
        } else{
            let prevNode = self.getNodeAt(atIndex: index - 1)
            let nextNode = prevNode.next
            newNode.previous = prevNode
            newNode.next = nextNode
            prevNode.next = newNode
            nextNode?.previous = newNode
        }
    }
    
    //1,2,3,4,newNodeToAppend,5
    
    //1,2,3,4,NodeToRemoved,5
    public func remove(node: Node<T>) -> T{
        //1,2,3,4,NodeToRemoved,5
        let previousNode = node.previous
        let nextNode     = node.next
        
        if let previousNode = previousNode{
            previousNode.next = nextNode
        }else{
            head = nextNode
        }
        nextNode?.previous = previousNode
        node.previous = nil
        node.next = node
        return node.value
    }
    
    public func removeAt(atIndex index : Int) -> T {
        let nodeToRemove = self.getNodeAt(atIndex: index)
        return remove(node: nodeToRemove)
    }
    
    //INterView Question
    public func getMiddleNode()-> T{
        let middle = self.count() / 2
        return self.getNodeAt(atIndex: middle).value
    }
    
    public func getMiddleNodeEfficient()-> Node<T>{
        var slowNode = head
        var fastNode = head
        
        while (slowNode != nil && fastNode != nil){
            fastNode = fastNode?.next?.next
            slowNode = slowNode?.next
        }
        return slowNode!
    }
    
    func reverseLinkedListSimple() -> Node<T>{
        //1->2->3->nil
        var current = head
        var prev: Node<T>? = nil
        var next: Node<T>? = nil
        while (current != nil){
            //print(current?.value ?? T.self)
            next = current?.next
            current?.next = prev
            prev = current
            current = next
        }
        head = prev
        return head!
    }
    
    
    //VVIMP
    public func reverseListPair() -> Node<T>?{
        //1->2->3->4
        var current = head
        var temp : Node<T>? = head
        while (current != nil && current?.next != nil){
            //swap the pair
            temp?.value = current!.value
            current?.value = current!.next!.value
            current?.next?.value = temp!.value
            //Advance the current pointer by 2 nodes
            current = current?.next?.next  ?? nil
        }
        return head
    }
}

//VVIMP
func reverse(list: LinkedList<Int>){
    //1->2->3->nil
    var current = list.head
    var prev: Node<Int>?
    var next: Node<Int>?
    while (current != nil) {
        next = current?.next
        current?.next = prev
        prev = current
        current = next
    }
    list.head = prev
    print(list.printList)
}

func sortSingleList(list: LinkedList<Int>) -> LinkedList<Int>?{
    if list.head == nil || list.head?.next == nil {
        return list
    }
    //2->1->5->3->nil
    var slowNode = list.head
    var fastNode = list.head
    var temp: Node<Int>?
    while (fastNode != nil && fastNode?.next != nil){
           temp =  slowNode
           fastNode = fastNode?.next?.next
           slowNode = slowNode?.next
    }
    temp?.next = nil
    
    let l1 = LinkedList<Int>()
    l1.head = list.head
    let sorted1 = sortSingleList(list: l1)
    
    let l2 = LinkedList<Int>()
    l2.head = slowNode
    let sorted2 = sortSingleList(list: l2)
    
    var sortedList = LinkedList<Int>()
    sortedList.head = sortTwoSortedList(list1: sorted1!, list2: sorted2!)
    print(sortedList.printList)
    return sortedList
}



//VVIMP
public func sortTwoSortedList(list1: LinkedList<Int>,list2:LinkedList<Int>) -> Node<Int>?{
    //1->2>5->nil
    //2->3->6->nil
    var head1 = list1.head
    var head2 = list2.head
    var newHead : Node<Int>? = nil
    var sorted  : Node<Int>? = nil
    if list1.isEmpty {return head2}
    if list2.isEmpty {return head1}
    
    if (head1 != nil && head2 != nil){
        if (head1?.value ?? 0 <= head2?.value ?? 0) {
            sorted = head1
            head1 = sorted?.next
        }else{
            sorted = head2
            head2 = sorted?.next
        }
    }
    newHead = sorted
    while (head1 != nil && head2 != nil){
        if (head1?.value ?? 0 <= head2?.value ?? 0) {
            sorted?.next = head1
            sorted = head1
            head1 = sorted?.next
        }else{
            sorted?.next = head2
            sorted = head2
            head2 = sorted?.next
        }
    }
    if head1 ==  nil { sorted?.next = head2 }
    if head2 ==  nil { sorted?.next = head1 }
    return newHead
}
//VIMP
//1->2->2->3->nil
public func removeDuplicateFromSortedList(list: LinkedList<Int>) -> Node<Int>?{
    var p = list.head
    var q : Node<Int>? = nil
    while (p != nil && p?.next != nil){
        if (p?.value ?? 0 == p?.next?.value ?? 0){
            //logic...
            q = p?.next?.next
            if q == nil {
                p?.next = nil
                break
            }
            p?.next = q
        }
        if (p?.value ?? 0 != p?.next?.value ?? 0){
            p = p?.next
        }
    }
    return list.head
}

public func detectLoopInLinkedList(list: LinkedList<Int>) -> Bool{
    var p = list.head
    var q = list.head
    while( p != nil && q != nil && q?.next != nil){
        p = p?.next
        q = q?.next?.next
        if p == q {
            return true
            // return pivotNode
        }
    }
    return false
}

public func startingNodeOfLoop(pivotNode: Node<Int>,head1: Node<Int>) -> Node<Int>?{
    var q = head1
    var p = pivotNode
    while (p != q){
        p = (p.next)!
        q = (q.next!)
    }
    return p
}

var list = LinkedList<Int>()
list.append(value: 1)
list.append(value: 2)
list.append(value: 3)
list.insertNodeAt(value: 4, atIndex: 3)
list.insertNodeAt(value: 5, atIndex: 4)
list.insertNodeAt(value: 6, atIndex: 5)

var list1 = LinkedList<Int>()
list1.append(value: 1)
list1.append(value: 6)
list1.append(value: 6)
list1.append(value: 8)

var list2 = LinkedList<Int>()
list2.append(value: 2)
list2.append(value: 1)
list2.append(value: 5)
list2.append(value: 3)
//list1.insertNodeAt(value: 9, atIndex: 3)
//list1.insertNodeAt(value: 11, atIndex: 4)

//print(list.printList)
//print(list.reverseLinkedListSimple())
//print(list.printList)

//print(list.count())
//
//print(list.getNodeAt(atIndex: 2).value)
//
//print(list.getMiddleNode())
//print(list.getMiddleNodeEfficient().value as Any)

//print(list.removeAt(atIndex: 2))
//print(list.printList)

//print(list.removeAt(atIndex: list.count() / 2))
//print(list.printList)

//print(list.removeDuplicates())
//print(list.printList)
//print(list.printList)
//list.head = list.reverseList(head: list.head!)
//print(list.printList)
//var sortedList = LinkedList<Int>()
//sortedList.head = sortTwoSortedList(list1: list, list2: list1)
//print(sortedList.printList)
//list.head = removeDuplicateFromSortedList(list: list)
//print(list.printList)

//    print(detectLoopInLinkedList(list: list))
sortSingleList(list: list2)
