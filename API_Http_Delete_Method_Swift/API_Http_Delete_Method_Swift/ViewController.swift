//
//  ViewController.swift
//  API_Http_Delete_Method_Swift
//
//  Created by Mac on 17/05/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        httpDeleteMethod()
    }
    
    //https://dummyjson.com/products/1
    
    
    func httpDeleteMethod(){
      let baseUrl = "https://dummyjson.com/"
      let path = "products/"
      let productId = "8"
      guard let url = URL(string: "\(baseUrl)\(path)\(productId)") else {
           print("Invalid Url")
           return
      }
      var request = URLRequest(url: url)
          request.httpMethod = "DELETE"
          
        URLSession.shared.dataTask(with: request){ data, response, error in
            guard let data = data, error == nil else {
                print("Invalid Data")
                return
            }
            guard let response = response as? HTTPURLResponse,
            200...299 ~= response.statusCode else {
                print("Invalid Response")
                return
            }
            do{
                let product = try JSONDecoder().decode(Product.self, from: data)
                print(product)
            }
            catch let err{
                print(err)
            }

        }.resume()
    }
}

struct Product: Decodable{
    let id: Int
    let title: String
    let description: String
    let price: Int
    let discountPercentage: Double
    let rating: Double
    let stock: Int
    let brand: String
    let category: String
    let thumbnail: String
    let images: [String]
    let isDeleted: Bool
    let deletedOn: String
}
