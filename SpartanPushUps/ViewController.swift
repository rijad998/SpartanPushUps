//
//  ViewController.swift
//  SpartanPushUps
//
//  Created by Rijad Babovic on 31/05/2019.
//  Copyright © 2019 Rijad Babovic. All rights reserved.
//

import Foundation
import UIKit

class ViewController: UIViewController {
    
    fileprivate let openSetupBtn = UIButton()
    fileprivate let progressBar = ProgressBarView(level: "NOVICE")
    fileprivate let roundNodeSeries = RoundNodeSeries()
    fileprivate let horizontalRule = HorizontalRule()
    fileprivate let horizontalRuleTwo = HorizontalRule()
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.layer.contents = UIImage.loadImageData("bg.png")?.cgImage
        
        controlSuperView()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layout()
    }
    
    func layout(){
        
        progressBar.onSide(.top, statusBarHeight + 5, width: progressBar.width, height: progressBar.height)
        horizontalRule.onSide(.top, statusBarHeight + progressBar.height + 5, width: horizontalRule.width, height: horizontalRule.height)
        roundNodeSeries.onSide(.top, statusBarHeight + progressBar.height + horizontalRule.height + 15, width: roundNodeSeries.width, height: roundNodeSeries.height)
        horizontalRuleTwo.onSide(.top, statusBarHeight + progressBar.height + horizontalRule.height +  roundNodeSeries.height + 5, width: horizontalRuleTwo.width, height: horizontalRuleTwo.height)
        
        let frameWidth = self.view.frame.width
        let frameHeight: CGFloat
        
        if DeviceProperty.isTypeX() {
            frameHeight = self.view.frame.height - 20
        } else {
            frameHeight = self.view.frame.height
        }
        
        openSetupBtn.frame = CGRect(x: 19, y: frameHeight - 70, width: frameWidth - 38, height: 50)
        openSetupBtn.titleLabel?.frame = CGRect(x: self.view.frame.width / 2 - 25, y: self.view.frame.height / 2 - 13, width: 50, height: 26)
        
    }
    
    
    func controlSuperView() {
        
        layout()
        setup()
        self.view.addSubview(openSetupBtn)
        self.view.addSubview(progressBar)
        self.view.addSubview(roundNodeSeries)
        self.view.addSubview(horizontalRule)
        self.view.addSubview(horizontalRuleTwo)
    }
    
    
    func setup() {
        
        openSetupBtn.layer.cornerRadius = 25
        openSetupBtn.backgroundColor = #colorLiteral(red: 0.1882352941, green: 0.3098039216, blue: 0.9960784314, alpha: 1)
        openSetupBtn.setTitle("SETUP", for: .normal)
        openSetupBtn.addTarget(self, action: #selector(openSetup(sender:)), for: .touchUpInside)
        
        progressBar.setup(progress: 87)
        
        roundNodeSeries.layout()
    }
    
    
    @objc func openSetup(sender: UIButton) {
        
        let setupController = SetupViewController()
        self.navigationController?.pushViewController(setupController, animated: true)
    }
}
