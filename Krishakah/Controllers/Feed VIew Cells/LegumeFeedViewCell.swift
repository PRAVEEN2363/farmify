
import UIKit

class LegumeFeedViewCell: UITableViewCell {
    
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemPrice: UILabel!
    @IBOutlet weak var itemDetails:UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    var contactButtonDelegate: FeedCellProtocol!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func contactButtonAction(_ sender: UIButton)
    {
        if contactButtonDelegate != nil
        {
            contactButtonDelegate.contactButtonClicked(tableCell: self)
        }
    }
}

//MARK:- FeedCellProtocol
protocol FeedCellProtocol
{
    func contactButtonClicked(tableCell: UITableViewCell)
}
