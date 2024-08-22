//
//  MovieListCollectionViewCell.swift
//  MovieStar
//
//  Created by Subhosting's MacBook Pro on 21/08/24.
//

import UIKit

// MARK: - Movie Collection View Cell

class MovieCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var favouriteButton: UIButton!
    
    var movie: Movie?
    var isFavorite: Bool = false {
        didSet {
            let favoriteImage = isFavorite ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
            favouriteButton.setImage(favoriteImage, for: .normal)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        favouriteButton.addTarget(self, action: #selector(toggleFavorite(_:)), for: .touchUpInside)
    }

    @objc private func toggleFavorite(_ sender: UIButton) {
        guard let movie = movie, let imdbId = movie.imdbId else { return }
        isFavorite.toggle()
        saveFavoriteState(imdbId: imdbId, isFavorite: isFavorite)
    }

    // Save favorite state to UserDefaults
    private func saveFavoriteState(imdbId: String, isFavorite: Bool) {
        var favorites = UserDefaults.standard.array(forKey: "favoriteMovies") as? [String] ?? []
        if isFavorite {
            if !favorites.contains(imdbId) {
                favorites.append(imdbId)
            }
        } else {
            if let index = favorites.firstIndex(of: imdbId) {
                favorites.remove(at: index)
            }
        }
        UserDefaults.standard.set(favorites, forKey: "favoriteMovies")
    }

    // Get favorite state from UserDefaults
    private func getFavoriteState(imdbId: String?) -> Bool {
        guard let imdbId = imdbId else { return false }
        let favorites = UserDefaults.standard.array(forKey: "favoriteMovies") as? [String] ?? []
        return favorites.contains(imdbId)
    }
}

// MARK: - Cell Configuration

extension MovieCollectionViewCell {

    func configure(movie: Movie) {
        self.movie = movie

        titleLabel.text = movie.title
        typeLabel.text = movie.type?.uppercased()

        if let year = movie.year {
            yearLabel.text = "(\(year))"
        } else {
            yearLabel.text = nil
        }

        isFavorite = getFavoriteState(imdbId: movie.imdbId)
        
        if !movie.hasPoster {
            showPoster(image: nil)
        }
    }

    func showPoster(image: UIImage?) {
        posterImageView.backgroundColor = UIColor(named: "MovieCellBackground")

        if image == nil {
            posterImageView.tintColor = UIColor(named: "Title")
            posterImageView.image = UIImage(systemName: "video")
            posterImageView.alpha = 0.05
        } else {
            posterImageView.image = image
            posterImageView.alpha = 1.0
        }
    }
}
