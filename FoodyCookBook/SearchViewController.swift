//
//  SearchViewController.swift
//  FoodyCookBook
//
//  Created by Jyotirmay Sharma on 26/04/21.
//

import UIKit
import Alamofire

class SearchViewController: UIViewController {
    
    var searchData = [RandomRecipeModel]()
    var searchIDData = [RandomRecipeModel]()
    var tableCount: Int = 0
    var searchText: String = ""

    @IBOutlet var searchBar: UITextField!
    @IBOutlet var searchTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchBar.delegate = self
        searchTableView.delegate = self
        searchTableView.dataSource = self
    }
    
    func loadData() {
        self.searchTableView.reloadData()
    }
}

extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.searchText = textField.text!
        print(self.searchText)
        searchCall(searchText)
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SearchCell
        
        cell.searchResultName.text = self.searchData[0].meals[indexPath.row].strMeal!
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "detail") as! SearchDetailViewController
        vc.idRecipe = self.searchData[0].meals[indexPath.row].idMeal!
        self.present(vc, animated: true)
    }
}


//MARK: API Calls
extension SearchViewController {
    func searchCall(_ str: String) {
        AF.request(Constants.SEARCHAPI + str as URLConvertible, method: .get).responseJSON { response in
            debugPrint("DebugPrint: \n \(response.data!)")
            self.parseSearchProduct(response.data!)
        }
    }
    
    func parseSearchProduct(_ data: Data) {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(RandomRecipeModel.self, from: data)
            self.searchData.append(decodedData)
            
            print(searchData[0].meals[1].strMeal)
            
            self.tableCount = self.searchData[0].meals.count
            
            DispatchQueue.main.async {
                self.searchTableView.reloadData()
            }
        } catch {
            print("Parse error: \(error)")
        }
    }
}


class SearchCell: UITableViewCell {
    @IBOutlet var searchResultName: UILabel!
}
