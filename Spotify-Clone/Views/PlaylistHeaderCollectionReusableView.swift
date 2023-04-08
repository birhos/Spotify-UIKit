//
//  PlaylistHeaderCollectionReusableView.swift
//  Spotify-Clone
//
//  Created by Haydar Demir on 27.11.2022.
//

import UIKit
import SDWebImage

protocol PlaylistHeaderCollectionReusableViewDelegate: AnyObject {
    func playlistHeaderCollectionReusableViewDidTapPlayAll(_ header: PlaylistHeaderCollectionReusableView)
}

class PlaylistHeaderCollectionReusableView: UICollectionReusableView {
    enum Identifier: String {
        case custom = "PlaylistHeaderCollectionReusableView"
    }
    
    weak var delegate: PlaylistHeaderCollectionReusableViewDelegate?
    
    private let nameLabel: UILabel = {
        let value = UILabel()
        value.font = .systemFont(ofSize: 22, weight: .semibold)
        return value
    }()
    
    private let descriptionLabel: UILabel = {
        let value = UILabel()
        value.textColor = .secondaryLabel
        value.font = .systemFont(ofSize: 18, weight: .regular)
        value.numberOfLines = 0
        return value
    }()
    
    private let ownerLabel: UILabel = {
        let value = UILabel()
        value.textColor = .secondaryLabel
        value.font = .systemFont(ofSize: 18, weight: .light)
        return value
    }()
    
    private let imageView: UIImageView = {
        let value = UIImageView()
        value.contentMode = .scaleAspectFill
        value.image = UIImage(systemName: "photo")
        return value
    }()
    
    private let playAllButton: UIButton = {
        let value = UIButton()
        value.backgroundColor = .systemGreen
        let image = UIImage(systemName: "play.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30, weight: .regular))
        value.setImage(image, for: .normal)
        value.tintColor = .white
        value.layer.cornerRadius = 30
        value.layer.masksToBounds = true
        return value
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemBackground
        addSubviews()
        playAllButton.addTarget(self, action: #selector(didTapPlayAll), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        addSubview(nameLabel)
        addSubview(descriptionLabel)
        addSubview(ownerLabel)
        addSubview(imageView)
        addSubview(playAllButton)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let imageSize: CGFloat = height / 1.8
        imageView.frame = CGRect(x: (width - imageSize) / 2, y: 20, width: imageSize, height: imageSize)
        
        nameLabel.frame = CGRect(x: 10, y: imageView.bottom, width: width - 20, height: 44)
        descriptionLabel.frame = CGRect(x: 10, y: nameLabel.bottom, width: width - 20, height: 44)
        ownerLabel.frame = CGRect(x: 10, y: descriptionLabel.bottom, width: width - 20, height: 44)
        
        playAllButton.frame = CGRect(x: width - 80, y: height - 80, width: 60, height: 60)
    }
    
    func configure(with viewModel: PlaylistHeaderViewViewModel) {
        nameLabel.text = viewModel.name
        descriptionLabel.text = viewModel.description
        ownerLabel.text = viewModel.ownerName
        imageView.sd_setImage(with: viewModel.artworkURL, placeholderImage: UIImage(systemName: "photo"), completed: nil)
    }
    
    @objc private func didTapPlayAll() {
        delegate?.playlistHeaderCollectionReusableViewDidTapPlayAll(self)
    }
}
