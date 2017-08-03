//
//  FirstViewController.swift
//  Perion
//
//  Created by Rasmus Wejlgaard on 03/08/2017.
//  Copyright © 2017 Rasmus Wejlgaard. All rights reserved.
//


import UIKit
import SpriteKit
import GameplayKit

class BubblesViewController: UIViewController {
    
    @IBOutlet weak var bubbleContainer: SKView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let scene = SKScene(fileNamed: "BubblesScene") {
            let scene = PresentBubbles(scene)
            bubbleContainer.presentScene(scene)
        }
        
    }
    
    func PresentBubbles(_ scene: SKScene) -> SKScene {
        let sceneWidth = scene.size.width
        let sceneHeight = scene.size.height
        
        let circle = SKShapeNode(circleOfRadius: 100)
        circle.position = CGPoint(x: 0, y: 0)
        circle.fillColor = SKColor.darkGray
        scene.addChild(circle)
        return scene
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

