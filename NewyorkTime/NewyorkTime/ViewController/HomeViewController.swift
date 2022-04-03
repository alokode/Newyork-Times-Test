//
//  ViewController.swift
//  NewyorkTime
//
//  Created by Alok Sagar on 31/03/22.
//

import UIKit

class HomeViewController: UIViewController,ActivityIndicatorPresenter {
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    @IBOutlet weak var tableView: UITableView!
    var viewModel : HomeViewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configViewModel()
        viewModel.getNews()
        configureUI()
        // Do any additional setup after loading the view.
    }
    
    func configureUI(){
        self.title = "New York Times"
        self.tableView.accessibilityIdentifier = "NewsTable"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    
//Configure viewModel
    func configViewModel(){
        viewModel.showLoader = { show in
            if show {
                self.showActivityIndicator()
            } else {
                self.hideActivityIndicator()
            }
        }
        viewModel.didLoadNews = { success in
            if success {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            }
        }
    }
}


extension HomeViewController : UITableViewDelegate, UITableViewDataSource, UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        viewModel.prefetchNewsIfNeeded(for: indexPaths.first)
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as? NewsCell
        cell?.configWithNews(newsItem: viewModel.news[indexPath.row])
        cell?.accessibilityIdentifier = "NewsCell_\(indexPath.row)"
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        300
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard  let detailsVC =  UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NewsDetailsViewController") as? NewsDetailsViewController, let newsItem = viewModel.getNewsItem(at: indexPath.row) else {return}
        detailsVC.newsItem = newsItem
        self.navigationController?.pushViewController(detailsVC, animated: true)
        
    }
    
}
