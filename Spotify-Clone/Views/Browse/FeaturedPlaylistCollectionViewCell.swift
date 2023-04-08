//
//  FeaturedPlaylistCollectionViewCell.swift
//  Spotify-Clone
//
//  Created by Haydar Demir on 26.10.2022.
//

import UIKit
import SDWebImage

final class FeaturedPlaylistCollectionViewCell: UICollectionViewCell {
    enum Identifier: String {
        case custom = "FeaturedPlaylistCollectionViewCell"
    }
    
    private let playlistCoverImageView: UIImageView = {
        let value = UIImageView()
        value.layer.masksToBounds = true
        value.layer.cornerRadius = 4
        value.image = UIImage(systemName: "photo")
        value.contentMode = .scaleAspectFill
        return value
    }()
    
    private let playlistNameLabel: UILabel = {
        let value = UILabel()
        value.font = .systemFont(ofSize: 18, weight: .regular)
        value.textAlignment = .center
        value.numberOfLines = 0
        return value
    }()
    
    private let creatorNameLabel: UILabel = {
        let value = UILabel()
        value.font = .systemFont(ofSize: 15, weight: .thin)
        value.textAlignment = .center
        value.numberOfLines = 0
        return value
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.clipsToBounds = true
        
        contentView.addSubview(playlistNameLabel)
        contentView.addSubview(creatorNameLabel)
        contentView.addSubview(playlistCoverImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        playlistNameLabel.frame = CGRect(
            x: 3,
            y: contentView.height - 60,
            width: contentView.width - 6,
            height: 30
        )
        
        creatorNameLabel.frame = CGRect(
            x: 3,
            y: contentView.height - 30,
            width: contentView.width - 6,
            height: 30
        )
        
        let imageSize = contentView.height - 70
        playlistCoverImageView.frame = CGRect(
            x: (contentView.width - imageSize) / 2,
            y: 3,
            width: imageSize,
            height: imageSize
        )
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        playlistNameLabel.text = nil
        creatorNameLabel.text = nil
        playlistCoverImageView.image = nil
    }
    
    func configure(with viewModel: FeaturedPlaylistCellViewModel) {
        playlistNameLabel.text = viewModel.name
        creatorNameLabel.text = viewModel.creatorName
        playlistCoverImageView.sd_setImage(with: viewModel.artworkURL, completed: nil)
    }
}
