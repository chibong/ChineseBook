//
//  GameScene.swift
//  ChineseBook
//
//  Created by Chang, Eric on 12/27/14.
//  Copyright (c) 2014 Chang, Eric. All rights reserved.
//

import Spritekit
import AVFoundation

class GameScene: SKScene {
        var buttonSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("ping2guo3", ofType: "mp3")!)
        var audioPlayer = AVAudioPlayer()
        var button: SKNode! = nil
        let spriteNode = SKSpriteNode(imageNamed: "apple")
        var backButton = SKSpriteNode(imageNamed: "backbutton.png")
    
        override func didMoveToView(view: SKView) {
            
            self.backgroundColor = UIColor.whiteColor()
            
            backButton.position = CGPoint(x: self.size.width * 0.1, y: self.size.height * 0.1)
            backButton.alpha = 1.0//optional
            self.addChild(backButton)
            
            self.scaleMode = .AspectFill
            spriteNode.position = CGPoint(x: size.width / 2.0,y: size.height / 2.0)
            let letterLabel = SKLabelNode(text: "A")
            letterLabel.fontColor = UIColor.redColor()
            letterLabel.fontSize = 100
            letterLabel.position = CGPoint(x: size.width * 0.20, y: size.height * 0.7)
            letterLabel.fontName = "AppleSDGothicNeo-Bold"
            self.addChild(letterLabel)
            
            let englishLabel = SKLabelNode(text: "Apple")
            englishLabel.fontColor = UIColor.redColor()
            englishLabel.position = CGPoint(x: size.width / 4.0, y: size.height / 10)
            englishLabel.fontName = "AppleSDGothicNeo-Bold"
            self.addChild(englishLabel)
            
            let label = SKLabelNode(text: "苹果")
            label.fontColor = UIColor.redColor()
            label.position = CGPoint(x: size.width * 0.80, y: size.height / 10)
            self.addChild(label)
            self.addChild(spriteNode)
            
            let scaleAction = SKAction.scaleTo(2.0, duration: 0.5)
            let moveBackAction = scaleAction.reversedAction()
            let scaleThenReverse = SKAction.sequence([scaleAction, moveBackAction])
            englishLabel.runAction(scaleThenReverse)
            
            audioPlayer = AVAudioPlayer(contentsOfURL: buttonSound, error: nil)
            audioPlayer.prepareToPlay()
            
        }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        // Loop over all the touches in this event
        let menu = MenuScene(size: self.size)
        
        for touch: AnyObject in touches {
            // Get the location of the touch in this scene
            let location = touch.locationInNode(self)
            // Check if the location of the touch is within the button's bounds
            if spriteNode.containsPoint(location) {
                println("tapped!")
                audioPlayer.play()
            }
            if backButton.containsPoint(location){
                println("Going Back!")
                let transition = SKTransition.moveInWithDirection(SKTransitionDirection.Left, duration: 0.5)
                self.view?.presentScene(menu, transition: transition)
            }
        }
    }
    
    
    
}

        /*


var button: SKNode! = nil

override func didMoveToView(view: SKView) {
// Create a simple red rectangle that's 100x44
button = SKSpriteNode(color: SKColor.redColor(), size: CGSize(width: 100, height: 44))
// Put it in the center of the scene
button.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame));

self.addChild(button)
}

override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
// Loop over all the touches in this event
for touch: AnyObject in touches {
// Get the location of the touch in this scene
let location = touch.locationInNode(self)
// Check if the location of the touch is within the button's bounds
if button.containsPoint(location) {
println("tapped!")
}
}
}


            let filePath:NSURL = NSURL(fileURLWithPath:"/Users/ericc418/projects/Chinese App/Chinese App/ping2guo3.mp3")!
            var er:NSError?
            let audioPlayer:AVAudioPlayer = AVAudioPlayer(contentsOfURL: filePath, error: &er)
            println("playing...")
            audioPlayer.play()
            
        var error:NSError?
        
        let soundFileURL = NSBundle.mainBundle().URLForResource("ping2guo3",withExtension: "mp3")
        let audioPlayer = AVAudioPlayer(contentsOfURL: soundFileURL, error: &error)
        audioPlayer.play()
        println("Sound played")

            /*
            var alertSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("ping2guo3", ofType: "mp3")!)
            println(alertSound)
            
            // Removed deprecated use of AVAudioSessionDelegate protocol
            AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback, error: nil)
            AVAudioSession.sharedInstance().setActive(true, error: nil)
            
            var audioPlayer = AVAudioPlayer()
            audioPlayer = AVAudioPlayer(contentsOfURL: alertSound, error: &error)
            audioPlayer.prepareToPlay()
            audioPlayer.play()
            println("Sound played")
            */
         */
            
            
 

