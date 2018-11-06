//
//  CurrentUser.swift
//  SnapchatProject
//
//  Created by Daniel Phiri on 10/17/17.
//  Copyright © 2017 org.iosdecal. All rights reserved.
//

import Foundation
import Firebase

class CurrentUser {
    
    var username: String!
    var id: String!
    var readPostIDs: [String]?
    
    /*TODO:
     Uncomment the following lines when you reach the appriopriate section in the
     README. DO NOT UNCOMMENT THE ONES WITHIN THE NEXT TODO:
     */
    
    let dbRef = Database.database().reference()

    init() {
         if let currentUser = Auth.auth().currentUser{
             username = currentUser.displayName
             id = currentUser.uid
        }
     }


    
    /*
     TODO:
     
     Retrieve a list of post ID's that the user has already opened and return them as an array of strings.
     Note that our database is set up to store a set of ID's under the readPosts node for each user.
     Make a query to Firebase using the 'observeSingleEvent' function (with 'of' parameter set to .value) and retrieve the snapshot that is returned. If the snapshot exists, store its value as a [String:AnyObject] dictionary and iterate through its keys, appending the value corresponding to that key to postArray each time. Finally, call completion(postArray).
     */
    func getReadPostIDs(completion: @escaping ([String]) -> Void) {
        var postArray: [String] = []
        // YOUR CODE HERE
        dbRef.child("Users").child(id).child("readPosts").observeSingleEvent(of: .value, with: {(snapshot) in
            if snapshot.exists(){
                if let tempValue = snapshot.value{
                    if let tempDict = tempValue as? [String : AnyObject]{
                        for tempString in tempDict.values{
                            postArray.append(tempString as! String)
                        }
                    }
                }
            }
             completion(postArray)
        })
    }
    
    /*
     TODO:
     
     Adds a new post ID to the list of post ID's under the user's readPosts node.
     This should be fairly simple - just create a new child by auto ID under the readPosts node and set its value to the postID (string).
     Remember to be very careful about following the structure of the User node before writing any data!
     */
    func addNewReadPost(postID: String) {
        dbRef.child("Users").child(id).child("readPosts").childByAutoId().setValue(postID)
    }
    
}
