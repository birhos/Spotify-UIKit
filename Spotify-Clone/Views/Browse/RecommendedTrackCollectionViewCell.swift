//
//  RecommendedTrackCollectionViewCell.swift
//  Spotify-Clone
//
//  Created by Haydar Demir on 26.10.2022.
//

import UIKit

final class RecommendedTrackCollectionViewCell: UICollectionViewCell {
    enum Identifier: String {
        case custom = "RecommendedTrackCollectionViewCell"
    }
    
    private let albumCoverImageView: UIImageView = {
        let value = UIImageView()
        value.image = UIImage(systemName: "photo")
        value.contentMode = .scaleAspectFill
        return value
    }()
    
    private let trackNameLabel: UILabel = {
        let value = UILabel()
        value.font = .systemFont(ofSize: 18, weight: .regular)
        value.numberOfLines = 0
        return value
    }()
    
    private let artistNameLabel: UILabel = {
        let value = UILabel()
        value.font = .systemFont(ofSize: 15, weight: .thin)
        value.numberOfLines = 0
        return value
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .secondarySystemBackground
        contentView.backgroundColor = .secondarySystemBackground
        contentView.clipsToBounds = true
        
        contentView.addSubview(trackNameLabel)
        contentView.addSubview(artistNameLabel)
        contentView.addSubview(albumCoverImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        trackNameLabel.frame = CGRect(
            x: albumCoverImageView.right + 10,
            y: 0,
            width: contentView.width - albumCoverImageView.right - 15,
            height: contentView.height / 2
        )
        
        artistNameLabel.frame = CGRect(
            x: albumCoverImageView.right + 10,
            y: contentView.height / 2,
            width: contentView.width - albumCoverImageView.right - 15,
            height: contentView.height / 2
        )
        
        albumCoverImageView.frame = CGRect(
            x: 5,
            y: 2,
            width: contentView.height - 4,
            height: contentView.height - 4
        )
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        trackNameLabel.text = nil
        artistNameLabel.text = nil
        albumCoverImageView.image = nil
    }
    
    func configure(with viewModel: RecommendedTrackCellViewModel) {
        trackNameLabel.text = viewModel.name
        artistNameLabel.text = viewModel.artistName
        albumCoverImageView.sd_setImage(with: viewModel.artworkURL, completed: nil)
    }
}
