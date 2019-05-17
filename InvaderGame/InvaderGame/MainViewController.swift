//
//  MainViewController.swift
//  FinalProjectIOS
//
//  Created by Kristopher Vala on 2019-04-09.
//  Copyright © 2019 dev. All rights reserved.
//

import UIKit
import CoreData

class MainViewController: UIViewController {

    
    @IBOutlet weak var startGame: UIButton!
    
    @IBOutlet weak var scorelab: UILabel!
    
    @IBOutlet weak var scores: UIButton!
    @IBOutlet weak var quit: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "menu")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)

        var fscore = UserDefaults.standard.value(forKey: "finalscoree")
       // var score = String(fscore)
        scorelab?.text = "Previous Score: \(fscore ?? 0)"

        
        
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func startBut(_ sender: Any) {
        let start = self.storyboard?.instantiateViewController(withIdentifier:"SignUpViewController") as! SignUpViewController
        
        self.present(start, animated:true)
        
        
    }
    
    @IBAction func scoresbut(_ sender: Any) {
        let hiscores = self.storyboard?.instantiateViewController(withIdentifier:"top10ViewController") as! top10ViewController
        
        self.present(hiscores, animated:true)
    }
    
    
    @IBAction func quitbut(_ sender: Any) {
        exit(0);

    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
