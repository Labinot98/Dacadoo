//
//  TableViewManager.swift
//  Dacadoo
//
//  Created by Pajaziti Labinot on 14.5.24..
//

import UIKit

class TableViewManager<Item, Cell: UITableViewCell>: NSObject, UITableViewDelegate, UITableViewDataSource {
    var items: [Item] = []
    let configureCell: (Cell, Item) -> Void
    var didSelectItem: ((Item) -> Void)?

    init(items: [Item], configureCell: @escaping (Cell, Item) -> Void, didSelectItem: ((Item) -> Void)? = nil) {
        self.items = items
        self.configureCell = configureCell
        self.didSelectItem = didSelectItem
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: Cell.self), for: indexPath) as! Cell
        let item = items[indexPath.row]
        configureCell(cell, item)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        didSelectItem?(item)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
