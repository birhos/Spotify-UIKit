//
//  SearchResultsViewController.swift
//  Spotify-Clone
//
//  Created by Haydar Demir on 1.10.2022.
//

import UIKit

struct SearchSection {
    let title: String
    let results: [SearchResult]
}

protocol SearchResultsViewControllerDelegate: AnyObject {
    func didTapResult(_ result: SearchResult)
}

final class SearchResultsViewController: UIViewController {
    weak var delegate: SearchResultsViewControllerDelegate?
    
    private var sections: [SearchSection] = []
    
    private let tableView: UITableView = {
        let value = UITableView(frame: .zero, style: .grouped)
        value.register(SearchResultDefaultTableViewCell.self, forCellReuseIdentifier: SearchResultDefaultTableViewCell.Identifier.custom.rawValue)
        value.register(SearchResultSubtitleTableViewCell.self, forCellReuseIdentifier: SearchResultSubtitleTableViewCell.Identifier.custom.rawValue)
        value.isHidden = true
        return value
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .clear
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    func update(with results: [SearchResult]) {
        let artists = results.filter({
            switch $0 {
            case .artist: return true
            default: return false
            }
        })

        let albums = results.filter({
            switch $0 {
            case .album: return true
            default: return false
            }
        })

        let tracks = results.filter({
            switch $0 {
            case .track: return true
            default: return false
            }
        })

        let playlists = results.filter({
            switch $0 {
            case .playlist: return true
            default: return false
            }
        })

        self.sections = [
            SearchSection(title: "Track", results: tracks),
            SearchSection(title: "Artists", results: artists),
            SearchSection(title: "Playlists", results: playlists),
            SearchSection(title: "Albums", results: albums)
        ]
        
        tableView.reloadData()
        tableView.isHidden = results.isEmpty
    }
}

extension SearchResultsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let result = sections[indexPath.section].results[indexPath.row]
        
        switch result {
        case .artist(let artist):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultDefaultTableViewCell.Identifier.custom.rawValue, for: indexPath) as? SearchResultDefaultTableViewCell else {
                return UITableViewCell()
            }
            let viewModel = SearchResultDefaultTableViewCellViewModel(title: artist.name, imageURL: URL(string: artist.images?.first?.url ?? ""))
            cell.configure(with: viewModel)
            return cell
        case .album(let album):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultSubtitleTableViewCell.Identifier.custom.rawValue, for: indexPath) as? SearchResultSubtitleTableViewCell else {
                return UITableViewCell()
            }
            let viewModel = SearchResultSubtitleTableViewCellViewModel(title: album.name, subTitle: album.artists.first?.name ?? "", imageURL: URL(string: album.images.first?.url ?? ""))
            cell.configure(with: viewModel)
            return cell
        case .track(let track):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultSubtitleTableViewCell.Identifier.custom.rawValue, for: indexPath) as? SearchResultSubtitleTableViewCell else {
                return UITableViewCell()
            }
            let viewModel = SearchResultSubtitleTableViewCellViewModel(title: track.name, subTitle: track.artists.first?.name ?? "", imageURL: URL(string: track.album?.images.first?.url ?? ""))
            cell.configure(with: viewModel)
            return cell
        case .playlist(let playlist):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultSubtitleTableViewCell.Identifier.custom.rawValue, for: indexPath) as? SearchResultSubtitleTableViewCell else {
                return UITableViewCell()
            }
            let viewModel = SearchResultSubtitleTableViewCellViewModel(title: playlist.name, subTitle: playlist.owner.display_name, imageURL: URL(string: playlist.images.first?.url ?? ""))
            cell.configure(with: viewModel)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].title
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let result = sections[indexPath.section].results[indexPath.row]
        delegate?.didTapResult(result)
    }
}
