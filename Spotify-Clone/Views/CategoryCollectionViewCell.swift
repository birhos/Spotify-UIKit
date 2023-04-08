//
//  CategoryCollectionViewCell.swift
//  Spotify-Clone
//
//  Created by Haydar Demir on 27.03.2023.
//

import UIKit
import SDWebImage

final class CategoryCollectionViewCell: UICollectionViewCell {
    enum Identifier: String {
        case custom = "CategoryCollectionViewCell"
    }
    
    private let imageView: UIImageView = {
        let value = UIImageView()
        value.contentMode = .scaleAspectFit
        value.tintColor = .white
        value.image = UIImage(systemName: "music.quarternote.3", withConfiguration: UIImage.SymbolConfiguration(pointSize: 50, weight: .regular))
        return value
    }()
    
    private let label: UILabel = {
        let value = UILabel()
        value.textColor = .white
        value.font = .systemFont(ofSize: 22, weight: .semibold)
        return value
    }()
    
    private let colors: [UIColor] = [
        .systemPink,
        .systemBlue,
        .systemPurple,
        .systemOrange,
        .systemGreen,
        .systemRed,
        .systemYellow,
        .systemTeal,
        .darkGray,
    ]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
        contentView.addSubview(label)
        contentView.addSubview(imageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        label.text = nil
        imageView.image = UIImage(systemName: "music.quarternote.3", withConfiguration: UIImage.SymbolConfiguration(pointSize: 50, weight: .regular))
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        label.frame = CGRect(x: 10, y: contentView.height / 2, width: contentView.width - 20, height: contentView.height / 2)
        imageView.frame = CGRect(x: contentView.width / 2, y: 10, width: contentView.width / 2, height: contentView.height / 2)
    }
    
    func configure(with viewModel: CategoryCollectionViewCellViewModel) {
        label.text = viewModel.title
        imageView.sd_setImage(with: viewModel.artworkURL, completed: nil)
        contentView.backgroundColor = colors.randomElement()
    }
}
