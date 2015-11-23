//
//  ContactTableViewController.swift
//  Prototype2
//  Team Hjack
//  Worked on by: Kelvin Law, Adam Gabriel, Hesam Fatahi, Jessica Poon, Chun-wei Chen
//  Created by Kelvin Law on 2015-11-05.
//  Copyright © 2015 Kelvin Law. All rights reserved.
//

import UIKit
import Contacts
import ContactsUI

//protocol AddContactViewControllerDelegate{
//    func didFetchContacts(contacts:[CNContact])
//}

class ContactTableViewController: UITableViewController,UIPickerViewDelegate, CNContactPickerDelegate {
   
    @IBOutlet var tblContacts: UITableView!
 
    var contacts = [CNContact]()

    //    var delegate: AddContactViewControllerDelegate!
    override func viewDidLoad() {
        super.viewDidLoad()
        let notification:UILocalNotification=UILocalNotification()
        notification.category="First_Category"
        notification.alertBody = "Are you alright?"
        notification.fireDate = NSDate(timeIntervalSinceNow: 15)
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
        
        
        
        //tblContacts = UITableView(frame: view.bounds, style: .Grouped)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
         self.navigationItem.leftBarButtonItem = self.editButtonItem()
         let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "insertNewObject:")
         self.navigationItem.rightBarButtonItem = addButton
       // configureTableView()
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func insertNewObject(sender: AnyObject) {
        let contactPickerViewController = CNContactPickerViewController()
        contactPickerViewController.predicateForEnablingContact = NSPredicate(format: "(phoneNumbers.@count > 0) AND NOT (identifier IN %@)", self.contacts.map{ $0.identifier})
        contactPickerViewController.predicateForSelectionOfProperty = NSPredicate(format: "key == 'phoneNumbers'", argumentArray: nil)
        contactPickerViewController.delegate = self
        navigationController?.presentViewController(contactPickerViewController,animated: true, completion: nil)
        
    }
    
// Multiple contacts selection
    func contactPicker(picker: CNContactPickerViewController, didSelectContacts contacts: [CNContact]) {
        print("Selected \(contacts.count) contacts")
        self.contacts.appendContentsOf(contacts)
        tblContacts.reloadData()
        navigationController?.popViewControllerAnimated(true)
    }
    
//// Single contact pick
//    func contactPicker(picker: CNContactPickerViewController, didSelectContactProperty contactProperty: CNContactProperty) {
//        print("Selected a property")
//    }
//    
//    func contactPicker(picker: CNContactPickerViewController, didSelectContact contact: CNContact) {
//        
//        self.contacts.append(contact)
//        tblContacts.reloadData()
//        navigationController?.popViewControllerAnimated(true)
//    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return contacts.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TableCell", forIndexPath: indexPath) as UITableViewCell
        let currentContact = contacts[indexPath.row]
        
        cell.textLabel?.text = "\(currentContact.givenName)\(currentContact.familyName)"
    
        // Configure the cell...
        return cell
    }

    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            contacts.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    

    
//    func didFetchContacts(contacts: [CNContact]) {
//        for contact in contacts {
//            self.contacts.append(contact)
//        }
//        
//        tblContacts.reloadData()
//    }
//  
    
    @IBAction func myNotify(sender: AnyObject) {
        let refreshAlert = UIAlertController(title: "FallSafe", message: "Are you alright?", preferredStyle: UIAlertControllerStyle.Alert)
        
        refreshAlert.addAction(UIAlertAction(title: "I'm fine", style: .Default, handler: nil))
        
        refreshAlert.addAction(UIAlertAction(title: "I'm hurt", style: .Default, handler: nil))
        
        presentViewController(refreshAlert, animated: true, completion: nil)
    }
}
