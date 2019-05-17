//
//  SignUpViewController.swift
//  FinalProjectIOS
//
//  Created by Kristopher Vala on 2019-04-09.
//  Copyright © 2019 dev. All rights reserved.
//

import CoreData
import UIKit
import SpriteKit


class SignUpViewController: UIViewController {

    @IBOutlet weak var back: UIButton!
    
    @IBOutlet weak var nameFe: UITextField!
    
    @IBOutlet weak var startGame: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "menu")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        // Do any additional setup after loading the view.
        
        
        //delete all data
        
        
    }
    
    
    @IBAction func startGameBut(_ sender: Any) {
        
        
        UserDefaults.standard.set(nameFe.text, forKey: "playerName")
        let start = self.storyboard?.instantiateViewController(withIdentifier:"GameSceneViewController") as! GameViewController
        
        self.present(start, animated:true)
        
       
        
    }
    
    
    @IBAction func homeBut(_ sender: Any) {
        let start = self.storyboard?.instantiateViewController(withIdentifier:"MainViewController") as! MainViewController
        
        self.present(start, animated:true)
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
