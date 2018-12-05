

import Foundation
class ComplianceStateDao {
    let db = MainDatabase(path:Constant.PATH!, databaseName: Constant.complianceDB)
    
    
    
    func queryComplianceState()->[ComplianceStateObject]{
        var modelArray = [ComplianceStateObject]()
        var columnArray = [String]()
        columnArray.append(Constant.complianceStateC1)
        
        let returnValues = db.query(tableName: Constant.complianceStateTable, columnArray: columnArray, columnName: "Id", columnValue: "1", opaquePointer: ConnectionPointers.complianceTablePointer)
        
        for (index,values) in returnValues.enumerated(){
            var complianceState = ComplianceStateObject()
            complianceState.complianceStatus = values[Constant.complianceStateC1]
            
            modelArray.append(complianceState)
        }
        return modelArray
    }
    
    func deleteValues(){
        // c
    }
    
    func isComplianceStateDataExist()->Bool{
        var columnArray = [String]()
        columnArray.append(Constant.complianceStateC1)
        
        let returnValues = db.query(tableName: Constant.complianceStateTable, columnArray: columnArray, columnName: "Id", columnValue: "1", opaquePointer: ConnectionPointers.complianceTablePointer)
        if returnValues.count>0{
            return true
        }else{
            return false
        }
    }
}
