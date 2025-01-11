//: [Previous](@previous)

import Foundation
//: [Next](@next)
class TreeNode {
    var value: Int
    var left: TreeNode?
    var right: TreeNode?

    init(value: Int) {
        self.value = value
    }
}

class BinaryTree {
    var root: TreeNode?

    // Method to insert a new node
    func insert(value: Int) {
        let newNode = TreeNode(value: value)
        if root == nil {
            root = newNode
        } else {
            insertRecursively(root, newNode)
        }
    }

    private func insertRecursively(_ current: TreeNode?, _ newNode: TreeNode) {
        guard let current = current else { return }
        
        if newNode.value < current.value {
            if current.left == nil {
                current.left = newNode
            } else {
                insertRecursively(current.left, newNode)
            }
        } else {
            if current.right == nil {
                current.right = newNode
            } else {
                insertRecursively(current.right, newNode)
            }
        }
    }

    // In-Order Traversal
    func inOrderTraversal(_ node: TreeNode?) {
        guard let node = node else { return }
        inOrderTraversal(node.left)
        print(node.value, terminator: " ")
        inOrderTraversal(node.right)
    }

    // Pre-Order Traversal
    func preOrderTraversal(_ node: TreeNode?) {
        guard let node = node else { return }
        print(node.value, terminator: " ")
        preOrderTraversal(node.left)
        preOrderTraversal(node.right)
    }

    // Post-Order Traversal
    func postOrderTraversal(_ node: TreeNode?) {
        guard let node = node else { return }
        postOrderTraversal(node.left)
        postOrderTraversal(node.right)
        print(node.value, terminator: " ")
    }
}

let binaryTree = BinaryTree()

// Insert values into the binary tree
binaryTree.insert(value: 5)
binaryTree.insert(value: 3)
binaryTree.insert(value: 7)
binaryTree.insert(value: 2)
binaryTree.insert(value: 4)
binaryTree.insert(value: 6)
binaryTree.insert(value: 8)

// Print the tree in different orders
print("In-Order Traversal:")
binaryTree.inOrderTraversal(binaryTree.root)  // Output: 2 3 4 5 6 7 8
print("\nPre-Order Traversal:")
binaryTree.preOrderTraversal(binaryTree.root) // Output: 5 3 2 4 7 6 8
print("\nPost-Order Traversal:")
binaryTree.postOrderTraversal(binaryTree.root) // Output: 2 4 3 6 8 7 5
