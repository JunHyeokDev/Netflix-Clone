//
//  Tv.swift
//  Netflix Clone
//
//  Created by 김준혁 on 2023/01/23.
//

import Foundation

struct TrendingTvReponse: Codable {
    let results : [Tv]
}


struct Tv: Codable {
    let id : Int
    let media_type : String? // if db dosen't give the basic info, then it can be nil
    let original_name : String?
    let original_title : String?
    let poster_path : String?
    let overview : String?
    let vote_count: Int
    let release_date : String?
    let vote_average: Double
}
