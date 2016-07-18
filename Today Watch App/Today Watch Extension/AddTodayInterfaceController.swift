//
//  AddTodayInterfaceController.swift
//  Today
//
//  Created by UetaMasamichi on 2016/01/21.
//  Copyright © 2016年 Masamichi Ueta. All rights reserved.
//

import WatchKit
import WatchConnectivity
import Foundation
import TodayWatchKit

protocol AddTodayInterfaceControllerDelegate: class {
    func todayDidAdd(_ score: Int)
}

final class AddTodayInterfaceController: WKInterfaceController {
    
    @IBOutlet var scorePicker: WKInterfacePicker!
    
    private var session: WCSession!
    private var score: Int = Today.maxMasterScore
    weak var delegate: ScoreInterfaceController?
    
    override func awake(withContext context: AnyObject?) {
        super.awake(withContext: context)
        
        if WCSession.isSupported() {
            session = WCSession.default()
            session.delegate = self
            session.activate()
        }
        
        delegate = context as? ScoreInterfaceController
        
        let pickerItems: [WKPickerItem] = Today.masterScores.map {
            let pickerItem = WKPickerItem()
            
            let watchSize = getWatchSize()
            
            switch watchSize {
            case .thirtyEight:
                pickerItem.contentImage = WKImage(imageName: "score_select_circle_38_\($0).png")
            case .fourtyTwo:
                pickerItem.contentImage = WKImage(imageName: "score_select_circle_42_\($0).png")
            }
            
            return pickerItem
        }
        
        scorePicker.setItems(pickerItems)
    }
    
    override func willActivate() {
        super.willActivate()
    }
    
    override func didDeactivate() {
        super.didDeactivate()
    }
    
    @IBAction func addToday() {
        if session.isReachable {
            let now = Date()
            session.sendMessage([watchConnectivityActionTypeKey: WatchConnectivityActionType.AddToday.rawValue, WatchConnectivityContentType.AddedScore.rawValue: score,
                WatchConnectivityContentType.AddedDate.rawValue: now],
                replyHandler: {
                    (content: [String: AnyObject]) -> Void in
                    var watchData = WatchData()
                    watchData.score = self.score
                    watchData.updatedAt = now
                    //self.delegate?.todayDidAdd(self.score)
                    self.dismiss()
                },
                errorHandler: {
                    (error) -> Void in
                    self.dismiss()
            })
        } else {
            self.dismiss()
        }
        
    }
    
    @IBAction func pickerItemDidChange(_ value: Int) {
        score = Today.masterScores[value]
    }
}

//MARK: - WCSessionDelegate
extension AddTodayInterfaceController: WCSessionDelegate {
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: NSError?) {
        
    }
}
