//
//  CommitHistoryTableViewCell.swift
//  Mint
//
//  Created by OYEGOKE TOMISIN on 25/09/2020.
//  Copyright © 2020 OYEGOKE TOMISIN. All rights reserved.
//

import UIKit

class CommitHistoryTableViewCell: UITableViewCell {

    @IBOutlet weak var commitAuthorLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func configureCell(with commit: GitCommitResponse) {
        commitAuthorLabel.text = commit.commit?.author?.name
        subtitleLabel.text = commit.commit?.author?.email
    }
}
