//
//  MenuScene.swift
//  ChineseBook
//
//  Created by Chang, Eric on 12/27/14.
//  Copyright (c) 2014 Chang, Eric. All rights reserved.
//

import UIKit
import Spritekit
import AVFoundation

class MenuScene: SKScene {
        var buttonSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("ping2guo3", ofType: "mp3")!)
        var audioPlayer = AVAudioPlayer()
    

        override func didMoveToView(view: SKView) {
        self.backgroundColor = UIColor.whiteColor()
        let label = SKLabelNode(text: "ABC Chinese Book")
        label.fontColor = UIColor.blackColor()
        label.fontSize = 40
        label.position = CGPoint(x: self.size.width / 2.0,y: self.size.height / 2.0)
        self.addChild(label)
        
    }

    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        let game = GameScene(size: self.size)
        let transition = SKTransition.moveInWithDirection(SKTransitionDirection.Right, duration: 0.5)
        self.view?.presentScene(game, transition: transition)
    }
}
