//
//  FeedVC.swift
//  dev-showcase
//
//  Created by 안수근 on 2016. 2. 13..
//  Copyright © 2016년 ansugeun.k. All rights reserved.
//

import UIKit

class FeedVC: UIViewController ,UITableViewDataSource,UITableViewDelegate{

    @IBOutlet weak var tableView:UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self

    }

    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
        
    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        return tableView.dequeueReusableCellWithIdentifier("PostCell") as! PostCell
    }

}
