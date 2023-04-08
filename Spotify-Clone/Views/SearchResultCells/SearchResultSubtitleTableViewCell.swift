//
//  SearchResultSubtitleTableViewCell.swift
//  Spotify-Clone
//
//  Created by Haydar Demir on 30.03.2023.
//

import UIKit
import SDWebImage

final class SearchResultSubtitleTableViewCell: UITableViewCell {
    enum Identifier: String {
        case custom = "SearchResultSubtitleTableViewCell"
    }
    
    private let label: UILabel = {
        let value = UILabel()
        value.numberOfLines = 1
        return value
    }()
    
    private let subTitleLabel: UILabel = {
        let value = UILabel()
        value.textColor = .secondaryLabel
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
        contentView.addSubview(subTitleLabel)
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
        
        let labelHeight = contentView.height / 2
        label.frame = CGRect(x: iconImageView.right + 10, y: 0, width: contentView.width - iconImageView.right - 15, height: labelHeight)
        subTitleLabel.frame = CGRect(x: iconImageView.right + 10, y: label.bottom, width: contentView.width - iconImageView.right - 15, height: labelHeight)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        label.text = nil
        subTitleLabel.text = nil
        iconImageView.image = nil
    }
    
    func configure(with viewModel: SearchResultSubtitleTableViewCellViewModel) {
        label.text = viewModel.title
        subTitleLabel.text = viewModel.subTitle
        iconImageView.sd_setImage(with: viewModel.imageURL, placeholderImage: UIImage(systemName: "photo"), completed: nil)
    }
}
