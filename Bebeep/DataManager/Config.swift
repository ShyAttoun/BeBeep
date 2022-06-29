//
//  Config.swift
//  Bebeep
//
//  Created by shy attoun on 21/05/2022.
//

import Foundation


let serverKey = "AAAAx_sk4sY:APA91bHS55mGbXXQI6cT9Cg1d-mazGkul1LBS7h-MZ8I2D9OJtpR0WbaZPmpo5nen-xmGbARzr_EtrADbwA1EgIB9gk9IU3gq6n7E1I5yJyPGYkQnGUh9tHz5qR6aX7LUKY3ZxNSl3uS"

let fcmUrl = "https://fcm.googleapis.com/fcm/send"


func sendRequestNotification(isMatch: Bool = false , fromUser: User, toUser: User, message: String, badge: Int) {
    var request = URLRequest(url: URL(string: fcmUrl)!)
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.setValue("key=\(serverKey)", forHTTPHeaderField: "Authorization")
    request.httpMethod = "POST"
    
    let notification: [String: Any] = [ "to" : "/topics/\(toUser.uid)",
        "notification" : ["title": "NEW MESSGAE from BeBeep",
                          "customData" : ["uid": fromUser.uid,
                                          "idnumber": fromUser.idnumber,
                                          "email": fromUser.email,
                                          "phone": fromUser.phone]
        ]
    ]
    
    let data = try! JSONSerialization.data(withJSONObject: notification, options: [])
    request.httpBody = data
    
    let session = URLSession.shared
    session.dataTask(with: request) { (data, response, error) in
        guard let data = data, error == nil else {
            return
        }
        
        if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
            print("HttpUrlResponse \(httpResponse.statusCode)")
            print("Response \(response!)")
        }
        
        if let responseString = String(data: data, encoding: String.Encoding.utf8) {
            print("ResponseString \(responseString)")
        }
        }.resume()
    
}
