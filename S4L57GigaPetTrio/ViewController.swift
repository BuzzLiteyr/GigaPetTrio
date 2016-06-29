//
//  ViewController.swift
//  S4L57GigaPetTrio
//
//  Created by Michel Besnard on 29-06-16.
//  Copyright © 2016 Michel YJL Besnard. All rights reserved.
//
import UIKit
import Foundation
import AVFoundation

class ViewController: UIViewController {
    
    
    @IBOutlet weak var selectDM: UIButton!
    @IBOutlet weak var selectHM: UIButton!
    @IBOutlet weak var selectIM: UIButton!
    
    @IBOutlet weak var exit: UIButton!
    @IBOutlet weak var SciFiBG: UIImageView!
    @IBOutlet weak var ZombieBG: UIImageView!
    @IBOutlet weak var snowBG: UIImageView!
    
    @IBOutlet weak var dmMonsterImg: Robot!
    @IBOutlet weak var hmMonsterImg: Zombie!
    @IBOutlet weak var imMonsterImg: SnowMonster!
    @IBOutlet weak var foodImg: DragImg!
    @IBOutlet weak var drinkImg: DragImg!
    @IBOutlet weak var heartImg: DragImg!
    @IBOutlet weak var penalty1Img: UIImageView!
    @IBOutlet weak var penalty2Img: UIImageView!
    @IBOutlet weak var penalty3Img: UIImageView!
    @IBOutlet weak var livesPanel: UIImageView!
    @IBOutlet weak var selectMsg: UILabel!
    
    let DIM_ALPHA: CGFloat = 0.2  // these are all CAPS to let the programmer know that they are dealing with a constant and not a variable
    let OPAQUE: CGFloat = 1.0
    let MAX_PENALTIES = 3
    
    var penalties = 0
    var timer: Timer!
    var monsterHappy = false
    var currentItem: UInt32 = 0
    
    var monsterType = 0
    
    var introMusic: AVAudioPlayer!
    var dmMusic: AVAudioPlayer!
    var hmMusic: AVAudioPlayer!
    var imMusic: AVAudioPlayer!
    var sfxBite: AVAudioPlayer!
    var sfxHeart: AVAudioPlayer!
    var sfxDeath: AVAudioPlayer!
    var sfxSkull: AVAudioPlayer!
    
    
    @IBAction func onDMSelected(_ sender: AnyObject) {
        monsterType = 2
        setupInitialScreen()
        dmMonsterImg.isHidden = false
        SciFiBG.isHidden = false
        dmMonsterImg.playIdleAnimation()
        introMusic.stop()
        dmMusic.play()
        dmMusic.numberOfLoops = -1
    }
    
    @IBAction func onHMSelected(_ sender: AnyObject) {
        monsterType = 1
        setupInitialScreen()
        hmMonsterImg.isHidden = false
        ZombieBG.isHidden = false
        hmMonsterImg.playIdleAnimation()
        introMusic.stop()
        hmMusic.play()
        hmMusic.numberOfLoops = -1
    }
    
    @IBAction func onIMSelected(_ sender: AnyObject) {
        monsterType = 3
        setupInitialScreen()
        imMonsterImg.isHidden = false
        snowBG.isHidden = false
        imMonsterImg.playIdleAnimation()
        introMusic.stop()
        imMusic.play()
        imMusic.numberOfLoops = -1
    }
    
    @IBAction func exitToMainMenu(_ sender: AnyObject) {
        setupMainMenu()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        heartImg.dropTarget = dmMonsterImg
        drinkImg.dropTarget = dmMonsterImg
        foodImg.dropTarget = dmMonsterImg
        //        heartImg.dropTarget = hmMonsterImg
        //        drinkImg.dropTarget = hmMonsterImg
        //        foodImg.dropTarget = hmMonsterImg
        //        heartImg.dropTarget = imMonsterImg
        //        drinkImg.dropTarget = imMonsterImg
        //        foodImg.dropTarget = imMonsterImg
        
        penalty1Img.alpha = DIM_ALPHA
        penalty2Img.alpha = DIM_ALPHA
        penalty3Img.alpha = DIM_ALPHA
        
        NotificationCenter.default().addObserver(self, selector: #selector(itemDroppedOnCharacter), name: "onTargetDropped", object: nil)
        
        do {
            let resourcePath = Bundle.main().pathForResource("Intro", ofType: "mp3")
            let soundUrl = URL(fileURLWithPath: resourcePath!)
            try introMusic = AVAudioPlayer(contentsOf: soundUrl as URL)
            
            try dmMusic = AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main().pathForResource("Robot", ofType: "mp3")!))
            
            try hmMusic = AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main().pathForResource("HairyMummy", ofType: "mp3")!))
            
            try imMusic = AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main().pathForResource("IceMonster", ofType: "mp3")!))
            
            try sfxBite = AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main().pathForResource("bite", ofType: "wav")!))
            
            try sfxHeart = AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main().pathForResource("heart", ofType: "wav")!))
            
            try sfxDeath = AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main().pathForResource("death", ofType: "wav")!))
            
            try sfxSkull = AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main().pathForResource("skull", ofType: "wav")!))
            
            introMusic.prepareToPlay()
            introMusic.numberOfLoops = -1
            introMusic.play()
            
            dmMusic.prepareToPlay()
            hmMusic.prepareToPlay()
            imMusic.prepareToPlay()
            sfxBite.prepareToPlay()
            sfxHeart.prepareToPlay()
            sfxDeath.prepareToPlay()
            sfxSkull.prepareToPlay()
            
        } catch let err as NSError {
            
            print(err.debugDescription)
        }
    }
    
    func setupInitialScreen() {
        selectMsg.isHidden = true
        selectDM.isHidden = true
        selectHM.isHidden = true
        selectIM.isHidden = true
        foodImg.isHidden = false
        drinkImg.isHidden = false
        heartImg.isHidden = false
        penalty1Img.isHidden = false
        penalty2Img.isHidden = false
        penalty3Img.isHidden = false
        livesPanel.isHidden = false
        exit.isHidden = true
        monsterHappy = true
        penalty1Img.alpha = DIM_ALPHA
        penalty2Img.alpha = DIM_ALPHA
        penalty3Img.alpha = DIM_ALPHA
        currentItem = 0
        penalties = 0
        changeGameState()
        startTimer()
    }
    
    func setupMainMenu() {
        selectMsg.isHidden = false
        selectDM.isHidden = false
        selectHM.isHidden = false
        selectIM.isHidden = false
        dmMonsterImg.isHidden = true
        hmMonsterImg.isHidden = true
        imMonsterImg.isHidden = true
        SciFiBG.isHidden = true
        ZombieBG.isHidden = true
        snowBG.isHidden = true
        foodImg.isHidden = true
        drinkImg.isHidden = true
        heartImg.isHidden = true
        penalty1Img.isHidden = true
        penalty2Img.isHidden = true
        penalty3Img.isHidden = true
        livesPanel.isHidden = true
        exit.isHidden = true
        introMusic.play()
        introMusic.numberOfLoops = -1
        dmMusic.stop()
        hmMusic.stop()
        imMusic.stop()
    }
    
    func itemDroppedOnCharacter(notif: AnyObject) {
        monsterHappy = true
        startTimer()
        
        heartImg.alpha = DIM_ALPHA
        heartImg.isUserInteractionEnabled = false
        drinkImg.alpha = DIM_ALPHA
        drinkImg.isUserInteractionEnabled = false
        foodImg.alpha = DIM_ALPHA
        foodImg.isUserInteractionEnabled = false
        
        if currentItem == 0 {
            sfxHeart.play()
        } else if currentItem == 1 {
            sfxBite.play()
        } else {
            sfxBite.play()
        }
    }
    
    func startTimer() {
        if timer != nil {
            timer.invalidate() // stops the current timer before starting a new one, a safety measure
        }
        
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(ViewController.changeGameState), userInfo: nil, repeats: true)
    }
    
    func changeGameState() {
        
        if !monsterHappy {
            penalties += 1
            
            sfxSkull.play()
            
            if penalties == 1 {
                penalty1Img.alpha = OPAQUE
                penalty2Img.alpha = DIM_ALPHA
            } else if penalties == 2 {
                penalty2Img.alpha = OPAQUE
                penalty3Img.alpha = DIM_ALPHA
            } else if penalties >= 3 {
                penalty3Img.alpha = OPAQUE
            } else {
                penalty1Img.alpha = DIM_ALPHA
                penalty2Img.alpha = DIM_ALPHA
                penalty3Img.alpha = DIM_ALPHA
            }
            
            if penalties >= MAX_PENALTIES {
                gameOver()
            }
        }
        
        let rand = arc4random_uniform(3) // 0 or 1 or 2
        
        if rand == 0 {
            
            heartImg.alpha = OPAQUE
            heartImg.isUserInteractionEnabled = true
            drinkImg.alpha = DIM_ALPHA
            drinkImg.isUserInteractionEnabled = false
            foodImg.alpha = DIM_ALPHA
            foodImg.isUserInteractionEnabled = false
            
            
        } else  if rand == 1 {
            
            heartImg.alpha = DIM_ALPHA
            heartImg.isUserInteractionEnabled = false
            drinkImg.alpha = OPAQUE
            drinkImg.isUserInteractionEnabled = true
            foodImg.alpha = DIM_ALPHA
            foodImg.isUserInteractionEnabled = false
            
        } else {
            
            heartImg.alpha = DIM_ALPHA
            heartImg.isUserInteractionEnabled = false
            drinkImg.alpha = DIM_ALPHA
            drinkImg.isUserInteractionEnabled = false
            foodImg.alpha = OPAQUE
            foodImg.isUserInteractionEnabled = true
            
        }
        
        currentItem = rand
        monsterHappy = false
        
    }
    
    func gameOver() {
        
        if monsterType == 1 {
            print("Hairy Mummy Died")
            hmMonsterImg.playDeathAnimation()
        } else if monsterType == 2 {
            print("Robot Monster Died")
            dmMonsterImg.playDeathAnimation()
        } else if monsterType == 3 {
            print("Ice Monster Died")
            imMonsterImg.playDeathAnimation()
        }
        
        timer.invalidate()
        
        heartImg.isUserInteractionEnabled = false
        drinkImg.isUserInteractionEnabled = false
        foodImg.isUserInteractionEnabled = false
        sfxDeath.play()
        exit.isHidden = false
        
        
        
    }
}

