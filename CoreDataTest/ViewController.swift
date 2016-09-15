//
//  ViewController.swift
//  CoreDataTest
//
//  Created by student3 on 9/15/16.
//  Copyright © 2016 John Hersey High School. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var label: UILabel!
    
    
    var appDel: AppDelegate = AppDelegate()
    var context: NSManagedObjectContext = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.MainQueueConcurrencyType)

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        appDel = UIApplication.sharedApplication().delegate as! AppDelegate
        context = appDel.managedObjectContext
        
        let request = NSFetchRequest(entityName: "Entity")
        request.resultType = NSFetchRequestResultType.DictionaryResultType
        
        var results: [AnyObject]?
        
        do
        {
            results = try context.executeFetchRequest(request)
        } catch _ {
            results = nil
        }
        
        if results?.count > 0 {
            let string1 = results?.last?.valueForKey("name")! as? NSString
            label.text = "\(string1!)"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func savenButton(sender: UIButton) {
        let name = textField.text
        let new = NSEntityDescription.insertNewObjectForEntityForName("Entity", inManagedObjectContext: context) as NSManagedObject
        new.setValue(textField.text, forKey: "name")
        
        do {
            
            label.text = name

            try context.save()
        }
        catch _ {
            
        }
    }
}

