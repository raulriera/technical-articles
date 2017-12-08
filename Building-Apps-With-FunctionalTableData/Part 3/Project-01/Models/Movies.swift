//
//  Movies.swift
//  Project-01
//
//  Created by Raul Riera on 2017-12-03.
//  Copyright © 2017 Raul Riera. All rights reserved.
//

import Foundation

// Super simple list of movies, you probably want to fetch this from a remote repository

let toyStory: Movie = Movie(title: "Toy Story", summary: """
	Woody (Tom Hanks), a good-hearted cowboy doll who belongs to a young boy named Andy (John Morris), sees his position as Andy's favorite toy jeopardized when his parents buy him a Buzz Lightyear (Tim Allen) action figure.
	""", price: 14.99, url: URL(string: "https://itunes.apple.com/ca/movie/toy-story/id188703840")!, isFavorite: false)

let toyStory2: Movie = Movie(title: "Toy Story 2", summary: """
	The toys are back in town and ready to play once again on the big screen in Toy Story 2, the exciting sequel to the landmark 1995 animated blockbuster from Disney/Pixar. This comedy-adventure picks up as Andy heads off to Cowboy Camp leaving his toys to their own devices.
	""", price: 24.99, url: URL(string: "https://itunes.apple.com/ca/movie/toy-story-2/id268793231")!, isFavorite: false)

let findingNemo: Movie = Movie(title: "Finding Nemo", summary: """
	From the Academy Award®-winning creators of TOY STORY and MONSTERS, INC. (2001, Best Animated Short Film, FOR THE BIRDS), it's FINDING NEMO, a hilarious adventure where you'll meet colorful characters that take you into the breathtaking underwater world of Australia's Great Barrier Reef.
	""", price: 9.99, url: URL(string: "https://itunes.apple.com/ca/movie/finding-nemo/id255295077")!, isFavorite: false)
