//
//  NewsCell.swift
//  NewyorkTime
//
//  Created by Alok Sagar on 31/03/22.
//

import UIKit

class NewsCell: UITableViewCell {
    
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var titleContianer: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var snippetLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var container: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        container.dropShadow()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //Confiture cell with news item
    func configWithNews(newsItem:News){
        self.titleLabel.text = newsItem.headline?.main ?? ""
        self.titleLabel.accessibilityIdentifier = "NewsTitleLabel"
        self.snippetLabel.accessibilityIdentifier = "NewsSnippetLabel"
        self.snippetLabel.text = newsItem.snippet ?? ""
        
        if let imageUrL = newsItem.imageURL,!imageUrL.isEmpty{
            self.newsImageView.loadImageFrom(url: imageUrL,placeHolder: UIImage.init(named: "news_placeHolder")!)
        } else {
            self.newsImageView.image = UIImage.init(named: "news_placeHolder")
        }
        self.dateLabel.text = newsItem.readableDateString
        
    }

}
