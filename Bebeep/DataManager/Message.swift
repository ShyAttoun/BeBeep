//
//  Message.swift
//  Bebeep
//
//  Created by shy attoun on 21/05/2022.
//

import Foundation


class Message {
    var id: String
    let sender: String
    let body : String
    var date: Double
    var text: String
  
  
    
    init(id: String, sender: String, body: String, date: Double, text: String) {
        self.id = id
        self.sender = sender
        self.body = body
        self.date = date
        self.text = text
        
        
    }
    
    static func transformMessage(dict: [String: Any], keyId: String) -> Message? {
        guard let from = dict["from"] as? String,
            let to = dict["to"] as? String,
            let date = dict["date"] as? Double else {
                return nil
        }
        
        let text = (dict["text"] as? String) == nil ? "" : (dict["text"]! as! String)
     
        let message = Message(id: keyId, sender: from, body: to, date: date, text: text)
        return message
    }
    
    
    static func hash(forMembers members: [String]) -> String {
        let hash = members[0].hashValue ^ members[1].hashValue
        let memberHash = String(hash)
        return memberHash
    }
}
