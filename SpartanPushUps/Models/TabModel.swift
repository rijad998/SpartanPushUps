//
//  TabModel.swift
//  SpartanPushUps
//
//  Created by Rijad Babovic on 24/06/2019.
//  Copyright © 2019 Rijad Babovic. All rights reserved.
//

import Foundation

class TabModel {
    fileprivate var id = 0
    fileprivate var title: String = ""
    fileprivate var seriesExercise: RoundNodeSeries?
    fileprivate var selectedState: TabStateSelect = .notSelected
    fileprivate var pushupTypeState: PushupState?
    
    init(id: Int, title: String, seriesExercies: RoundNodeSeries?, pushupTypeState: PushupState?){
        self.id = id
        self.title = title
        self.seriesExercise = seriesExercies
        self.pushupTypeState = pushupTypeState
    }
}
