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

struct PTask {
    let title : String
    let timeCreated : String
    let dueDate : String
    let importance : String
    init(_title: String, _created : String, _due : String, _importance : String) {
        self.title = _title
        self.timeCreated = _created
        self.dueDate = _due
        self.importance = _importance
    }
}

class BubblesViewController: UIViewController {
    
    @IBOutlet weak var bubbleContainer: SKView!
    
    private var tasks = Array<PTask>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let scene = SKScene(fileNamed: "BubblesScene") {
            let scene = PresentBubbles(scene)
            bubbleContainer.presentScene(scene)
        }
        do {
             let taskArr = LoadTasks()
            
            for task in taskArr {
                print(task)
            }
        } catch {
            print(error)
        }
        
        let task = PTask(_title: "Title!", _created: "2017/29/10", _due: "2017/29/10", _importance: "5")
        print(task)
        
        //let task = PTask(_title: "tit", _created: Date(), _due: Date(), _importance: 5)
        //print(task.title)
        
    }
    
    func LoadTasks() -> Array<PTask> {
        var ret = Array<PTask>()
        
        var json: [Any]?
        do{
            let url = Bundle.main.url(forResource: "data", withExtension: "json")
            let data = try Data(contentsOf: url!)
            
            let obj = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            let dict = obj as? [String: AnyObject]
            
            let projects = dict!["projects"]
            let tasks = dict!["tasks"] as! [[String: String]]
            
            for task in tasks {
                ret.append(PTask(_title: task["title"]!,
                                 _created: task["time_created"]!,
                                 _due: task["due_date"]!,
                                 _importance: task["importance"]!))
            }
            
        }catch{
            LogToUser(message: error as! String)
        }
        
        return ret
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

