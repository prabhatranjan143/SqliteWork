//
//  ViewController.swift
//  SqliteWork
//
//  Created by Prabhat on 04/12/18.
//  Copyright © 2018 Prabhat. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var playerId: UITextField!
    
    @IBOutlet weak var commulativeScore: UITextField!
    
    @IBOutlet weak var SeesionBestScore: UITextField!
    let testVariable = "Hello"
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add Player Score"
        let tableCreate = TableFile()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func saveValues(_ sender: Any) {
        if playerId.text != nil && commulativeScore.text != nil && SeesionBestScore.text != nil{
            let playerScoreModel = PlayerSessionScoreModel()
            let playerScoreDao = PlayerScoreDAO()
            let playerModelArray = playerScoreDao.query(playerId: playerId.text!)
            if playerModelArray.count > 0 {
                var previousCommulativeValue:Int64? = Int64(playerModelArray[0].commulative)
                var currentCommulativeScore:Int64? = Int64(commulativeScore.text!)
                var totalCommulativeScore = previousCommulativeValue! + currentCommulativeScore!
                playerScoreModel.commulative = "\(totalCommulativeScore)"
            }else{
                
                playerScoreModel.commulative = commulativeScore.text
                
            }
            playerScoreModel.playerId = playerId.text
            playerScoreModel.sessionBestScore = SeesionBestScore.text
            
            playerScoreDao.saveAccountState(playerScoreModel: playerScoreModel)
            performSegue(withIdentifier: "QueryValueSegue", sender: self)
        }else{
            // Show alert for empty textField
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! QueryViewController
        commulativeScore.text = ""
        SeesionBestScore.text = ""
    }
}

