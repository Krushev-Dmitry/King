//
//  RaidsTableViewCell.swift
//  King
//
//  Created by 1111 on 28.07.21.
//

import UIKit

class RaidsTableViewCell: UITableViewCell {
    @IBOutlet weak var goldView: ResourceView!
    @IBOutlet weak var foodView: ResourceView!
    @IBOutlet weak var raidLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    var raid: Raid?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        goldView.image.image = #imageLiteral(resourceName: "gold")
        foodView.image.image = #imageLiteral(resourceName: "food")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func configureCell(_ raid: Raid){
        self.raid = raid
        goldView.label.text = String(raid.loot?.gold ?? 0)
        foodView.label.text = String(raid.loot?.food ?? 0)
        self.dateLabel.text = "Дата нападения \(CurrentDate.shared.dateInt)"
        
        self.backgroundColor = raid.sucsessOfRaid ? .red.withAlphaComponent(0.5) : .green.withAlphaComponent(0.5)
        self.raidLabel.text = raid.sucsessOfRaid ? "Защита города пала" : "Город успешно зашишен"
    }
    
}
