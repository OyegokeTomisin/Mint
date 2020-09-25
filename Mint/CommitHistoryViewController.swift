//
//  CommitHistoryViewController.swift
//  Mint
//
//  Created by OYEGOKE TOMISIN on 25/09/2020.
//  Copyright © 2020 OYEGOKE TOMISIN. All rights reserved.
//

import UIKit

class CommitHistoryViewController: UIViewController {

    @IBOutlet weak var emptyStateStack: UIStackView!
    @IBOutlet weak var commitHistoryTable: UITableView!

    private lazy var refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
    }

    private func setupTable() {
        commitHistoryTable.tableFooterView = UIView()
        commitHistoryTable.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshTableView), for: .valueChanged)
        let nib = UINib(nibName: CommitHistoryTableViewCell.cellIdentifier, bundle: nil)
        commitHistoryTable.register(nib, forCellReuseIdentifier: CommitHistoryTableViewCell.cellIdentifier)
    }

    @objc private func refreshTableView() {

    }
}

extension CommitHistoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CommitHistoryTableViewCell.cellIdentifier)
            as? CommitHistoryTableViewCell else { return UITableViewCell() }
        return cell
    }
}
