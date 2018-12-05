

import Foundation
import SQLite3
class MainDatabase {
    var db: OpaquePointer? = nil
        let path = NSSearchPathForDirectoriesInDomains(
            .documentDirectory, .userDomainMask, true
            ).first!
    let databaseName = "Players_db"
    
//    var path: URL
//    var databaseName: String
//    init(path:URL, databaseName:String) {
//        self.path = path
//        self.databaseName = databaseName
//    }
    //    var path : URL!
    func openDatabase() -> OpaquePointer?
    {
        
        //  var path = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: Constant.appGroupId)
        
        if sqlite3_open("\(path)\(databaseName)", &db) == SQLITE_OK {
            print("Successfully opened connection to database at \(path)\(databaseName)")
           
            return db
        } else {
            print("Unable to open database. Verify that you created the directory described " +
                "in the Getting Started section.")
            print(Error.self)
            // PlaygroundPage.current.finishExecution()
            return nil
        }
    }
    // create Table
    func createTable(tableName:String,column:[String])->Bool {
        
        var queryString = ""
        
        for columnName in column{
            queryString += ", \(columnName) TEXT"
        }
        print("Query String : \(queryString)")
        let createTableString = "CREATE TABLE IF NOT EXISTS "+tableName+"(Id INTEGER PRIMARY KEY AUTOINCREMENT\(queryString));"
        print(createTableString)
        // 1
        
        var createTableStatement: OpaquePointer? = nil
        // 2
        if sqlite3_prepare_v2(ConnectionPointers.createPlayerTablePointer, createTableString, -1, &createTableStatement, nil) == SQLITE_OK {
            // 3
            if sqlite3_step(createTableStatement) == SQLITE_DONE {
                print("\(tableName) table created................................")
                
//                sqlite3_finalize(createTableStatement)
//                sqlite3_close(createTableStatement)
//                sqlite3_close(db)
                return true
            } else {
                let errorMessage = String.init(cString: sqlite3_errmsg(db))
                print(errorMessage)
                print("\(tableName) table could not be created........................")
//                sqlite3_finalize(createTableStatement)
//                sqlite3_close(createTableStatement)
//                sqlite3_close(db)
                return false
            }
        } else {
            print("CREATE TABLE statement could not be prepared....................................")
            let errorMessage = String.init(cString: sqlite3_errmsg(db))
            print(errorMessage)
//            sqlite3_finalize(createTableStatement)
//            sqlite3_close(createTableStatement)
//            sqlite3_close(db)
            return false
        }
        // 4
        defer{
//        sqlite3_finalize(createTableStatement)
//            sqlite3_close(createTableStatement)
//            sqlite3_close(db)
        }
    }
    
    // Insert data into Table
    func insertAutoIncrement(tableName:String , valuesArray:[[String:String]]) {
        //     let columnString = column1+", "+column2+", "+column3+", "+column4
        print("Insert work is gonig to happen in \(tableName)")
        var columnString = "(Id"
        var valuesString = "(?"
        for valuesArray in valuesArray{
            for (key,value) in valuesArray{
                columnString += ", \(key)"
                valuesString += ", ?"
            }
        }
        let insertStatementString = "INSERT INTO "+tableName+" "+columnString+") VALUES "+valuesString+");"
        var insertStatement: OpaquePointer? = nil
        do{
            // 1
            if sqlite3_prepare_v2(ConnectionPointers.createPlayerTablePointer, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
                //   let id: Int32 = 1
                //   sqlite3_bind_int(insertStatement, 1, id)
                for (index,valuesArray) in valuesArray.enumerated(){
                    
                    
                    var columnvalue: NSString = ""
                    for (key,value) in valuesArray{
                        columnvalue = value as NSString
                    }
                    sqlite3_bind_text(insertStatement, Int32(index.advanced(by: 2)), columnvalue.utf8String, -1, nil)
                    // 4
                    
                }
                if sqlite3_step(insertStatement) == SQLITE_DONE {
                    print("Successfully inserted \(tableName) detail row .")
                } else {
                    print("Could not insert row.")
                    let errorMessage = String.init(cString: sqlite3_errmsg(db))
                    print(errorMessage)
                }
              //  sqlite3_reset(insertStatement)
                // sqlite3_finalize(insertStatement)
            } else {
                let errorMessage = String.init(cString: sqlite3_errmsg(db))
                print(errorMessage)
                print("INSERT statement could not be prepared.")
            }
        }catch{
            print(error)
//            sqlite3_finalize(insertStatement)
//            sqlite3_close(insertStatement)
//            sqlite3_close(db)
        }
        // 5
          defer{
//        sqlite3_finalize(insertStatement)
//            sqlite3_close(insertStatement)
//            sqlite3_close(db)
        }
    }
    
    // Insert data into Table
    func insert(tableName:String , valuesArray:[[String:String]]) {
        //     let columnString = column1+", "+column2+", "+column3+", "+column4
        
        var columnString = "(Id"
        var valuesString = "(?"
        for valuesArray in valuesArray{
            for (key,_) in valuesArray{
                columnString += ", \(key)"
                valuesString += ", ?"
            }
        }
        let insertStatementString = "INSERT INTO "+tableName+" "+columnString+") VALUES "+valuesString+");"
        var insertStatement: OpaquePointer? = nil
        do{
            // 1
            if sqlite3_prepare_v2(ConnectionPointers.createPlayerTablePointer, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
                let id: Int32 = 1
                sqlite3_bind_int(insertStatement, 1, id)
                for (index,valuesArray) in valuesArray.enumerated(){
                    
                    
                    var columnvalue: NSString = ""
                    for (key,value) in valuesArray{
                        columnvalue = value as NSString
                    }
                    sqlite3_bind_text(insertStatement, Int32(index.advanced(by: 2)), columnvalue.utf8String, -1, nil)
                    // 4
                    
                }
                if sqlite3_step(insertStatement) == SQLITE_DONE {
                    print("Successfully inserted \(tableName) detail row .")
                } else {
                    print("Could not insert row.")
                    let errorMessage = String.init(cString: sqlite3_errmsg(db))
                    print(errorMessage)
                }
             //   sqlite3_reset(insertStatement)
                // sqlite3_finalize(insertStatement)
            } else {
                let errorMessage = String.init(cString: sqlite3_errmsg(db))
                print(errorMessage)
                print("INSERT statement could not be prepared.")
            }
        }catch{
            print(error)
//            sqlite3_finalize(insertStatement)
//            sqlite3_close(insertStatement)
//            sqlite3_close(db)
        }
        // 5
          defer{
//        sqlite3_finalize(insertStatement)
//            sqlite3_close(insertStatement)
//            sqlite3_close(db)
        }
    }
    
    func alterTable(tableName:String,columnName:String)->Bool{
        
        let alterTableString = "ALTER TABLE "+tableName+" ADD "+columnName+" TEXT DEFAULT '0';"
//        let alterTableString = "ALTER TABLE "+tableName+" DROP COLUMN '"+columnName+"';"
        print(alterTableString)
        // 1
        
        var alterTableStatement: OpaquePointer? = nil
        // 2
        if sqlite3_prepare_v2(ConnectionPointers.createPlayerTablePointer, alterTableString, -1, &alterTableStatement, nil) == SQLITE_OK {
            // 3
            if sqlite3_step(alterTableStatement) == SQLITE_DONE {
                print("\(tableName) table altered................................")
                
//                sqlite3_finalize(alterTableStatement)
//                sqlite3_close(alterTableStatement)
//                sqlite3_close(db)
                return true
            } else {
                let errorMessage = String.init(cString: sqlite3_errmsg(db))
                print(errorMessage)
                print("\(tableName) table could not be altered........................")
                
//                sqlite3_finalize(alterTableStatement)
//                sqlite3_close(alterTableStatement)
//                sqlite3_close(db)
                return false
            }
        } else {
            print("Alter TABLE statement could not be prepared....................................")
            let errorMessage = String.init(cString: sqlite3_errmsg(db))
            print(errorMessage)
            
//            sqlite3_finalize(alterTableStatement)
//            sqlite3_close(alterTableStatement)
//            sqlite3_close(db)
            return false
        }
        // 4
        defer{
//            sqlite3_finalize(alterTableStatement)
//            sqlite3_close(alterTableStatement)
//            sqlite3_close(db)
        }
    }
    // Query multiple rows
    func queryMultiple(tableName:String, columnArray:[String])-> [[String:String]] {
        let queryStatementString = "SELECT * FROM "+tableName+";"
        var returnDictionary:[String:String] = [:]
        var returnValue:[[String:String]] = []
        var queryStatement: OpaquePointer? = nil
        
        do{
            if sqlite3_prepare_v2(ConnectionPointers.createPlayerTablePointer, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
                
                while (sqlite3_step(queryStatement) == SQLITE_ROW) {
                    
                    for(index, columnNames) in columnArray.enumerated(){
                        let queryResultCol = sqlite3_column_text(queryStatement, Int32(index.advanced(by: 1)))
                        returnDictionary.updateValue(String(cString: queryResultCol!), forKey: columnNames)
                    }
                    returnValue.append(returnDictionary)
                }
                
            } else {
                let errorMessage = String.init(cString: sqlite3_errmsg(db))
                print(errorMessage)
                print("SELECT statement could not be prepared")
                //            sqlite3_finalize(queryStatement)
                //            return returnValue
            }
        }catch{
            let errorMessage = String.init(cString: sqlite3_errmsg(db))
            print(errorMessage)
//            sqlite3_finalize(queryStatement)
//            sqlite3_close(queryStatement)
//            sqlite3_close(db)
        }
          defer{
//        sqlite3_finalize(queryStatement)
//              sqlite3_close(queryStatement)
//            sqlite3_close(db)
        }
        return returnValue
    }
    
    // Query single row
    func query(tableName:String, columnArray:[String], columnName:String, columnValue:String)-> [[String:String]] {
        let queryStatementString = "SELECT * FROM "+tableName+" WHERE "+columnName+" = '"+columnValue+"';"
        var returnDictionary:[String:String] = [:]
        var returnValue:[[String:String]] = []
        var queryStatement: OpaquePointer? = nil
        
        do{
            if sqlite3_prepare_v2(ConnectionPointers.createPlayerTablePointer, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
                
                while (sqlite3_step(queryStatement) == SQLITE_ROW) {
                    
                    for(index, columnNames) in columnArray.enumerated(){
                        let queryResultCol = sqlite3_column_text(queryStatement, Int32(index.advanced(by: 1)))
                        returnDictionary.updateValue(String(cString: queryResultCol!), forKey: columnNames)
                    }
                    returnValue.append(returnDictionary)
                }
                
            } else {
                let errorMessage = String.init(cString: sqlite3_errmsg(db))
                print(errorMessage)
                print("SELECT statement could not be prepared")
                //            sqlite3_finalize(queryStatement)
                //            return returnValue
            }
        }catch{
            let errorMessage = String.init(cString: sqlite3_errmsg(db))
            print(errorMessage)
//            sqlite3_finalize(queryStatement)
//            sqlite3_close(queryStatement)
//            sqlite3_close(db)
        }
          defer{
//        sqlite3_finalize(queryStatement)
//             sqlite3_close(queryStatement)
//            sqlite3_close(db)
        }
        return returnValue
    }
    // Update
    func updateRow(tableName:String, updateDictionary:[String:String],columnName:String, columnValue:String) {
        
        var updateQueryValue = ""
        var count = 0
        for (key, value) in updateDictionary{
            if count == 0 {
                updateQueryValue += "\(key) = '\(value)'"
                count += 1
            }else{
                updateQueryValue += ", \(key) = '\(value)'"
                count += 1
            }
            
        }
        print(updateQueryValue)
        let updateStatementString = "UPDATE "+tableName+" SET "+updateQueryValue+" WHERE "+columnName+" = '"+columnValue+"';"
        
        //let updateStatementString = "UPDATE DeviceInfo SET AgentId = '"+value+"' WHERE Id = 1;"
        //let updateStatementString = "UPDATE DeviceInfo SET AgentId ='309' WHERE Id = 1;"
        var updateStatement: OpaquePointer? = nil
        do{
            if sqlite3_prepare_v2(ConnectionPointers.createPlayerTablePointer, updateStatementString, -1, &updateStatement, nil) == SQLITE_OK {
                if sqlite3_step(updateStatement) == SQLITE_DONE {
                    print("Successfully updated \(tableName) row.")
                    print(updateStatement)
                } else {
                    let errorMessage = String.init(cString: sqlite3_errmsg(db))
                    print(errorMessage)
                    print("Could not update row.")
                    print(updateStatement)
                    print(SQLITE_DONE)
                }
            } else {
                let errorMessage = String.init(cString: sqlite3_errmsg(db))
                print(errorMessage)
                print("UPDATE statement could not be prepared")
            }
            
        } catch {
            print(error)
        }
          defer{
//        sqlite3_finalize(updateStatement)
//             sqlite3_close(updateStatement)
//            sqlite3_close(db)
        }
    }
    
    // Delete data
    func delete(tableName:String, column:String, value:String)
    {
        let deleteStatementStirng = "DELETE FROM "+tableName+" WHERE "+column+" = "+value+";"
        
        var deleteStatement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(ConnectionPointers.createPlayerTablePointer, deleteStatementStirng, -1, &deleteStatement, nil) == SQLITE_OK
        {
            if sqlite3_step(deleteStatement) == SQLITE_DONE
            {
                print("Successfully deleted row.")
                
            } else
            {
                print("Could not delete row.")
                let errorMessage = String.init(cString: sqlite3_errmsg(db))
                print(errorMessage)
            }
        } else {
            print("DELETE statement could not be prepared")
            let errorMessage = String.init(cString: sqlite3_errmsg(db))
            print(errorMessage)
        }
          defer{
//        sqlite3_finalize(deleteStatement)
//            sqlite3_close(deleteStatement)
//            sqlite3_close(db)
        }
    }
    
    // Delete All data from table
    
    func deleteAll(tableName:String)
    {
        let deleteStatementStirng = "DELETE FROM "+tableName+";"
        
        var deleteStatement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(ConnectionPointers.createPlayerTablePointer, deleteStatementStirng, -1, &deleteStatement, nil) == SQLITE_OK
        {
            if sqlite3_step(deleteStatement) == SQLITE_DONE
            {
                print("Successfully deleted all data from table.")
                
            } else
            {
                print("Could not delete row.")
                let errorMessage = String.init(cString: sqlite3_errmsg(db))
                print(errorMessage)
            }
        } else {
            print("DELETE statement could not be prepared")
            let errorMessage = String.init(cString: sqlite3_errmsg(db))
            print(errorMessage)
        }
          defer{
//        sqlite3_finalize(deleteStatement)
//            sqlite3_close(deleteStatement)
//            sqlite3_close(db)
            
        }
    }
}





