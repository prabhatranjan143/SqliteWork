//
//  PlayerScoreDAO.swift
//  SqliteWork
//
//  Created by Prabhat on 04/12/18.
//  Copyright © 2018 Prabhat. All rights reserved.
//

import Foundation
class PlayerScoreDAO  {
    let db = MainDatabase()
    func saveAccountState(playerScoreModel:PlayerSessionScoreModel){
        
        if isDataExist(playerId: playerScoreModel.playerId){
            self.updateValue(playerScoreModel: playerScoreModel)
        }else{
            self.insertValue(playerScoreModel: playerScoreModel)
        }
        
    }
    
    func insertValue(playerScoreModel:PlayerSessionScoreModel){
        var insertDictionary = [[String:String]]()
        insertDictionary.append([Constant.PLAYER_ID_C1:playerScoreModel.playerId])
        insertDictionary.append([Constant.PLAYER_COMMULATIVE_C2:playerScoreModel.commulative])
        insertDictionary.append([Constant.PLAYER_SESSION_BEST_C3:playerScoreModel.sessionBestScore])
        db.insertAutoIncrement(tableName: Constant.PLAYER_SCORE_TABLE, valuesArray: insertDictionary)
    }
    
    func updateValue(playerScoreModel:PlayerSessionScoreModel) {
        var valueDic = [String:String]()
        valueDic.updateValue(playerScoreModel.playerId, forKey: Constant.PLAYER_ID_C1)
        valueDic.updateValue(playerScoreModel.commulative, forKey: Constant.PLAYER_COMMULATIVE_C2)
        valueDic.updateValue(playerScoreModel.sessionBestScore, forKey: Constant.PLAYER_SESSION_BEST_C3)
        db.updateRow(tableName: Constant.PLAYER_SCORE_TABLE, updateDictionary: valueDic, columnName: Constant.PLAYER_ID_C1, columnValue: playerScoreModel.playerId)
    }
    
    
    func query(playerId:String)->[PlayerSessionScoreModel]{
        var modelArray = [PlayerSessionScoreModel]()
        var columnArray = [String]()
        columnArray.append(Constant.PLAYER_ID_C1)
        columnArray.append(Constant.PLAYER_COMMULATIVE_C2)
        columnArray.append(Constant.PLAYER_SESSION_BEST_C3)
       
        let returnValues = db.query(tableName: Constant.PLAYER_SCORE_TABLE, columnArray: columnArray, columnName: Constant.PLAYER_ID_C1, columnValue: playerId)
        print("Values in array : \(returnValues.count)")
        for (index, values) in returnValues.enumerated(){
            let playerScoreModel = PlayerSessionScoreModel()
            playerScoreModel.playerId = values[Constant.PLAYER_ID_C1]
            playerScoreModel.commulative = values[Constant.PLAYER_COMMULATIVE_C2]
            playerScoreModel.sessionBestScore = values[Constant.PLAYER_SESSION_BEST_C3]
            modelArray.append(playerScoreModel)
        }
        //    }
        
        return modelArray
    }
    func isDataExist(playerId:String)->Bool{
        var columnArray = [String]()
        columnArray.append(Constant.PLAYER_ID_C1)
        columnArray.append(Constant.PLAYER_COMMULATIVE_C2)
        columnArray.append(Constant.PLAYER_SESSION_BEST_C3)
        
        let value = db.query(tableName: Constant.PLAYER_SCORE_TABLE, columnArray: columnArray, columnName: Constant.PLAYER_ID_C1, columnValue: playerId)
        if value.count>0{
            return true
        }else{
            return false
        }
    }

}
