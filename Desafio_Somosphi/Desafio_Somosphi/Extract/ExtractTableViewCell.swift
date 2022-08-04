//
//  ExtractTableViewCell.swift
//  Desafio_Somosphi
//
//  Created by Suh on 04/08/22.
//

import UIKit

class ExtractTableViewCell: UITableViewCell {

    @IBOutlet weak var typeMovementLabel: UILabel!
    @IBOutlet weak var receiverLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var pixImage: UIView!
    @IBOutlet weak var circleView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
