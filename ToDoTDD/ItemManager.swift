//
//  ItemManager.swift
//  ToDoTDD
//
//  Created by Joesus on 9/13/17.
//  Copyright © 2017 Aetna. All rights reserved.
//

import Foundation

class ItemManager {

    var toDoCount: Int { return toDoItems.count }
    var doneCount: Int { return doneItems.count }
    private var toDoItems = [ToDoItem]()
    private var doneItems = [ToDoItem]()

    func add(_ item: ToDoItem) {
        if !toDoItems.contains(item) {
            toDoItems.append(item)
        }
    }

    func item(at index: Int) -> ToDoItem {
        return toDoItems[index]
    }

    func doneItem(at index: Int) -> ToDoItem {
        return doneItems[index]
    }

    func checkItem(at index: Int) {
        let item = toDoItems.remove(at: index)
        doneItems.append(item)
    }

    func uncheckItem(at index: Int) {
        let item = doneItems.remove(at: index)
        toDoItems.append(item)
    }

    func removeAll() {
        toDoItems.removeAll()
        doneItems.removeAll()
    }
}
