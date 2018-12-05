//
//  QueryViewController.swift
//  SqliteWork
//
//  Created by Prabhat on 04/12/18.
//  Copyright © 2018 Prabhat. All rights reserved.
//

import UIKit

class QueryViewController: UIViewController {

    @IBOutlet weak var playerIdSearch: UITextField!
    
    @IBOutlet weak var commulativeScore: UILabel!
    
    @IBOutlet weak var sessionBestScore: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Search Player Score"
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func searchDetail(_ sender: Any) {
        if playerIdSearch.text != nil{
     
        let playerScoreDao = PlayerScoreDAO()
        let playerScoreModelArray = playerScoreDao.query(playerId: playerIdSearch.text!)
        if playerScoreModelArray.count > 0{
            commulativeScore.text = playerScoreModelArray[0].commulative
            sessionBestScore.text = playerScoreModelArray[0].sessionBestScore
        }else{
            commulativeScore.text = "PlayerId detail doesnot exist."
            sessionBestScore.text = ""
        }
        }else{
            commulativeScore.text = "Search field is empty."
            sessionBestScore.text = ""
        }
    }
    
}
