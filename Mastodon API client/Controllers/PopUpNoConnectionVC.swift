//
//  PopUpNoConnectionVC.swift
//  Mastodon API client
//
//  Created by Danil on 19.02.2018.
//  Copyright © 2018 @Danil. All rights reserved.
//

import UIKit

class PopUpNoConnectionVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func popUpDisappearButton(_ sender: Any) {
        
        self.view.removeFromSuperview()
    }

}
    

