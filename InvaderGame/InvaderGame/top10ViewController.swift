//
//  top10ViewController.swift
//  FinalProjectIOS
//
//  Created by Kristopher Vala on 2019-04-18.
//  Copyright © 2019 dev. All rights reserved.
//

import UIKit
import CoreData

class top10ViewController: UIViewController {

    var players = [Player]()
    var namearr = [UILabel]()
    var scorearr = [UILabel]()
    var name22 = [String]()
    var score22 = [Int]()
    
    @IBOutlet weak var name1: UILabel!
    @IBOutlet weak var name2: UILabel!
    @IBOutlet weak var name3: UILabel!
    @IBOutlet weak var name5: UILabel!
    @IBOutlet weak var name4: UILabel!
    @IBOutlet weak var name6: UILabel!
    @IBOutlet weak var name7: UILabel!
    @IBOutlet weak var name8: UILabel!
    @IBOutlet weak var name9: UILabel!
    @IBOutlet weak var name10: UILabel!
    @IBOutlet weak var score1: UILabel!
    @IBOutlet weak var score2: UILabel!
    @IBOutlet weak var score3: UILabel!
    @IBOutlet weak var score4: UILabel!
    @IBOutlet weak var score5: UILabel!
    @IBOutlet weak var score6: UILabel!
    @IBOutlet weak var score7: UILabel!
    @IBOutlet weak var score8: UILabel!
    @IBOutlet weak var score9: UILabel!
    @IBOutlet weak var score10: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "menu")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        // Do any additional setup after loading the view.
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Players")
        request.returnsObjectsAsFaults = false
        
      
        namearr.append(name1)
        namearr.append(name2)
        namearr.append(name3)
        namearr.append(name4)
        namearr.append(name5)
        namearr.append(name6)
        namearr.append(name7)
        namearr.append(name8)
        namearr.append(name9)
        namearr.append(name10)
        
        scorearr.append(score1)
        scorearr.append(score2)
        scorearr.append(score3)
        scorearr.append(score4)
        scorearr.append(score5)
        scorearr.append(score6)
        scorearr.append(score7)
        scorearr.append(score8)
        scorearr.append(score9)
        scorearr.append(score10)
    

        
    

        
        do {
            let results = try context.fetch(request)
            if results.count > 0 {
                for result in results as! [NSManagedObject] {
                    let username = result.value(forKey: "name") as? String
                    let scores = result.value(forKey: "score")
                        name22.append(username ?? "No name")
                        score22.append(scores as! Int)
                       print (username)
                        print (scores)

                    
                
            }
        }
        }
        catch {
            print ("error")
        }
        score22.sort(by: >)
        // players.sorted(by: { $0.score > $1.score })
        if(namearr.isEmpty == false){
        for  i in 0 ... 9 {
                namearr[i].text = name22[i]
            
            scorearr[i].text = "\(score22[i])"
            }
        }
        
    }
    
   /* func getLabelsInView(view: UIView) -> [UILabel] {
        var results = [UILabel]()
        for subview in view.subviews as [UIView] {
            if let label = subview as? UILabel {
                results += [label]
            } else {
                results += getLabelsInView(view: subview)
            }
        }
        return results
    }*/

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func home(_ sender: Any) {
        
        let start = self.storyboard?.instantiateViewController(withIdentifier:"MainViewController") as! MainViewController
        
        self.present(start, animated:true)
        
    }
    
  


}
