//
//  ArticleCell.swift
//  MindStudiosTask
//
//  Created by Sergey Tszyu on 22.06.16.
//  Copyright © 2016 Sergey Tszyu. All rights reserved.
//

import UIKit

class ArticleCell: UITableViewCell {

    @IBOutlet weak var thumbImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.thumbImage.layer.cornerRadius = self.thumbImage.frame.size.width / 2
        self.thumbImage.clipsToBounds = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
