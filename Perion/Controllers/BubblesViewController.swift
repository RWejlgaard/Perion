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
import JSON
import JSONJoy



class BubblesViewController: UIViewController {
    
    struct PTask {
        let title : String?
        let timeCreated : Date?
        let dueDate : Date?
        let importance : Int?
        init() {
            
        }
    }
    
    struct PTask : JSONJoy {
        let title : String
        let timeCreated : Date
        let dueDate : Date
        let importance : Int
        init(_ decoder : JSONDecoder) throws {
            title = try decoder["title"].get()
            timeCreated = try Date(decoder["time_created"])
            dueDate = try Date(decoder["due_date"])
            importance = Int(decoder["importance"])
        }
    }
    
    
    @IBOutlet weak var bubbleContainer: SKView!
    
    private var tasksJson : Any?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let scene = SKScene(fileNamed: "BubblesScene") {
            let scene = PresentBubbles(scene)
            bubbleContainer.presentScene(scene)
        }
        
        //let task = PTask(_title: "tit", _created: Date(), _due: Date(), _importance: 5)
        //print(task.title)
        
        
        do {
            self.tasksJson = try JSON.from("tasks.json")
            print(tasksJson)
        }catch {
            LogToUser(message: "Unable to get tasks")
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
    
    func LogToUser(message: String) -> Void {
        print("ERROR: " + message)
        //let alert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertControllerStyle.alert)
        //alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        //bubbleContainer.present(alert, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

