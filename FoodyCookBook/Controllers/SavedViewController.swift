//
//  SavedViewController.swift
//  FoodyCookBook
//
//  Created by Jyotirmay Sharma on 26/04/21.
//

import UIKit
import Alamofire

class SavedViewController: UIViewController {
    
    var arrayOfNames = [Any]()
    var arrayOfID = [Any]()
    
    var tableCaountSaved = 0

    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        getDefaultData()
    }
    
    func getDefaultData() {
        print("In getting Data on Save screen")
        self.arrayOfID = UserDefaults.standard.array(forKey: "SavedIds")!
        self.arrayOfNames = UserDefaults.standard.array(forKey: "SavedNames")!
    }
}

extension SavedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayOfID.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "savecell", for: indexPath) as! SavedCell
        
        cell.nameLabel.text = arrayOfNames[indexPath.row] as? String
        
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 54
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "detail") as! SearchDetailViewController
        vc.idRecipe = self.arrayOfID[indexPath.row] as! String
        self.present(vc, animated: true)
    }
}

class SavedCell: UITableViewCell {
    @IBOutlet var nameLabel: UILabel!
}
