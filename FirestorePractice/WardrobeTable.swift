//
//  WardrobeTable.swift
//  FirestorePractice
//
//  Created by Hunter Buxton on 7/6/19.
//  Copyright © 2019 Hunter Buxton. All rights reserved.
//

import UIKit
import FirebaseFirestore

class WardrobeTable: UITableViewController {

    let wardrobeCellRID = "wardrobeReuseIdentifier"
    //var data: [String] = ["pants", "panties", "panterinos", "pantaloons", "pantstastic", "pants on fire"]
   
    private var documents: [DocumentSnapshot] = []
    public var items: [WardrobeItem] = []
    private var listener : ListenerRegistration!
    
    fileprivate func baseQuery() -> Query {
        return Firestore.firestore().collection("Pants").limit(to: 50)
    }
    
    fileprivate var query: Query? {
        didSet {
            if let listener = listener {
                listener.remove()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.listener =  query?.addSnapshotListener { (documents, error) in
            guard let snapshot = documents else {
                print("Error fetching documents results: \(error!)")
                return
            }
            
            let results = snapshot.documents.map { (document) -> WardrobeItem in
                if let item = WardrobeItem(dictionary: document.data(), id: document.documentID) {
                    return item
                } else {
                    fatalError("Unable to initialize type \(WardrobeItem.self) with dictionary \(document.data())")
                }
            }
            
            self.items = results
            self.documents = snapshot.documents
            self.tableView.reloadData()
            
        }
    
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.listener.remove()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(WardrobeCell.self, forCellReuseIdentifier: wardrobeCellRID)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonAction))
        
         self.query = baseQuery()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    @objc func addButtonAction() {
        print("addButtonAction was tapped")
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: wardrobeCellRID, for: indexPath)
        cell.textLabel?.text = items[indexPath.row].brand
        
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
