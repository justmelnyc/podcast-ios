//
//  InternalProfileHeaderView.swift
//  Podcast
//
//  Created by Drew Dunne on 3/7/17.
//  Copyright © 2017 Cornell App Development. All rights reserved.
//

import UIKit

protocol InternalProfileHeaderViewDelegate {
    func internalProfileHeaderViewDidPressViewProfile(internalProfileHeaderView: InternalProfileHeaderView)
}

class InternalProfileHeaderView: UIView {
    
    static let height: CGFloat = 96
    
    let height: CGFloat = InternalProfileHeaderView.height
    let profileImageSideLength: CGFloat = 60
    let profileImageX: CGFloat = 18
    let padding: CGFloat = 12
    let nameLabelY: CGFloat = 31
    let nameLabelHeight: CGFloat = 17
    let viewProfileLabelY: CGFloat = 51
    let viewProfileLabelHeight: CGFloat = 14.5
    let separatorHeight: CGFloat = 1
    
    var viewProfileButton: UIButton!
    var profileImage: ImageView!
    var nameLabel: UILabel!
    var viewProfileLabel: UILabel!
    var separator: UIView!
    
    var delegate: InternalProfileHeaderViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .podcastWhite
        
        profileImage = ImageView(frame: CGRect(x: profileImageX, y: (height - profileImageSideLength) / 2, width: profileImageSideLength, height: profileImageSideLength))
        profileImage.layer.cornerRadius = profileImageSideLength / 2
        profileImage.clipsToBounds = true
        profileImage.backgroundColor = .podcastWhiteDark
        addSubview(profileImage)
        
        nameLabel = UILabel(frame: .zero)
        nameLabel.font = .systemFont(ofSize: 14, weight: UIFontWeightSemibold)
        nameLabel.textColor = .podcastBlack
        nameLabel.textAlignment = .left
        addSubview(nameLabel)
        
        viewProfileLabel = UILabel(frame: .zero)
        viewProfileLabel.font = .systemFont(ofSize: 12, weight: UIFontWeightRegular)
        viewProfileLabel.textColor = .podcastTealBackground
        viewProfileLabel.textAlignment = .left
        viewProfileLabel.text = "View your profile"
        addSubview(viewProfileLabel)
        
        separator = UIView(frame: .zero)
        separator.backgroundColor = .podcastGray
        addSubview(separator)
        
        viewProfileButton = UIButton(type: .custom)
        viewProfileButton.backgroundColor = .clear
        viewProfileButton.addTarget(self, action: #selector(viewProfilePressed), for: .touchUpInside)
        addSubview(viewProfileButton)
        
    }
    
    override func layoutSubviews() {
        profileImage.frame = CGRect(x: profileImageX, y: (height - profileImageSideLength) / 2, width: profileImageSideLength, height: profileImageSideLength)
        profileImage.layer.cornerRadius = profileImageSideLength / 2
        nameLabel.frame = CGRect(x: profileImageX + profileImageSideLength + padding, y: nameLabelY, width: frame.width - (profileImageX + profileImageSideLength + 2 * padding), height: nameLabelHeight)
        viewProfileLabel.frame = CGRect(x: profileImageX + profileImageSideLength + padding, y: viewProfileLabelY, width: frame.width - (profileImageX + profileImageSideLength + 2 * padding), height: viewProfileLabelHeight)
        viewProfileButton.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        separator.frame = CGRect(x: 0, y: frame.height - separatorHeight, width: frame.width, height: separatorHeight)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func viewProfilePressed() {
        delegate?.internalProfileHeaderViewDidPressViewProfile(internalProfileHeaderView: self)
    }
    
    func setUser(_ user: User) {
        nameLabel.text = user.fullName()
        
        if let url = user.imageURL {
            profileImage.setImageAsynchronously(url: url, completion: nil)
        } else {
            profileImage.image = #imageLiteral(resourceName: "sample_profile_pic")
        }
    }

}
