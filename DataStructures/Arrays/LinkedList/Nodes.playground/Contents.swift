import UIKit

class Node {
    
    var data: Int
    var next: Node?
    
    init(_ data: Int, _ next: Node? = nil) {
        self.data = data
        self.next = next
    }
}


class LinkList {
    private var head: Node?
        
    func addFront(_ data: Int) {
        let node = Node(data)
        node.next = head
        head = node       
    }

    func getFirst() -> Int? {
        return 0
    }

    func addBack(_ data: Int) {
    }

    func getLast() -> Int? {
        return nil
    }

    func insert(position: Int, data: Int) {
        if position == 0 {
            addFront(data)
            return
        }
        
        let newNode = Node(data)
        var currentNode = head
        
        for _ in 0..<position - 1 {
            currentNode = currentNode?.next!
        }
        
        newNode.next = currentNode?.next
        currentNode?.next = newNode
    }
    
    func deleteFirst() {
    }

    func deleteLast() {
    }
    
    func delete(at position: Int) {
    }
    
    var isEmpty: Bool {
        return false
    }
    
    func clear() {
    }
    
    func printLinkedList() {
        if head == nil { return }
        
        var result = [Int]()
        var node = head
        result.append(node!.data)
        
        while node?.next != nil {
            result.append(node!.next!.data)
            node = node?.next
        }
        print(result)
    }
}

let linkList = LinkList()
linkList.addFront(1)
linkList.addFront(2)
linkList.addFront(3)
linkList.addFront(4)
linkList.addFront(6)
linkList.addFront(7)
linkList.printLinkedList()
linkList.insert(position: 4, data: 5)
linkList.printLinkedList()
