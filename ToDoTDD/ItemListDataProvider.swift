//
//  ItemListDataProvider.swift
//  ToDoTDD
//
//  Created by Joe Susnick on 9/16/17.
//  Copyright © 2017 Aetna. All rights reserved.
//

import UIKit

class ItemListDataProvider: NSObject, UITableViewDataSource, UITableViewDelegate {

    var itemManager: ItemManager?

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        guard let itemManager = itemManager,
            let itemSection = Section(rawValue: section) else {
                return 0
        }

        switch itemSection {
        case .toDo:
            return itemManager.toDoCount
        case .done:
            return itemManager.doneCount
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath)


        guard let itemCell = cell as? ItemCell,
            let itemManager = itemManager,
            let section = Section(rawValue: indexPath.section) else {
                return cell
        }

        let item: ToDoItem
        switch section {
        case .toDo:
            item = itemManager.item(at: indexPath.row)
        case .done:
            item = itemManager.doneItem(at: indexPath.row)
        }

        itemCell.configCell(with: item)

        return itemCell
    }

    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        guard let section = Section(rawValue: indexPath.section) else { return nil }

        switch section {
        case .toDo:
            return "Check"
        case .done:
            return "Uncheck"
        }
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        guard let itemManager = itemManager,
            let section = Section(rawValue: indexPath.section) else {
                return
        }

        switch section {
        case .toDo:
            itemManager.checkItem(at: indexPath.row)
        default:
            itemManager.uncheckItem(at: indexPath.row)
        }

        tableView.reloadData()
    }

}

enum Section: Int {
    case toDo, done
}
