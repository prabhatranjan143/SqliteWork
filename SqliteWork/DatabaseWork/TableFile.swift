

import Foundation
class TableFile {
    
    init() {
      
        self.createPlayerTable()
    }
    func createPlayerTable() {
        let db = MainDatabase()
        ConnectionPointers.createPlayerTablePointer = db.openDatabase()
        var columnArray = [String]()
        columnArray.append(Constant.PLAYER_ID_C1)
        columnArray.append(Constant.PLAYER_COMMULATIVE_C2)
        columnArray.append(Constant.PLAYER_SESSION_BEST_C3)
        if db.createTable(tableName: Constant.PLAYER_SCORE_TABLE, column: columnArray){
            print("App configuration table created.")
        }else{
            print("App configuration table creation faild.")
        }
    }
 
}

