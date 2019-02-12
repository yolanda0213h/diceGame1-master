//
//  ViewController.swift
//  diceGame
//
//  Created by Yolanda H. on 2019/1/8.
//  Copyright © 2019 Yolanda H. All rights reserved.
//

import UIKit
import AVFoundation
class ViewController: UIViewController {
    var dicenames = ["d01","d02","d03","d04","d05","d06"]
    var shakeMove: Timer?
    var player: AVPlayer?
    @IBOutlet var diceImage: [UIImageView]!
    @IBOutlet weak var shakeButton: UIButton!
    @IBOutlet weak var blackView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        for diceimage in diceImage{
            diceimage.image = UIImage(named: dicenames.randomElement()!)
        }
        let shakeMusic = Bundle.main.url(forResource: "rolldice", withExtension: "mp3")!
        player = AVPlayer(url: shakeMusic)
        player?.play()
    }

    @IBAction func diceCupFunc(_ sender: UIButton) {
        if sender.currentTitle == "open dice cup" {
            UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 2, delay: 0, animations: {
                self.blackView.frame.origin.y = 10
                self.blackView.frame.origin.x = 180
                self.blackView.transform = CGAffineTransform(rotationAngle: CGFloat.pi/7)
                })
            sender.setTitle("close dice cup", for: UIControl.State.normal)
            shakeButton.isEnabled = false
        } else if sender.currentTitle == "close dice cup" {
            UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 1, delay: 0, animations: {
                self.blackView.transform = CGAffineTransform(rotationAngle: 0)
                self.blackView.frame.origin.x = 65
                self.blackView.frame.origin.y = 140
            })
            sender.setTitle("open dice cup", for: UIControl.State.normal)
            shakeButton.isEnabled = true
        }
    }
    @IBAction func shakeFunc(_ sender: UIButton) {
        if sender.currentTitle == "shake" {
            shakeMove = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: {(_)in
                for diceimage in self.diceImage{
                    diceimage.image = UIImage(named: self.dicenames.randomElement()!)
                }
            })
            let shakeMusic = Bundle.main.url(forResource: "rolldice", withExtension: "mp3")!
            player = AVPlayer(url: shakeMusic)
            player?.play()
            sender.setTitle("stop", for: UIControl.State.normal)
        } else if sender.currentTitle == "stop"{
            shakeMove?.invalidate()
            sender.setTitle("shake", for: UIControl.State.normal)
        }
    }
   
    @IBAction func fluoroscopyFunc(_ sender: UISwitch) {
        if sender.isOn == true{
            blackView.alpha = 0.8
        }else if sender.isOn == false{
            blackView.alpha = 1
        }
    }
}

