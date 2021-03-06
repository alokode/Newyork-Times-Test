//
//  HomeViewModel.swift
//  NewyorkTime
//
//  Created by Alok Sagar on 02/04/22.
//

import Foundation

class HomeViewModel {
    var page:Int = 0
    var didLoadNews:((Bool)->()) = {_ in }
    var showLoader:((Bool)->()) = {_ in }
    var news:[News] = []
    var isDataLoading = false
    
    //To fetch news with page number
    func getNews(){
        isDataLoading = true
        let api : APIS = .articleSearch(page: page)
        self.showLoader(true)
        NetworkManager.sharedManager.fetchData(api: api) {[weak self] (result:Result<[News],Error>) in
            self?.showLoader(false)
            self?.isDataLoading = false
            switch result {
            case .success(let response):
                self?.page += 1
                self?.news.append(contentsOf: response)
                self?.didLoadNews(!response.isEmpty)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    //To prefetch news if the data not loaded already
    //If user scrolls to half othe current news item count then load next
    func prefetchNewsIfNeeded(for indexPath:IndexPath?){
        guard let firstRow  = indexPath, !isDataLoading else {
            return
        }
        print("#prefetch  try \(firstRow.row ) out of \(news.count)")
        if firstRow.row >= (news.count / 2)  {
            print("#prefetch \(firstRow.row )")
            self.getNews()
        }
    }
    
    //To return news item at index
    func getNewsItem(at index:Int) -> News?{
        guard news.count > index else {
            return nil
        }
        return news[index]
    }
}
