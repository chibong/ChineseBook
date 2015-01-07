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
        let textureAtlas = SKTextureAtlas(named:"appleAnim.atlas")
        var spriteArray = Array<SKTexture>()
        var apple: SKSpriteNode!
        var appleBite: SKAction!
    
        let letterLabel = SKLabelNode(text: "A")
        let chineseLabel = SKLabelNode(text: "苹果")
        let englishLabel = SKLabelNode(text: "Apple")

        var buttonSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("ping2guo3", ofType: "mp3")!)
        var audioPlayer = AVAudioPlayer()
        var button: SKNode! = nil
        var spriteNode = SKSpriteNode()
        var backButton = SKSpriteNode(imageNamed: "backbutton.png")
        override func didMoveToView(view: SKView) {
            
            self.backgroundColor = UIColor.whiteColor()
            setupApple()
            
            backButton.position = CGPoint(x: self.size.width * 0.2, y: self.size.height * 0.15)
            backButton.alpha = 1.0//optional
            self.addChild(backButton)
            
            self.scaleMode = .AspectFill
            
            letterLabel.fontColor = UIColor.redColor()
            letterLabel.fontSize = 200
            letterLabel.position = CGPoint(x: size.width * 0.20, y: size.height * 0.6)
            letterLabel.fontName = "Georgia-Bold"
            self.addChild(letterLabel)
            
            englishLabel.fontColor = UIColor.redColor()
            englishLabel.fontSize = 40
            englishLabel.position = CGPoint(x: size.width * 0.70, y: size.height * 0.4)
            englishLabel.fontName = "Georgia-Bold"
            self.addChild(englishLabel)
            
            chineseLabel.fontColor = UIColor.redColor()
            chineseLabel.fontSize = 40
            chineseLabel.position = CGPoint(x: size.width * 0.80, y: size.height * 0.4)
            chineseLabel.fontName = "Georgia-Bold"
            self.addChild(chineseLabel)
            
            /*

            chineseLabel.fontColor = UIColor.redColor()
            chineseLabel.fontSize = 30
            chineseLabel.position = CGPoint(x: size.width * 0.80, y: size.height * 0.1)
            self.addChild(label)
            */
    
            
            audioPlayer = AVAudioPlayer(contentsOfURL: buttonSound, error: nil)
            audioPlayer.prepareToPlay()
            
        }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        // Loop over all the touches in this event
        let menu = MenuScene(size: self.size)
        //let animateAction = SKAction.animateWithTextures(self.spriteArray, timePerFrame: 0.20);

        let scaleAction = SKAction.scaleTo(2.0, duration: 0.5)
        let shrinkAction = SKAction.scaleTo(1.0, duration: 0.5)
        let scaleThenReverse = SKAction.sequence([scaleAction, shrinkAction])
        
        for touch: AnyObject in touches {
            // Get the location of the touch in this scene
            let location = touch.locationInNode(self)
            // Check if the location of the touch is within the button's bounds
            if apple.containsPoint(location) {
                apple.runAction(appleBite)
                println("you bit me!")
                audioPlayer.play()
                println("tapped!")

            }
            if backButton.containsPoint(location){
                println("Going Back!")
                let transition = SKTransition.moveInWithDirection(SKTransitionDirection.Left, duration: 0.5)
                self.view?.presentScene(menu, transition: transition)
            }
            if englishLabel.containsPoint(location){
                englishLabel.runAction(scaleThenReverse)
            }
            if letterLabel.containsPoint(location){
                letterLabel.runAction(scaleThenReverse)
            }
            if chineseLabel.containsPoint(location){
                chineseLabel.runAction(scaleThenReverse)
            }
        }
    }
    func setupApple(){
        apple = SKSpriteNode(imageNamed: "apple1.png")
        apple.position = CGPoint(x: size.width * 0.70,y: size.height * 0.6)
        self.addChild(apple)
        let atlas = SKTextureAtlas(named: "apple")
        let anim = SKAction.animateWithTextures([
            atlas.textureNamed("apple1"),
            atlas.textureNamed("apple2")
            ], timePerFrame: 0.5)
        appleBite = SKAction.repeatAction(anim, count:1)

        
    }
    
    
    
}
