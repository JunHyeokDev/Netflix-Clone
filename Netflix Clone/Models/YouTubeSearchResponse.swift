//
//  YouTubeSearchResponse.swift
//  Netflix Clone
//
//  Created by 김준혁 on 2023/01/24.
//

import Foundation

struct YouTubeSearchResponse : Codable {
    let items: [VideoElement]
}

struct VideoElement : Codable {
    let id: IdVideoElement
}

struct IdVideoElement : Codable {
    let kind : String
    let videoId : String
}


//
//items =     (
//            {
//        etag = "Dun9Gd5-6IkHN9B_qHZvxS7Ea8M";
//        id =             {
//            kind = "youtube#video";
//            videoId = "flPvDtG-bfU";
//        };
//        kind = "youtube#searchResult";
//    },
