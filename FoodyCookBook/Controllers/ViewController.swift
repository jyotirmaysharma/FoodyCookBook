//
//  ViewController.swift
//  FoodyCookBook
//
//  Created by Jyotirmay Sharma on 26/04/21.
//

import UIKit
import Alamofire
import Kingfisher

class ViewController: UIViewController {
    
    var randomRecipeData = [RandomRecipeModel]()
    var ingString: String = ""
    var id: String = ""
    
    let arrayID = ["52914"]
    let arrayName = ["Boulangère Potatoes"]

    @IBOutlet var recipeImage: UIImageView!
    @IBOutlet var recipeName: UILabel!
    @IBOutlet var recipeIngridients: UITextView!
    @IBOutlet var watchButton: UIButton!
    @IBOutlet var recipeInstructions: UITextView!
    @IBOutlet var recipeTags: UILabel!
    @IBOutlet var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        instantiateArray()
        randomCall()
        self.watchButton.layer.cornerRadius = self.watchButton.layer.frame.height/2
        self.recipeIngridients.layer.cornerRadius = 8
        self.recipeInstructions.layer.cornerRadius = 8
        saveButton.isUserInteractionEnabled = true
    }
    
    func instantiateArray() {
        UserDefaults.standard.set(arrayID, forKey: "SavedIds")
        UserDefaults.standard.set(arrayName, forKey: "SavedNames")
    }

    func setData() {
        
        let imgUrl = URL(string: randomRecipeData[0].meals[0].strMealThumb!)
        self.recipeImage.kf.setImage(with: imgUrl)
        
        self.recipeName.text = randomRecipeData[0].meals[0].strMeal!
        self.recipeInstructions.text = randomRecipeData[0].meals[0].strInstructions!
        setIngridients()
        setTags()
        
//        self.recipeIngridients.translatesAutoresizingMaskIntoConstraints = true
//        self.recipeIngridients.sizeToFit()
//        self.recipeIngridients.isScrollEnabled = false
//        
//        self.recipeInstructions.translatesAutoresizingMaskIntoConstraints = true
//        self.recipeInstructions.sizeToFit()
//        self.recipeInstructions.isScrollEnabled = false
//        
//        self.watchButton.translatesAutoresizingMaskIntoConstraints = false
    }

    func setIngridients() {
        checkIng()
        print(ingString)
        self.recipeIngridients.text = self.ingString
    }
    
    func setTags() {
        var tagStr = "Categories: "
        
        if randomRecipeData[0].meals[0].strCategory != nil {
            tagStr = tagStr + " " + randomRecipeData[0].meals[0].strCategory!
        }
        if randomRecipeData[0].meals[0].strArea != nil {
            tagStr = tagStr + ", " + randomRecipeData[0].meals[0].strArea!
        }
        if randomRecipeData[0].meals[0].strTags != nil {
            tagStr = tagStr + ", " + randomRecipeData[0].meals[0].strTags!
        }
        
        self.recipeTags.text = tagStr
    }
    
    func checkIng() {
        nullAdder(randomRecipeData[0].meals[0].strIngredient1 ?? "", randomRecipeData[0].meals[0].strMeasure1 ?? "")
        nullAdder(randomRecipeData[0].meals[0].strIngredient2 ?? "", randomRecipeData[0].meals[0].strMeasure2 ?? "")
        nullAdder(randomRecipeData[0].meals[0].strIngredient3 ?? "", randomRecipeData[0].meals[0].strMeasure3 ?? "")
        nullAdder(randomRecipeData[0].meals[0].strIngredient4 ?? "", randomRecipeData[0].meals[0].strMeasure4 ?? "")
        nullAdder(randomRecipeData[0].meals[0].strIngredient5 ?? "", randomRecipeData[0].meals[0].strMeasure5 ?? "")
        nullAdder(randomRecipeData[0].meals[0].strIngredient6 ?? "", randomRecipeData[0].meals[0].strMeasure6 ?? "")
        nullAdder(randomRecipeData[0].meals[0].strIngredient7 ?? "", randomRecipeData[0].meals[0].strMeasure7 ?? "")
        nullAdder(randomRecipeData[0].meals[0].strIngredient8 ?? "", randomRecipeData[0].meals[0].strMeasure8 ?? "")
        nullAdder(randomRecipeData[0].meals[0].strIngredient9 ?? "", randomRecipeData[0].meals[0].strMeasure9 ?? "")
        nullAdder(randomRecipeData[0].meals[0].strIngredient10 ?? "", randomRecipeData[0].meals[0].strMeasure10 ?? "")
        nullAdder(randomRecipeData[0].meals[0].strIngredient11 ?? "", randomRecipeData[0].meals[0].strMeasure11 ?? "")
        nullAdder(randomRecipeData[0].meals[0].strIngredient12 ?? "", randomRecipeData[0].meals[0].strMeasure12 ?? "")
        nullAdder(randomRecipeData[0].meals[0].strIngredient13 ?? "", randomRecipeData[0].meals[0].strMeasure13 ?? "")
        nullAdder(randomRecipeData[0].meals[0].strIngredient14 ?? "", randomRecipeData[0].meals[0].strMeasure14 ?? "")
        nullAdder(randomRecipeData[0].meals[0].strIngredient15 ?? "", randomRecipeData[0].meals[0].strMeasure15 ?? "")
        nullAdder(randomRecipeData[0].meals[0].strIngredient16 ?? "", randomRecipeData[0].meals[0].strMeasure16 ?? "")
        nullAdder(randomRecipeData[0].meals[0].strIngredient17 ?? "", randomRecipeData[0].meals[0].strMeasure17 ?? "")
        nullAdder(randomRecipeData[0].meals[0].strIngredient18 ?? "", randomRecipeData[0].meals[0].strMeasure18 ?? "")
        nullAdder(randomRecipeData[0].meals[0].strIngredient19 ?? "", randomRecipeData[0].meals[0].strMeasure19 ?? "")
        nullAdder(randomRecipeData[0].meals[0].strIngredient20 ?? "", randomRecipeData[0].meals[0].strMeasure20 ?? "")
    }
    
    func nullAdder(_ str: String, _ amt: String) {
        if str != nil && str != "" {
            ingString = ingString + "\(str): \(amt)\n"
        }
    }
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        
        var savedArrayID = UserDefaults.standard.stringArray(forKey: "SavedIds")
        savedArrayID?.append(randomRecipeData[0].meals[0].idMeal!)
        UserDefaults.standard.set(savedArrayID, forKey: "SavedIds")
        
        var savedArrayName = UserDefaults.standard.stringArray(forKey: "SavedNames")
        savedArrayName?.append(randomRecipeData[0].meals[0].strMeal!)
        UserDefaults.standard.set(savedArrayName, forKey: "SavedNames")
        
        UserDefaults.standard.synchronize()
        
        self.saveButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
        
        print("Save pressed")
    }
    
    @IBAction func watchVideoPressed(_ sender: UIButton) {
        if let youtubeURL = URL(string: "youtube://\(randomRecipeData[0].meals[0].strYoutube!)"), UIApplication.shared.canOpenURL(youtubeURL) {
            UIApplication.shared.canOpenURL(youtubeURL)
        } else {
            let url = URL(string: randomRecipeData[0].meals[0].strYoutube!)!
            UIApplication.shared.open(url)
        }
    }
}

//MARK: API Calls
extension ViewController {
    func randomCall() {
        AF.request(Constants.RANDOMAPI as URLConvertible).responseJSON { response in
            print(response.data ?? "data nil")
            self.parseRandomJSON(response.data!)
        }
    }
    
    func parseRandomJSON(_ data: Data) {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(RandomRecipeModel.self, from: data)
            
            self.randomRecipeData.append(decodedData)
            
            print(randomRecipeData[0].meals[0].idMeal!)
            print(randomRecipeData[0].meals[0].strMealThumb!)
            print(randomRecipeData[0].meals[0].strMeal!)
            print(randomRecipeData[0].meals[0].strInstructions!)
            
            self.setData()
        } catch {
            print("Parse error: \(error)")
        }
    }
}
