//
//  SetupViewController.swift
//  SpartanPushUps
//
//  Created by Rijad Babovic on 03/06/2019.
//  Copyright © 2019 Rijad Babovic. All rights reserved.
//

import UIKit

class SetupViewController: UIViewController {
    
    let tabViewLevel: TabPicker = TabPicker(tabType: .level)
    let tabViewPushupType: TabPicker = TabPicker(tabType: .pushup)
    let doneBtn = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.layer.contents = UIImage.loadImageData("bg.png")?.cgImage
        setup()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layout()
    }
    
    func layout(){
        tabViewLevel.onSide(.top, topOffset, width: self.view.width, height: tabViewLevel.height)
        tabViewPushupType.onSide(.top, tabViewLevel.frame.maxY + 26, width: self.view.width, height: tabViewPushupType.height)
        doneBtn.onSide(.bottom, bottomOffset, width: self.view.frame.width - 38, height: 50)
    }
    
    func setup(){
        doneBtn.backgroundColor = UIColor.init(hex: "304FFE").withAlphaComponent(1)
        doneBtn.setTitle("DONE", for: .normal)
        doneBtn.addTarget(self, action: #selector(openMainController(sender:)), for: .touchUpInside)
        doneBtn.layer.cornerRadius = 25
        
        self.view.addSubview(tabViewLevel)
        self.view.addSubview(tabViewPushupType)
        self.view.addSubview(doneBtn)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBarTransparent()
    }
    
    @objc func openMainController(sender: UIButton){
        let mainController = MainViewController()
        self.navigationController?.pushViewController(mainController, animated: true)
    }
}
