//
//  ViewModel.swift
//  AssetoneDemo
//
//  Created by DEVM-SUNDAR on 06/03/25.
//

import Foundation

protocol NewsDataUpdate:AnyObject {
    func updateArticles()
    func errorHandling(errorMessage:String)
}

class ViewModel {
    var articles: [Articles] = []
    var onNewsUpdated: (() -> Void)?
    weak var deleagte:NewsDataUpdate?
    var apiService: APIHandler = APIHandler.shared
    private let apiURL = "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=472123310e4d41f9be5e6a88c1c63ece"

    //API call to fetch data 
    func fetchNews() {
        APIHandler.shared.fetchData(from: apiURL, responseType: News_List_Data.self) { [weak self] result in
            switch result {
            case .success(let newsResponse):
                self?.articles = newsResponse.articles ?? []
                self?.deleagte?.updateArticles()
            case .failure(let error):
                print("Failed to fetch news: \(error)")
                self?.deleagte?.errorHandling(errorMessage: "Failed to fetch news: \(error)")
            }
        }
    }
}
