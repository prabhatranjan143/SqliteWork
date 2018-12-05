

import Foundation
class AppConfigDao {
    
    let db = MainDatabase(path:Constant.PATH!, databaseName: Constant.appConfigDB)
 
    
    func queryAllValue()->[AppConfigModel]{
        var modelArray = [AppConfigModel]()
        var columnArray = [String]()
        columnArray.append(Constant.nameC1)
        columnArray.append(Constant.valueC2)
        
        let returnValues = db.queryMultiple(tableName: Constant.appConfigTableName, columnArray: columnArray, opaquePointer: ConnectionPointers.appConfigPointer)
        print("Values in array : \(returnValues.count)")
        for (index, values) in returnValues.enumerated(){
            let appConfig = AppConfigModel()
            appConfig.name = values[Constant.nameC1]
            appConfig.value = values[Constant.valueC2]
            modelArray.append(appConfig)
        }
        return modelArray
    }
  
    func isDataExist(appConfigModel:AppConfigModel)->Bool{
        var columnArray = [String]()
        columnArray.append(Constant.nameC1)
        columnArray.append(Constant.valueC2)
       
        let value = db.query(tableName: Constant.appConfigTableName, columnArray: columnArray, columnName: Constant.nameC1, columnValue: appConfigModel.name, opaquePointer: ConnectionPointers.appConfigPointer)
        if value.count>0{
            return true
        }else{
            return false
        }
    }
}
