//
//  GameScene.swift
//  ChineseBook
//
//  Created by Chang, Eric on 12/27/14.
//  Copyright (c) 2014 Chang, Eric. All rights reserved.
//

import Spritekit
import AVFoundation

class bScene: SKScene {
    
    let textureAtlas = SKTextureAtlas(named:"appleAnim.atlas")
    var spriteArray = Array<SKTexture>()
    var apple: SKSpriteNode!
    var appleBite: SKAction!
    
    let letterLabel = SKLabelNode(text: "Bb")
    let chineseLabel = SKLabelNode(text: "球")
    let englishLabel = SKLabelNode(text: "Ball")
    
    let chineseLabel2 = SKLabelNode(text: "自行車")
    let englishLabel2 = SKLabelNode(text: "Bike")
    
    var ballSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("ball", ofType: "mp3")!)
    var biteSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("appleBite", ofType: "mp3")!)
    var appleEnglish = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("appleEnglish", ofType: "mp3")!)
    var audioPlayer = AVAudioPlayer()
    var bitePlayer = AVAudioPlayer()
    var applePlayer = AVAudioPlayer()
    var button: SKNode! = nil
    
    var spriteNode = SKSpriteNode()
    var backButton = SKSpriteNode(imageNamed: "backbutton.png")
    var fwdButton = SKSpriteNode(imageNamed: "forwardbutton1.png")
    var homeButton = SKSpriteNode(imageNamed: "homebutton.png")
    
    func swipedRight(sender:UISwipeGestureRecognizer){
        println("swiped right")
    }
    
    func swipedLeft(sender:UISwipeGestureRecognizer){
        println("swiped left")
    }
    
    
    override func didMoveToView(view: SKView) {
        
        var bgImage = SKSpriteNode(imageNamed: "bBackground.jpg")
        self.addChild(bgImage)
        bgImage.position = CGPointMake(self.size.width/2, self.size.height/2)
        
        
        self.backgroundColor = UIColor.whiteColor()
        setupApple()
        
        backButton.position = CGPoint(x: self.size.width * 0.1, y: self.size.height * 0.1)
        backButton.alpha = 1.0//optional
        self.addChild(backButton)
        
        fwdButton.position = CGPoint(x: self.size.width * 0.9, y: self.size.height * 0.1)
        fwdButton.alpha = 1.0//optional
        self.addChild(fwdButton)
        
        homeButton.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.1)
        homeButton.alpha = 1.0//optional
        self.addChild(homeButton)
        
        self.scaleMode = .AspectFill
        
        letterLabel.fontColor = UIColor.redColor()
        letterLabel.fontSize = 260
        letterLabel.position = CGPoint(x: size.width * 0.20, y: size.height * 0.7)
        letterLabel.fontName = "AmericanTypewriter"
        self.addChild(letterLabel)
        
        englishLabel.fontColor = UIColor.redColor()
        englishLabel.fontSize = 40
        englishLabel.position = CGPoint(x: size.width * 0.625, y: size.height * 0.55)
        englishLabel.fontName = "AmericanTypewriter"
        self.addChild(englishLabel)
        
        chineseLabel.fontColor = UIColor.redColor()
        chineseLabel.fontSize = 40
        chineseLabel.position = CGPoint(x: size.width * 0.775, y: size.height * 0.55)
        chineseLabel.fontName = "AmericanTypewriter"
        self.addChild(chineseLabel)
        
        
        
        audioPlayer = AVAudioPlayer(contentsOfURL: ballSound, error: nil)
        audioPlayer.prepareToPlay()
        bitePlayer = AVAudioPlayer(contentsOfURL: biteSound, error: nil)
        bitePlayer.prepareToPlay()
        applePlayer = AVAudioPlayer(contentsOfURL: appleEnglish, error: nil)
        applePlayer.prepareToPlay()
        
        let swipeRight:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: Selector("swipedRight:"))
        swipeRight.direction = .Right
        view.addGestureRecognizer(swipeRight)
        
        let swipeLeft:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: Selector("swipedLeft:"))
        swipeLeft.direction = .Left
        view.addGestureRecognizer(swipeLeft)
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        // Loop over all the touches in this event
        let menu = MenuScene(size: self.size)
        //let animateAction = SKAction.animateWithTextures(self.spriteArray, timePerFrame: 0.20);
        
        let scaleAction = SKAction.scaleTo(2.0, duration: 0.5)
        let shrinkAction = SKAction.scaleTo(1.0, duration: 0.5)
        let scaleThenReverse = SKAction.sequence([scaleAction, shrinkAction])
        
        
        func swipedRight(sender:UISwipeGestureRecognizer){
            println("swiped right")
            let transition = SKTransition.moveInWithDirection(SKTransitionDirection.Left, duration: 0.5)
            self.view?.presentScene(menu, transition: transition)
        }
        
        func swipedLeft(sender:UISwipeGestureRecognizer){
            println("swiped left")
            
        }
        
        for touch: AnyObject in touches {
            // Get the location of the touch in this scene
            let location = touch.locationInNode(self)
            // Check if the location of the touch is within the button's bounds
            if apple.containsPoint(location) {
                apple.runAction(appleBite)
                bitePlayer.play()
                println("you bit me!")
                println("tapped!")
                
            }
            if backButton.containsPoint(location){
                println("Going Back!")
                let transition = SKTransition.moveInWithDirection(SKTransitionDirection.Left, duration: 0.5)
                self.view?.presentScene(menu, transition: transition)
            }
            if englishLabel.containsPoint(location){
                englishLabel.runAction(scaleThenReverse)
                applePlayer.play()
            }
            if letterLabel.containsPoint(location){
                letterLabel.runAction(scaleThenReverse)
            }
            if chineseLabel.containsPoint(location){
                chineseLabel.runAction(scaleThenReverse)
                audioPlayer.play()
            }
        }
    }
    func setupApple(){
        apple = SKSpriteNode(imageNamed: "apple1.png")
        apple.position = CGPoint(x: size.width * 0.70,y: size.height * 0.75)
        self.addChild(apple)
        let atlas = SKTextureAtlas(named: "apple")
        let anim = SKAction.animateWithTextures([
            atlas.textureNamed("apple1"),
            atlas.textureNamed("apple2")
            ], timePerFrame: 0.5)
        appleBite = SKAction.repeatAction(anim, count:1)
        
        
    }
    
    
}
