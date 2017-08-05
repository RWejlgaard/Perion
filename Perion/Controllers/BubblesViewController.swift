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
    
    @IBOutlet weak var bubbleContainer: SKView!
    
    private var tasks = Array<PTypes.PTask>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let tasksCollection: Array<PTypes.PTask> = LoadTasks() else {
            LogToUser(message: "Couldn't load tasks")
        }
        
        if let scene = SKScene(fileNamed: "BubblesScene") {
            let scene = PresentBubbles(scene: scene, tasks: tasksCollection)
            bubbleContainer.presentScene(scene)
        }
        
        
    }
    
    func LoadTasks() -> Array<PTypes.PTask> {
        var ret = Array<PTypes.PTask>()
        
        var json: [Any]?
        do{
            let url = Bundle.main.url(forResource: "data", withExtension: "json")
            let data = try Data(contentsOf: url!)
            
            let obj = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            let dict = obj as? [String: AnyObject]
            
            let projects = dict!["projects"]
            let tasks = dict!["tasks"] as! [[String: String]]
            
            for task in tasks {
                ret.append(PTypes.PTask(_title: task["title"]!,
                                 _created: task["time_created"]!,
                                 _due: task["due_date"]!,
                                 _importance: task["importance"]!))
            }
            
        }catch{
            LogToUser(message: error as! String)
        }
        
        return ret
    }
    
    func PresentBubbles(scene: SKScene, tasks: Array<PTypes.PTask>) -> SKScene {
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

