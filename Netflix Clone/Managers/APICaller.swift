//
//  APICaller.swift
//  Netflix Clone
//
//  Created by 김준혁 on 2023/01/23.
//

import Foundation

struct Constants {
    static let API_Key = "49e73feee62af5c6b8a3c06b74d16b18"
    static let baseURL = "https://api.themoviedb.org"
    static let YoutubeAPI_Key = "AIzaSyDsJGEivldavDjsJqw-TObxOZ-FOS2WzFE"
    static let YoutubeBaseURL = "https://youtube.googleapis.com/youtube/v3/search?"
}


enum APIError : Error {
    case failedTogetData
    
}


class APICaller {
    static let shared = APICaller()
    
    func getTrendingMovies(completion: @escaping (Result<[Title], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/movie/day?api_key=\(Constants.API_Key)") else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(TrendingTitleReponse.self, from: data)
                completion(.success(results.results)) // 성공하면 TrendingMoviesReponse.results를 반환
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    
    func getTrendingTvs(completion: @escaping (Result<[Title], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/tv/day?api_key=\(Constants.API_Key)") else { return }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data , error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(TrendingTitleReponse.self, from: data)
                completion(.success(results.results)) // 성공하면 TrendingMoviesReponse.results를 반환
            } catch {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    
    func getUpcomingMovies (completion: @escaping (Result<[Title], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/upcoming?api_key=\(Constants.API_Key)&language=en-US&page=1") else { return }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(TrendingTitleReponse.self, from: data)
                completion(.success(results.results)) // 성공하면 TrendingMoviesReponse.results를 반환
            } catch {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    
    func getPopular (completion: @escaping (Result<[Title], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/popular?api_key=\(Constants.API_Key)&language=en-US&page=1") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(TrendingTitleReponse.self, from: data)
                completion(.success(results.results)) // 성공하면 TrendingMoviesReponse.results를 반환
            } catch {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    
    
    func getTopRated(completion: @escaping (Result<[Title], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/top_rated?api_key=\(Constants.API_Key)&language=en-US&page=1") else { return }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let results = try JSONDecoder().decode(TrendingTitleReponse.self, from: data)
                completion(.success(results.results)) // 성공하면 TrendingMoviesReponse.results를 반환
            } catch {
                print(error.localizedDescription)
            }
        }
        task.resume()

    }

    func getDiscoverMovies(completion: @escaping (Result<[Title], Error>) -> Void) {
        //https://api.themoviedb.org/3/discover/movie?api_key=<<api_key>>&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate
        guard let url = URL(string: "\(Constants.baseURL)/3/discover/movie?api_key=\(Constants.API_Key)&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate") else { return }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let results = try JSONDecoder().decode(TrendingTitleReponse.self, from: data)
                completion(.success(results.results)) // 성공하면 TrendingMoviesReponse.results를 반환
            } catch {
                print(error.localizedDescription)
            }
        }
        task.resume()

    }
    
    func search(with query: String,completion: @escaping (Result<[Title], Error>) -> Void) {
        //https://api.themoviedb.org/3/search/movie?api_key={api_key}&query=Jack+Reacher
        
        // That takes care of url things..
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
        
        guard let url = URL(string: "\(Constants.baseURL)/3/search/movie?api_key=\(Constants.API_Key)&query=\(query)") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let results = try JSONDecoder().decode(TrendingTitleReponse.self, from: data)
                completion(.success(results.results)) // 성공하면 TrendingMoviesReponse.results를 반환
            } catch {
                print(error.localizedDescription)
            }
        }
        task.resume()

    }
    
    func getMovie(with query : String,completion: @escaping (Result<VideoElement, Error>) -> Void) {
        
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
        guard let url = URL(string: "\(Constants.YoutubeBaseURL)q=\(query)&key=\(Constants.YoutubeAPI_Key)") else {return}
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let results = try JSONDecoder().decode(YouTubeSearchResponse.self, from: data)
                completion(.success(results.items[0]))
            } catch {
                completion(.failure(error))
                print(error.localizedDescription)
            }
        }
        task.resume()


    }
    
}









//https://api.themoviedb.org/3/discover/movie?api_key=<<api_key>>&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate


// https://api.themoviedb.org/3/movie/upcoming?api_key=<<api_key>>&language=en-US&page=1
