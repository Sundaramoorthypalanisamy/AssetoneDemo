//
//  ListItemCell.swift
//  AssetoneDemo
//
//  Created by DEVM-SUNDAR on 06/03/25.
//

import UIKit
protocol ReadMoreDelegate:AnyObject {
    func readmoreAction(readMoreIndex:IndexPath)
}

class ListItemCell: UITableViewCell {

    @IBOutlet weak var readMoreButton: UIButton!
    @IBOutlet weak var postContentLabel: UILabel!
    @IBOutlet weak var postDescriptionLabel: UILabel!
    @IBOutlet weak var postTitleLabel: UILabel!
    @IBOutlet weak var publishedDateLabel: UILabel!
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var bannerImage: UIImageView!
    weak var delegate:ReadMoreDelegate?
    var indexPath: IndexPath?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //To populate data in tableview cell
    
    func configureData(listItem:Articles) {
        
        postTitleLabel.text = listItem.title ?? ""
        postDescriptionLabel.text = listItem.description ?? ""
        postContentLabel.text = listItem.content ?? ""
        authorNameLabel.text = "Author \n" +  (listItem.author ?? "")
       
        if let localTime = PreferenceManager.shared.convertUTCToLocalTime(utcTime: listItem.publishedAt ?? "") {
            publishedDateLabel.text = "Published At \n\(localTime)"
        } else {
            publishedDateLabel.text = "Published At \n\(listItem.publishedAt ?? "N/A")"
        }
        Task {
                  if let urlString = listItem.urlToImage, let url = URL(string: urlString) {
                      if let image = await ImageLoader.shared.loadImage(from: url) {
                          await MainActor.run {
                              self.bannerImage.image = image
                              self.animateImage(delay: 0.2)
                          }
                      }
                  }
              }
        
        
    }
    private func animateImage(delay: Double) {
           self.bannerImage.alpha = 0
           DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
               UIView.animate(withDuration: 0.5) {
                   self.bannerImage.alpha = 1
               }
           }
       }
    @IBAction func actionReadMore(_ sender: Any) {
        guard let indexPath = indexPath else { return }
        delegate?.readmoreAction(readMoreIndex: indexPath)
        
    }
    
}
