//
//  PlayerControlsView.swift
//  Spotify-Clone
//
//  Created by Haydar Demir on 6.04.2023.
//

import Foundation
import UIKit
 
protocol PlayerControlsViewDelegate: AnyObject {
    func playerControlsViewDidTapPlayPauseButton(_ playerControlsView: PlayerControlsView)
    func playerControlsViewDidTapForwardButton(_ playerControlsView: PlayerControlsView)
    func playerControlsViewDidTapPBackwardsButton(_ playerControlsView: PlayerControlsView)
    func playerControlsView(_ playerControlsView: PlayerControlsView, didSlideSlider value: Float)
}

struct PlayerControlsViewViewModel {
    let title: String?
    let subtitle: String?
}

final class PlayerControlsView: UIView{
    private var isPlaying = true
    
    weak var delegate: PlayerControlsViewDelegate?
    
    private var volumeSlider: UISlider = {
        let value = UISlider()
        value.value = 0.5
        return value
    }()
    
    private let nameLabel: UILabel = {
        let value = UILabel()
        value.numberOfLines = 1
        value.font = .systemFont(ofSize: 20, weight: .semibold)
        return value
    }()
    
    private let subtitleLabel: UILabel = {
        let value = UILabel()
        value.font = .systemFont(ofSize: 18, weight: .regular)
        return value
    }()
    
    private let backButton: UIButton = {
        let value = UIButton()
        value.tintColor = .label
        let image = UIImage(systemName: "backward.fill",withConfiguration: UIImage.SymbolConfiguration(pointSize: 34,weight: .regular))
        value.setImage(image, for: .normal)
        return value
    }()
    
    private let nextButton: UIButton = {
        let value = UIButton()
        value.tintColor = .label
        let image = UIImage(systemName: "forward.fill",withConfiguration: UIImage.SymbolConfiguration(pointSize: 34,weight: .regular))
        value.setImage(image, for: .normal)
        return value
    }()
    
    private let playPauseButton: UIButton = {
        let value = UIButton()
        value.tintColor = .label
        let image = UIImage(systemName: "pause",withConfiguration: UIImage.SymbolConfiguration(pointSize: 34,weight: .regular))
        value.setImage(image, for: .normal)
        return value
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        
        addSubview(nameLabel)
        addSubview(subtitleLabel)
        addSubview(volumeSlider)
        addSubview(backButton)
        addSubview(nextButton)
        addSubview(playPauseButton)
        
        backButton.addTarget(self, action: #selector(didTapBack), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(didTapNext), for: .touchUpInside)
        playPauseButton.addTarget(self, action: #selector(didTapPlayPause), for: .touchUpInside)
        
        volumeSlider.addTarget(self, action: #selector(didSlideSlider), for: .valueChanged)
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    @objc private func didTapBack(){
        delegate?.playerControlsViewDidTapPBackwardsButton(self)
    }
    
    @objc private func didTapNext(){
        delegate?.playerControlsViewDidTapForwardButton(self)
    }
    
    @objc private func didTapPlayPause(){
        self.isPlaying = !isPlaying
        delegate?.playerControlsViewDidTapForwardButton(self)
        let pause = UIImage(systemName: "pause",withConfiguration: UIImage.SymbolConfiguration(pointSize: 34,weight: .regular))
        let play = UIImage(systemName: "play.fill",withConfiguration: UIImage.SymbolConfiguration(pointSize: 34,weight: .regular))
        playPauseButton.setImage(isPlaying ? pause : play, for: .normal)
    }
    
    @objc private func didSlideSlider(_ slider: UISlider){
        let value = slider.value
        delegate?.playerControlsView(self, didSlideSlider: value)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        nameLabel.frame = CGRect(x: 0, y: 0, width: width, height: 50)
        subtitleLabel.frame = CGRect(x: 0, y: nameLabel.bottom+10, width: width, height: 50)
        volumeSlider.frame = CGRect(x: 10, y: subtitleLabel.bottom+20, width: width-20, height: 44)
        
        let buttonSize: CGFloat = 60
        playPauseButton.frame = CGRect(x: (width - buttonSize)/2, y: volumeSlider.bottom + 30, width: buttonSize, height: buttonSize)
        backButton.frame = CGRect(x: playPauseButton.left-80-buttonSize, y: playPauseButton.top, width: buttonSize, height: buttonSize)
        nextButton.frame = CGRect(x: playPauseButton.right+80, y: playPauseButton.top, width: buttonSize, height: buttonSize)
    }
    
    func configure(with ViewModel: PlayerControlsViewViewModel){
        nameLabel.text = ViewModel.title
        subtitleLabel.text = ViewModel.subtitle
    }
}
