//
//  ManageSettingHeaderView.swift
//  MMediaPicker
//
//  Created by Van Trieu Phu Huy on 12/2/20.
//

import UIKit

class ManageSettingHeaderView: UICollectionReusableView {
    
    @IBOutlet weak var textLabel: UILabel!
    
    @IBOutlet weak var settingButton: UIButton!
    
    @IBOutlet weak var containerView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        settingButton.clipsToBounds = true
        settingButton.titleLabel?.adjustsFontSizeToFitWidth = true
        settingButton.layer.cornerRadius = settingButton.frame.size.height / 2.0
    }
    
}
