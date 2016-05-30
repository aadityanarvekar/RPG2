//
//  ViewController.swift
//  RPG2
//
//  Created by AADITYA NARVEKAR on 5/29/16.
//  Copyright © 2016 Aaditya Narvekar. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    let PLAYER_ONE_NAME = "Ogre"
    
    var ogre: Ogre!
    var spartan: Spartan!
    
    var victorySound: AVAudioPlayer!
    var attckSound: AVAudioPlayer!
    var bgSound: AVAudioPlayer!

    @IBOutlet weak var plyr1AttackBtn: UIButton!
    @IBOutlet weak var plyr2AttackBtn: UIButton!
    @IBOutlet weak var restartGameBtn: UIButton!
    @IBOutlet weak var playr1HPLbl: UILabel!
    @IBOutlet weak var playr2HPLbl: UILabel!
    @IBOutlet weak var statusLbl: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeGame()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initializeGame() {
        
        let bgSoundPath = NSURL.fileURLWithPath(NSBundle.mainBundle().pathForResource("bgSound", ofType: "wav")!)
        do {
            try bgSound = AVAudioPlayer(contentsOfURL: bgSoundPath)
        } catch let error as NSError {
            print("\(error.description)")
        }
        bgSound.prepareToPlay()
        bgSound.play()
        bgSound.numberOfLoops = -1
        
        let victorySoundPath = NSURL.fileURLWithPath(NSBundle.mainBundle().pathForResource("victory", ofType: "wav")!)
        do {
            try victorySound = AVAudioPlayer(contentsOfURL: victorySoundPath)
        } catch let error as NSError {
            print("\(error.description)")
        }
        victorySound.prepareToPlay()

        
        let attckSoundPath = NSURL.fileURLWithPath(NSBundle.mainBundle().pathForResource("swing", ofType: "wav")!)
        do {
            try attckSound = AVAudioPlayer(contentsOfURL: attckSoundPath)
        } catch let error as NSError {
            print("\(error.description)")
        }
        attckSound.prepareToPlay()
        
        
        ogre = Ogre()
        spartan = Spartan()
        
        restartGameBtn.hidden = true
        
        plyr1AttackBtn.enabled = true
        plyr2AttackBtn.enabled = true
        
        playr1HPLbl.hidden = false
        playr1HPLbl.text = "\(ogre.healingPower) HP"
        
        playr2HPLbl.hidden = false
        playr2HPLbl.text = "\(spartan.healingPower) HP"
        
        statusLbl.text = "\(ogre.name) vs \(spartan.name)"
    }


    @IBAction func plyr1AttackBtnTapped(sender: AnyObject) {
        handleAttackBy(ogre)
    }
    
    
    @IBAction func plyr2AttackBtnTapped(sender: AnyObject) {
        handleAttackBy(spartan)
    }
    
    func handleAttackBy(player: Character) {
        playAttackSound()
        statusLbl.text = "\(player.name) attacked"
        if player.name == PLAYER_ONE_NAME {
            plyr2AttackBtn.enabled = false
            spartan.handleAttackAttempt(ogre.attackPower)
            playr2HPLbl.text = "\(spartan.healingPower) HP"
        } else {
            plyr1AttackBtn.enabled = false
            ogre.handleAttackAttempt(player.attackPower)
            playr1HPLbl.text = "\(ogre.healingPower) HP"
        }
        
        NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(ViewController.reArmPlayer), userInfo: nil, repeats: false)
        
        if !ogre.isAlive() || !spartan.isAlive() {
            bgSound.stop()
            plyr1AttackBtn.enabled = false
            plyr2AttackBtn.enabled = false
            playr2HPLbl.hidden = true
            playr1HPLbl.hidden = true
            
            if !ogre.isAlive() {
                statusLbl.text = "\(ogre.name) won"
            } else {
                statusLbl.text = "\(spartan.name) won"
            }
            
            restartGameBtn.hidden = false
            victorySound.play()
        }
        
    }
    
    func playAttackSound() {
        if attckSound.playing {
            attckSound.stop()
        }
        
        attckSound.play()
    }
    
    func reArmPlayer() {
        if ogre.isAlive() && spartan.isAlive() {
            plyr1AttackBtn.enabled = true
            plyr2AttackBtn.enabled = true
        }
    }
    
    @IBAction func restartGameBtnTapped(sender: AnyObject) {
        initializeGame()
    }
}

