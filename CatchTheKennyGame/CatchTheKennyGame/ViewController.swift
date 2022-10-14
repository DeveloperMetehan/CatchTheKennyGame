//
//  ViewController.swift
//  CatchTheKennyGame
//
//  Created by Gappze on 14.07.2022.
//

import UIKit

class ViewController: UIViewController {
    
    var score = 0
    var time = Timer()
    var counter = 10
    var kennyArray = [UIImageView]()
    var hideTimer = Timer()
    var highScore = 0
    
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var highScoreLabel: UILabel!
    
    @IBOutlet weak var kenny1: UIImageView!
    
    @IBOutlet weak var kenny2: UIImageView!
    
    @IBOutlet weak var kenny3: UIImageView!
    
    @IBOutlet weak var kenny4: UIImageView!
    
    @IBOutlet weak var kenny5: UIImageView!
    
    @IBOutlet weak var kenny6: UIImageView!
    
    @IBOutlet weak var kenny7: UIImageView!
    
    @IBOutlet weak var kenny8: UIImageView!
    
    @IBOutlet weak var kenny9: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //highscore check
        
        let storedHighScore = UserDefaults.standard.object(forKey: "highScore")
        
        if storedHighScore == nil {
            highScore = 0
            highScoreLabel.text = " Highscore : \(highScore)"
            }
        
            if let newScore = storedHighScore as? Int {
                highScore = newScore
                highScoreLabel.text = "Highscore : \(highScore)"
            
        }
        
        
        scoreLabel.text = "Score : \(score)"
       
        kenny1.isUserInteractionEnabled = true
        kenny2.isUserInteractionEnabled = true
        kenny3.isUserInteractionEnabled = true
        kenny4.isUserInteractionEnabled = true
        kenny5.isUserInteractionEnabled = true
        kenny6.isUserInteractionEnabled = true
        kenny7.isUserInteractionEnabled = true
        kenny8.isUserInteractionEnabled = true
        kenny9.isUserInteractionEnabled = true
        
        let gestureRecognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        kenny1.addGestureRecognizer(gestureRecognizer1)
        kenny2.addGestureRecognizer(gestureRecognizer2)
        kenny3.addGestureRecognizer(gestureRecognizer3)
        kenny4.addGestureRecognizer(gestureRecognizer4)
        kenny5.addGestureRecognizer(gestureRecognizer5)
        kenny6.addGestureRecognizer(gestureRecognizer6)
        kenny7.addGestureRecognizer(gestureRecognizer7)
        kenny8.addGestureRecognizer(gestureRecognizer8)
        kenny9.addGestureRecognizer(gestureRecognizer9)
        
        kennyArray = [kenny1,kenny2,kenny3,kenny4,kenny5,kenny6,kenny7,kenny8,kenny9]
        
        //timer
        
        timeLabel.text = "Time : \(counter)"
        time = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timeCounter), userInfo: nil, repeats: true)
        
        hideTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(hideKenny), userInfo: nil, repeats: true)
        
        
    
       //
        hideKenny()
    }
       @objc func hideKenny () {
            
            for kenny in kennyArray {
                
                kenny.isHidden = true
            }
         let random =   Int(arc4random_uniform(UInt32(kennyArray.count - 1)))
            kennyArray[random].isHidden = false
        }
        
        
    
    @objc func  increaseScore () {
        
        score += 1
        scoreLabel.text = "Score : \(score)"
        
        
    }
    
    @objc func timeCounter() {
        
        counter -= 1
        timeLabel.text = "Time : \(counter) "
        
        if counter == 0 {
            
            timeLabel.text = "Time's over!"
            time.invalidate()
            hideTimer.invalidate()

            for kenny in kennyArray {
                
                kenny.isHidden = true
            }
            
            //highscore
            
            if self.score > self.highScore {
                
                self.score = self.highScore
                highScoreLabel.text = "Highscore : \(self.highScore)"
                UserDefaults.standard.set(self.highScore, forKey: "highScore")
                
                
            }
            
            
            
            //alert
            
            
            
            let alert = UIAlertController(title: "Time's over!", message: "Do you want to play again?", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
            let replayButton = UIAlertAction(title: "REPLAY", style: UIAlertAction.Style.default) { UIAlertAction in
                //replay function
                
                self.score = 0
                self.scoreLabel.text = "Score : \(self.score)"
                self.counter = 10
                self.timeLabel.text = "Time : \(self.counter)"
                
                self.timeLabel.text = "Time : \(self.counter)"
                self.time = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.timeCounter), userInfo: nil, repeats: true)
                
                self.hideTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.hideKenny), userInfo: nil, repeats: true)
                
            }
            alert.addAction(okButton)
            alert.addAction(replayButton)
            self.present(alert, animated: true)
       
        }
        }
        

    }
    
    
    
    


