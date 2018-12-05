

import Foundation
class AccountDao {
    
    let db = MainDatabase()
    
    func saveAccountState(accountModel:AccountModel){
        
            if isDataExist(){
                self.updateValue(accountModel: accountModel)
            }else{
                self.insertValue(accountModel: accountModel)
            }
    
    }
    
    func insertValue(accountModel:AccountModel){
        var insertDictionary = [[String:String]]()
        insertDictionary.append([Constant.g_suitC1:accountModel.gsuit])
        insertDictionary.append([Constant.office365C2:accountModel.office365])
        db.insert(tableName: Constant.accountTable, valuesArray: insertDictionary, opaquePointer: ConnectionPointers.createAccountDatabasePointer)
    }
    
    func updateValue(accountModel:AccountModel) {
        var valueDic = [String:String]()
        valueDic.updateValue(accountModel.gsuit, forKey: Constant.g_suitC1)
        valueDic.updateValue(accountModel.office365, forKey: Constant.office365C2)
        db.updateRow(tableName: Constant.accountTable, updateDictionary: valueDic, columnName: "Id", columnValue: "1", opaquePointer: ConnectionPointers.createAccountDatabasePointer)
    }
    func query()->[AccountModel]{
        var modelArray = [AccountModel]()
        var columnArray = [String]()
        columnArray.append(Constant.g_suitC1)
        columnArray.append(Constant.office365C2)
        
        //     DispatchQueue(label: "AppConfig").sync {
        let returnValues = db.query(tableName: Constant.accountTable, columnArray: columnArray, columnName: "Id", columnValue: "1", opaquePointer: ConnectionPointers.createAccountDatabasePointer)
        print("Values in array : \(returnValues.count)")
        for (index, values) in returnValues.enumerated(){
            let accountmodel = AccountModel()
            accountmodel.gsuit = values[Constant.g_suitC1]
            accountmodel.office365 = values[Constant.office365C2]
            modelArray.append(accountmodel)
        }
        //    }
        
        return modelArray
    }
    func isDataExist()->Bool{
        var columnArray = [String]()
        columnArray.append(Constant.g_suitC1)
        columnArray.append(Constant.office365C2)
        
        let value = db.query(tableName: Constant.accountTable, columnArray: columnArray, columnName: "Id", columnValue: "1", opaquePointer: ConnectionPointers.createAccountDatabasePointer)
        if value.count>0{
            return true
        }else{
            return false
        }
    }
}
