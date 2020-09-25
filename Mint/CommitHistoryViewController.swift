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
    private lazy var recentCommits = [GitCommitResponse]()

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
        fetchRequest()
    }

    private func fetchRequest() {
        var service = GitHubRequestService()
        service.delegate = self
        service.fetchCommit()
    }
}

extension CommitHistoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        emptyStateStack.isHidden = recentCommits.count > 0
        return recentCommits.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CommitHistoryTableViewCell.cellIdentifier)
            as? CommitHistoryTableViewCell else { return UITableViewCell() }
        cell.configureCell(with: recentCommits[indexPath.row])
        return cell
    }
}

extension CommitHistoryViewController: GitCommitRequestProtocol {
    func didCompleteFetchWithSuccess(commits: [GitCommitResponse]) {
        recentCommits = commits
        commitHistoryTable.reloadData()
        commitHistoryTable.refreshControl?.endRefreshing()
    }

    func didCompleteFetchWithError(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
        commitHistoryTable.refreshControl?.endRefreshing()
    }
}
