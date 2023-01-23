//
//  Movie.swift
//  Netflix Clone
//
//  Created by 김준혁 on 2023/01/23.
//

import Foundation

struct TrendingMoviesReponse : Codable {
    let results : [Movie]
    
}




struct Movie : Codable {
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


/*
 
 {
adult = 0;
"backdrop_path" = "/ge9goiznnnAchCUfsw9XQiR2jNt.jpg";
"genre_ids" =             (
 878,
 28,
 12
);
id = 843794;
"media_type" = movie;
"original_language" = ko;
"original_title" = "\Uc815\Uc774";
overview = "On an uninhabitable 22nd-century Earth, the outcome of a civil war hinges on cloning the brain of an elite soldier to create a robot mercenary.";
popularity = "197.827";
"poster_path" = "/z2nfRxZCGFgAnVhb9pZO87TyTX5.jpg";
"release_date" = "2023-01-20";
title = "JUNG_E";
video = 0;
"vote_average" = "6.061";
"vote_count" = 82;
}*/
