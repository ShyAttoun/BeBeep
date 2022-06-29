//
//  InboxTableViewCell.swift
//  Bebeep
//
//  Created by shy attoun on 21/05/2022.
//


import UIKit
import FirebaseAuth
import FirebaseCore
import Firebase
import MessageUI
import ProgressHUD
import FirebaseStorage
import FirebaseMessaging

class InboxTableViewCell: UITableViewCell {

    
    @IBOutlet weak var fullnameLbl: UILabel!
    @IBOutlet weak var messageLbl: UILabel!
    @IBOutlet weak var datebl: UILabel!
    
    var inboxChangedProfileHandle: DatabaseHandle!
    var inboxChangedMessageHandle: DatabaseHandle!
    var user: User!
    var controller: InboxViewController!
    var inbox: Inbox!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    func configureCell(uid: String, inbox: Inbox) {
        self.user = inbox.user
        self.inbox = inbox
        
        fullnameLbl.text = inbox.user.idnumber
        let date = Date().addingTimeInterval(-15000)

        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        let timeString = formatter.localizedString(for: date, relativeTo: Date())

        datebl.text = timeString
        
        if !inbox.text.isEmpty {
            messageLbl.text = inbox.text
        } else {
            messageLbl.text = "[MEDIA]"
        }
        
        
        
//        let refInbox = Ref().databaseInboxInFor(from: Api.User.currentUserId, to: inbox.user.uid)
        let channelId = Message.hash(forMembers: [Api.User.currentUserId, inbox.user.uid])
        let refInbox = Database.database().reference().child(REF_INBOX).child(Api.User.currentUserId).child(channelId)
        print("WOW \(refInbox)")
        if inboxChangedMessageHandle != nil {
            refInbox.removeObserver(withHandle: inboxChangedMessageHandle)
        }
        
        inboxChangedMessageHandle = refInbox.observe(.childChanged, with: { (snapshot) in
        
            if let snap = snapshot.value {
             self.inbox.updateData(key: snapshot.key, value: snap)
                self.controller.sortedInbox()
            }
        })

        let refUser = DatabaseProvider().databaseSpecificUser(uid: user.uid)
        print("walla \(refUser)")
        if inboxChangedProfileHandle != nil {
            refUser.removeObserver(withHandle: inboxChangedProfileHandle)
        }
        
        inboxChangedProfileHandle = refUser.observe(.childChanged, with: { (snapshot) in
            if let snap = snapshot.value as? String {
                self.user.updateData(key: snapshot.key, value: snap)
                self.controller.sortedInbox()
            }
        })
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()

        let refUser = DatabaseProvider().databaseSpecificUser(uid: user.uid)
        if inboxChangedProfileHandle != nil {
            refUser.removeObserver(withHandle: inboxChangedProfileHandle)
        }
        
        let channelId = Message.hash(forMembers: [Api.User.currentUserId, inbox.user.uid])
        let refInbox = Database.database().reference().child(REF_INBOX).child(Api.User.currentUserId).child(channelId)
        if inboxChangedMessageHandle != nil {
            refInbox.removeObserver(withHandle: inboxChangedMessageHandle)
        }
    }
}
