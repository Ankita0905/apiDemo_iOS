//
//  ViewController.swift
//  apiDemo_iOS
//
//  Created by Ankita Jain on 2020-01-17.
//  Copyright © 2020 Ankita Jain. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var cityTxt: UITextField!
    @IBOutlet weak var weatherLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
    }

    @IBAction func selectCityBtn(_ sender: UIButton) {
        
        let url=URL(string: "http://api.openweathermap.org/data/2.5/weather?q=\(cityTxt.text!.replacingOccurrences(of: " ", with: "%20"))&APPID=e374da6d1dfad92ef07f72798d1e50a1")!
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error{
                print(error)
            }
            else
            {
                if let urlContent = data
                {
                    do{
                        let jsonResult = try JSONSerialization.jsonObject(with: urlContent, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary
                       // print(jsonResult)
                        //print(jsonResult?["name"] as! String)
                        if let description = ((jsonResult?["weather"] as? NSArray)?[0] as? NSDictionary)?["description"] as? String
                        {
                          //print(description)
                            DispatchQueue.main.async {
                                self.weatherLbl.text=description
                            }
                        }
                    }catch{
                        print(error)
                    }
                
                }
            }
        }
        //start the task
        task.resume()
    }
    
}

