//
//  NewReleaseCollectionViewCell.swift
//  Spotify-Clone
//
//  Created by Haydar Demir on 26.10.2022.
//

import UIKit
import SDWebImage

final class NewReleaseCollectionViewCell: UICollectionViewCell {
    enum Identifier: String {
        case custom = "NewReleaseCollectionViewCell"
    }
    
    private let albumCoverImageView: UIImageView = {
        let value = UIImageView()
        value.image = UIImage(systemName: "photo")
        value.contentMode = .scaleAspectFill
        return value
    }()
    
    private let albumNameLabel: UILabel = {
        let value = UILabel()
        value.font = .systemFont(ofSize: 20, weight: .semibold)
        value.numberOfLines = 0
        return value
    }()
    
    private let numberOfTracksLabel: UILabel = {
        let value = UILabel()
        value.font = .systemFont(ofSize: 18, weight: .thin)
        value.numberOfLines = 0
        return value
    }()
    
    private let artistNameLabel: UILabel = {
        let value = UILabel()
        value.font = .systemFont(ofSize: 18, weight: .light)
        value.numberOfLines = 0
        return value
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .secondarySystemBackground
        contentView.clipsToBounds = true
        
        contentView.addSubview(albumCoverImageView)
        contentView.addSubview(albumNameLabel)
        contentView.addSubview(artistNameLabel)
        contentView.addSubview(numberOfTracksLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let imageSize: CGFloat = contentView.height - 10
        let albumLabelSize = albumNameLabel.sizeThatFits(CGSize(width: contentView.width - imageSize - 10, height: contentView.height - 10))
        
        artistNameLabel.sizeToFit()
        numberOfTracksLabel.sizeToFit()
        
        // Image
        albumCoverImageView.frame = CGRect(x: 5, y: 5, width: imageSize, height: imageSize)
        
        // Album Name Label
        let albumLabelHeight = min(60, albumLabelSize.height)
        
        albumNameLabel.frame = CGRect(
            x: albumCoverImageView.right + 10,
            y: 5,
            width: albumLabelSize.width,
            height: albumLabelHeight
        )
        
        artistNameLabel.frame = CGRect(
            x: albumCoverImageView.right + 10,
            y: albumNameLabel.bottom,
            width: contentView.width - albumCoverImageView.right - 10,
            height: 30
        )
        
        numberOfTracksLabel.frame = CGRect(
            x: albumCoverImageView.right + 10,
            y: contentView.bottom - 44,
            width: contentView.width,
            height: 44
        )
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        albumNameLabel.text = nil
        artistNameLabel.text = nil
        numberOfTracksLabel.text = nil
        albumCoverImageView.image = nil
    }
    
    func configure(with viewModel: NewReleasesCellViewModel) {
        albumNameLabel.text = viewModel.name
        artistNameLabel.text = viewModel.artistName
        numberOfTracksLabel.text = "Tracks: \(viewModel.numberOfTracks)"
        albumCoverImageView.sd_setImage(with: viewModel.artworkURL, completed: nil)
    }
}
