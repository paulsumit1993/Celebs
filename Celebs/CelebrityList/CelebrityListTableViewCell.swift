//
//  CelebrityListTableViewCell.swift
//  Celebs
//
//  Created by Sumit Paul on 18/11/18.
//  Copyright © 2018 Sumit Paul. All rights reserved.
//

import UIKit
import Kingfisher

class CelebrityListTableViewCell: UITableViewCell {

    @IBOutlet weak var celebrityImageView: UIImageView!
    @IBOutlet weak var celebrityFullNameLabel: UILabel!
    @IBOutlet weak var celebrityEmailIdLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        celebrityImageView.layer.cornerRadius = celebrityImageView.bounds.width / 2
        celebrityImageView.clipsToBounds = true
    }
    
    func configure(with celebrity: SSCelebrity) {
        celebrityImageView.kf.setImage(with: celebrity.imageUrl, placeholder: R.image.noun_profile())
        celebrityFullNameLabel.text = celebrity.fullName
        celebrityEmailIdLabel.text = celebrity.emailId
    }

}
