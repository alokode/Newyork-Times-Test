//
//  NewsDetailsViewController.swift
//  NewyorkTime
//
//  Created by Alok Sagar on 03/04/22.
//

import UIKit

class NewsDetailsViewController: UIViewController {

    @IBOutlet weak var newsContentLabel: UILabel!
    @IBOutlet weak var newsTitleLabel: UILabel!
    @IBOutlet weak var newsImageView: UIImageView!
    var newsItem:News?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        // Do any additional setup after loading the view.
    }
    
    //Configure UI
    func configUI(){
        self.newsContentLabel.text = newsItem?.abstract ?? ""
        self.newsTitleLabel.accessibilityIdentifier = "NewsDetailsTitleLabel"
        self.newsTitleLabel.text = newsItem?.headline?.main ?? ""
        self.newsImageView.loadImageFrom(url: newsItem?.imageURL ?? "",placeHolder: UIImage.init(named: "news_placeHolder")!)
    }

    override func viewDidAppear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
