//
//  FMDBQueueManager.swift

import UIKit
import FMDB

class FMDBQueueManager: NSObject {

    static let shareFMDBQueueManager = FMDBQueueManager()
    
    var dbQueue : FMDatabaseQueue?
    
    func openDB(_ dbName : String)  {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last!
        print("*******************************************************  ----------- > ",path)
        
        dbQueue = FMDatabaseQueue(path: "\(path)/\(dbName)")
      
        createTable()
        
       
        
    }
    //....Keychain access value
    //let getkeyvalue = Keychain.value(forKey: kappLastVersion) ?? "Not found"
    
    /*
     * Create Table in database
     * type cause -> 0 , resolution -> 1
     * section RBU 11 -> A , RBU 100 -> B , RBU 100 Sescor -> C , TCD 750 -> D
    */
    func createTable() -> Void {
        let sql_tbl = "CREATE TABLE IF NOT EXISTS NOTE ('id' INTEGER PRIMARY KEY  AUTOINCREMENT  NOT NULL  UNIQUE,'quality' TEXT ,'dt' datetime,'hr' TEXT)"
      
        dbQueue?.inDatabase({ (db) -> Void in
            try? db.executeUpdate(sql_tbl, values: [])
        })
       
    }
    
  
    
    func insertNOTE(gethr:String,getdate:String,quality:String)->Int {
        
        let sql = "INSERT INTO NOTE (hr,dt,quality) values ('\(gethr)','\(getdate)','\(quality)')"
        
        var getId:Int = 0
        dbQueue?.inDatabase({ (db) ->Void in
            
            try? db.executeUpdate(sql, values: [])
            
             print(Int(db.lastInsertRowId))
            getId = Int(db.lastInsertRowId)
            
            
            
            
        })
        
        
        return getId
      //  return getlastid.description
    }
    
    
    func CheckNOTE(getdate:String)->NSMutableArray {
        
        let sql = "SELECT * FROM NOTE where dt = '\(getdate)' "
        
        let resultArray:NSMutableArray = []
        
        FMDBQueueManager.shareFMDBQueueManager.dbQueue?.inDatabase({ (db) in
            if let result = try? db.executeQuery(sql, values: []){
                while (result.next()) {
                    
                    let getid = result.string(forColumn: "id") ?? ""
                    let gettext = result.string(forColumn: "hr") ?? ""
                    let getdt = result.string(forColumn: "dt") ?? ""
                    
                    
                    let createDic:NSMutableDictionary = NSMutableDictionary()
                    
                    createDic.setValue(getid, forKey: "id")
                    createDic.setValue(gettext, forKey: "hr")
                    createDic.setValue(getdt, forKey: "dt")
                    
                    resultArray.add(createDic)
                }
            }
            
        })
        return resultArray
        
    }
    

    
    
   
    

    func GetAllDATA()->NSMutableArray
    {
        
       // print("createStartingDate",createStartingDate)
        
       // let sql = "SELECT * from NOTE "
       let sql = "select * from NOTE ORDER BY dt asc"
        //ASC|DESC;"
        
        let resultArray:NSMutableArray = []
        
        FMDBQueueManager.shareFMDBQueueManager.dbQueue?.inDatabase({ (db) in
            if let result = try? db.executeQuery(sql, values: []){
                while (result.next()) {
                    
                    let getid = result.string(forColumn: "id") ?? ""
                    let gettext = result.string(forColumn: "hr") ?? ""
                    let getdt = result.string(forColumn: "dt") ?? ""
                    let quality = result.string(forColumn: "quality") ?? ""
                    
                   
                    
                    let createDic:NSMutableDictionary = NSMutableDictionary()
                    
                    createDic.setValue(getid, forKey: "id")
                    createDic.setValue(gettext, forKey: "hr")
                    createDic.setValue(getdt, forKey: "dt")
                    createDic.setValue(quality, forKey: "quality")
                 
                    resultArray.add(createDic)
                }
            }
            
        })
        return resultArray
    }
    
    
    
    
    
    
    
    
    
    
    
    
    /*
     * Remove product from selected cart
     */
    func removeNote(cartid:String) -> Void
    {
        let sql = "DELETE FROM NOTE WHERE id = '\(cartid)' "
        FMDBQueueManager.shareFMDBQueueManager.dbQueue?.inDatabase({ (db) ->Void in
            try? db.executeUpdate(sql, values: [])
        })
    }// end function
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
