//
//  ViewController.swift
//  CatchTheCat
//
//  Created by Yıldız Uysal on 12.05.2019.
//  Copyright © 2019 Yıldız Uysal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblHighScore: UILabel!
    @IBOutlet weak var lblScore: UILabel!
    @IBOutlet weak var cat1: UIImageView!
    @IBOutlet weak var cat2: UIImageView!
    @IBOutlet weak var cat3: UIImageView!
    @IBOutlet weak var cat4: UIImageView!
    @IBOutlet weak var cat5: UIImageView!
    @IBOutlet weak var cat6: UIImageView!
    @IBOutlet weak var cat7: UIImageView!
    @IBOutlet weak var cat8: UIImageView!
    @IBOutlet weak var cat9: UIImageView!
    
    var score = 0
    var timer = Timer()
    var counter = 0
    var catArray = [UIImageView]()
    var hideTimer = Timer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
      
        let highScore = UserDefaults.standard.object(forKey: "HighScore")
        
        if highScore == nil {
            lblHighScore.text = "0"
        }
        if let newScore = highScore as? Int {
            lblHighScore.text = String(newScore)
        }
        
        
        lblScore.text = "\(score)"
        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore))
        
        cat1.isUserInteractionEnabled = true
        cat2.isUserInteractionEnabled = true
        cat3.isUserInteractionEnabled = true
        cat4.isUserInteractionEnabled = true
        cat5.isUserInteractionEnabled = true
        cat6.isUserInteractionEnabled = true
        cat7.isUserInteractionEnabled = true
        cat8.isUserInteractionEnabled = true
        cat9.isUserInteractionEnabled = true
        
        cat1.addGestureRecognizer(recognizer1)
        cat2.addGestureRecognizer(recognizer2)
        cat3.addGestureRecognizer(recognizer3)
        cat4.addGestureRecognizer(recognizer4)
        cat5.addGestureRecognizer(recognizer5)
        cat6.addGestureRecognizer(recognizer6)
        cat7.addGestureRecognizer(recognizer7)
        cat8.addGestureRecognizer(recognizer8)
        cat9.addGestureRecognizer(recognizer9)
        
        
        //Timers
        
        counter = 30
        lblTime.text = "\(counter)"
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.countDown), userInfo: nil, repeats: true)
        
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(ViewController.hideCat), userInfo: nil, repeats: true)
       
        //Array
        
        catArray.append(cat1)
        catArray.append(cat2)
        catArray.append(cat3)
        catArray.append(cat4)
        catArray.append(cat5)
        catArray.append(cat6)
        catArray.append(cat7)
        catArray.append(cat8)
        catArray.append(cat9)
        
    }
   
    @objc func hideCat(){
        for cat in catArray {
            cat.isHidden = true
        }
        
        let random = Int(arc4random_uniform(UInt32(catArray.count)))
        
        catArray[random].isHidden = false
        
    }
    
    @objc func countDown(){
        counter = counter - 1
        lblTime.text = "\(counter)"
        
        if counter == 0 {
            timer.invalidate()
            hideTimer.invalidate()
            
            if self.score > Int(lblHighScore.text!)!{
                
                UserDefaults.standard.set(self.score, forKey: "HighScore")
                lblHighScore.text = String(self.score)
            }
            
            let alert = UIAlertController(title: "Time", message: "Time's Up", preferredStyle: UIAlertControllerStyle.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
            let replayButton=UIAlertAction(title: "Replay", style: UIAlertActionStyle.default) { (UIAlertAction) in
                
                self.score = 0
                self.lblScore.text = "\(self.score)"
                self.counter=30
                self.lblTime.text   = "\(self.counter)"
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.countDown), userInfo: nil, repeats: true)
                
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(ViewController.hideCat), userInfo: nil, repeats: true)
            }
            alert.addAction(okButton)
            alert.addAction(replayButton)
            self.present(alert,animated: true,completion: nil)
            
            
        }
        
        
    }
    
    @objc func increaseScore(){
        score = score + 1
        
        lblScore.text = "\(score)"
    }

  

}

