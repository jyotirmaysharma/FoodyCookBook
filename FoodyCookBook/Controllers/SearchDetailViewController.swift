//
//  SearchDetailViewController.swift
//  FoodyCookBook
//
//  Created by Jyotirmay Sharma on 26/04/21.
//

import UIKit
import Alamofire
import Kingfisher

class SearchDetailViewController: UIViewController {
    
    var searchData = [RandomRecipeModel]()
    var idRecipe = ""
    var ingStr = ""

    @IBOutlet var imageTop: UIImageView!
    @IBOutlet var name: UILabel!
    @IBOutlet var ingridients: UITextView!
    @IBOutlet var wathcvideo: UIButton!
    @IBOutlet var instructions: UITextView!
    @IBOutlet var tags: UILabel!
    @IBOutlet var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchByID(idRecipe)
        self.wathcvideo.layer.cornerRadius = self.wathcvideo.layer.frame.height/2
    }
    
    func setData() {
        
        let imgUrl = URL(string: searchData[0].meals[0].strMealThumb!)
        self.imageTop.kf.setImage(with: imgUrl)
        
        self.name.text = searchData[0].meals[0].strMeal!
        self.instructions.text = searchData[0].meals[0].strInstructions!
        setIngridients()
        setTags()
    }
    
    func setIngridients() {
        checkIng()
        print(ingStr)
        self.ingridients.text = self.ingStr
    }
    
    func setTags() {
        var tagStr = "Categories: "
        
        if searchData[0].meals[0].strCategory != nil {
            tagStr = tagStr + " " + searchData[0].meals[0].strCategory!
        }
        if searchData[0].meals[0].strArea != nil {
            tagStr = tagStr + ", " + searchData[0].meals[0].strArea!
        }
        if searchData[0].meals[0].strTags != nil {
            tagStr = tagStr + ", " + searchData[0].meals[0].strTags!
        }
        
        self.tags.text = tagStr
    }
    
    
    func checkIng() {
        nullAdder(searchData[0].meals[0].strIngredient1 ?? "", searchData[0].meals[0].strMeasure1 ?? "")
        nullAdder(searchData[0].meals[0].strIngredient2 ?? "", searchData[0].meals[0].strMeasure2 ?? "")
        nullAdder(searchData[0].meals[0].strIngredient3 ?? "", searchData[0].meals[0].strMeasure3 ?? "")
        nullAdder(searchData[0].meals[0].strIngredient4 ?? "", searchData[0].meals[0].strMeasure4 ?? "")
        nullAdder(searchData[0].meals[0].strIngredient5 ?? "", searchData[0].meals[0].strMeasure5 ?? "")
        nullAdder(searchData[0].meals[0].strIngredient6 ?? "", searchData[0].meals[0].strMeasure6 ?? "")
        nullAdder(searchData[0].meals[0].strIngredient7 ?? "", searchData[0].meals[0].strMeasure7 ?? "")
        nullAdder(searchData[0].meals[0].strIngredient8 ?? "", searchData[0].meals[0].strMeasure8 ?? "")
        nullAdder(searchData[0].meals[0].strIngredient9 ?? "", searchData[0].meals[0].strMeasure9 ?? "")
        nullAdder(searchData[0].meals[0].strIngredient10 ?? "", searchData[0].meals[0].strMeasure10 ?? "")
        nullAdder(searchData[0].meals[0].strIngredient11 ?? "", searchData[0].meals[0].strMeasure11 ?? "")
        nullAdder(searchData[0].meals[0].strIngredient12 ?? "", searchData[0].meals[0].strMeasure12 ?? "")
        nullAdder(searchData[0].meals[0].strIngredient13 ?? "", searchData[0].meals[0].strMeasure13 ?? "")
        nullAdder(searchData[0].meals[0].strIngredient14 ?? "", searchData[0].meals[0].strMeasure14 ?? "")
        nullAdder(searchData[0].meals[0].strIngredient15 ?? "", searchData[0].meals[0].strMeasure15 ?? "")
        nullAdder(searchData[0].meals[0].strIngredient16 ?? "", searchData[0].meals[0].strMeasure16 ?? "")
        nullAdder(searchData[0].meals[0].strIngredient17 ?? "", searchData[0].meals[0].strMeasure17 ?? "")
        nullAdder(searchData[0].meals[0].strIngredient18 ?? "", searchData[0].meals[0].strMeasure18 ?? "")
        nullAdder(searchData[0].meals[0].strIngredient19 ?? "", searchData[0].meals[0].strMeasure19 ?? "")
        nullAdder(searchData[0].meals[0].strIngredient20 ?? "", searchData[0].meals[0].strMeasure20 ?? "")
    }
    
    func nullAdder(_ str: String, _ amt: String) {
        if str != nil && str != "" {
            ingStr = ingStr + "\(str): \(amt)\n"
        }
    }
    @IBAction func saveButtonPressed(_ sender: Any) {
        var savedArrayID = UserDefaults.standard.stringArray(forKey: "SavedIds")
         savedArrayID?.append(searchData[0].meals[0].idMeal!)
         UserDefaults.standard.set(savedArrayID, forKey: "SavedIds")
         
         var savedArrayName = UserDefaults.standard.stringArray(forKey: "SavedNames")
         savedArrayName?.append(searchData[0].meals[0].strMeal!)
         UserDefaults.standard.set(savedArrayName, forKey: "SavedNames")
         
         UserDefaults.standard.synchronize()
    }
}

//MARK: API Calls
extension SearchDetailViewController {
    func searchByID(_ id: String) {
        AF.request(Constants.SEARCHBYIDAPI + id as URLConvertible).responseJSON { response in
            print(response.data ?? "data nil")
            self.parseIDJSON(response.data!)
        }
    }
    
    func parseIDJSON(_ data: Data) {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(RandomRecipeModel.self, from: data)
            
            self.searchData.append(decodedData)
            
            print(searchData[0].meals[0].idMeal!)
            print(searchData[0].meals[0].strMealThumb!)
            print(searchData[0].meals[0].strMeal!)
            print(searchData[0].meals[0].strInstructions!)
            
            self.setData()
        } catch {
            print("Parse error: \(error)")
        }
    }
}
