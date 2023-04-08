//
//  AlbumTrackCollectionViewCell.swift
//  Spotify-Clone
//
//  Created by Haydar Demir on 21.03.2023.
//

import UIKit

final class AlbumTrackCollectionViewCell: UICollectionViewCell {
    enum Identifier: String {
        case custom = "AlbumTrackCollectionViewCell"
    }

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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        trackNameLabel.frame = CGRect(
            x: 10,
            y: 0,
            width: contentView.width - 15,
            height: contentView.height / 2
        )
        
        artistNameLabel.frame = CGRect(
            x: 10,
            y: contentView.height / 2,
            width: contentView.width - 15,
            height: contentView.height / 2
        )
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        trackNameLabel.text = nil
        artistNameLabel.text = nil
    }
    
    func configure(with viewModel: AlbumCollectionViewCellViewModel) {
        trackNameLabel.text = viewModel.name
        artistNameLabel.text = viewModel.artistName
    }
}
