//
//  SearchResultDefaultTableViewCell.swift
//  Spotify-Clone
//
//  Created by Haydar Demir on 30.03.2023.
//

import UIKit
import SDWebImage

final class SearchResultDefaultTableViewCell: UITableViewCell {
    enum Identifier: String {
        case custom = "SearchResultDefaultTableViewCell"
    }
    
    private let label: UILabel = {
        let value = UILabel()
        value.numberOfLines = 1
        return value
    }()
    
    private let iconImageView: UIImageView = {
        let value = UIImageView()
        value.contentMode = .scaleAspectFill
        return value
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(label)
        contentView.addSubview(iconImageView)
        contentView.clipsToBounds = true
        accessoryType = .disclosureIndicator
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let imageSize: CGFloat = contentView.height - 10
        iconImageView.frame = CGRect(x: 10, y: 5, width: imageSize, height: imageSize)
        iconImageView.layer.cornerRadius = imageSize / 2
        iconImageView.layer.masksToBounds = true
        label.frame = CGRect(x: iconImageView.right + 10, y: 0, width: contentView.width - iconImageView.right - 15, height: contentView.height)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iconImageView.image = nil
        label.text = nil
    }
    
    func configure(with viewModel: SearchResultDefaultTableViewCellViewModel) {
        label.text = viewModel.title
        iconImageView.sd_setImage(with: viewModel.imageURL, completed: nil)
    }
}
