//
//  SetupViewController.swift
//  SpartanPushUps
//
//  Created by Rijad Babovic on 03/06/2019.
//  Copyright © 2019 Rijad Babovic. All rights reserved.
//

import UIKit

class SetupViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.layer.contents = UIImage.loadImageData("bg.png")?.cgImage
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBarTransparent()
    }
}
