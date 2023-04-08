//
//  TitleHeaderCollectionReusableView.swift
//  Spotify-Clone
//
//  Created by Haydar Demir on 14.12.2022.
//

import UIKit

class TitleHeaderCollectionReusableView: UICollectionReusableView {
    enum Identifier: String {
        case custom = "TitleHeaderCollectionReusableView"
    }
    
    // MARK: - UI Components
    
    private let label: UILabel = {
        let value = UILabel()
        value.textColor = .label
        value.numberOfLines = 1
        value.font = .systemFont(ofSize: 22, weight: .regular)
        return value
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        addSubview(label)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = CGRect(x: 15, y: 0, width: width - 30, height: height)
    }
    
    func configure(with title: String) {
        label.text = title
    }
}
