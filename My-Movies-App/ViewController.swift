//
//  ViewController.swift
//  My-Movies-App
//
//  Created by Adam Dostalik on 2/19/16.
//  Copyright © 2016 Adam Dostalik. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        
        tableView!.delegate = self
        tableView!.dataSource = self
        
        tableView.reloadData()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        addLogo()
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MovieCell")
        return cell!
    }

    func addLogo() {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 55))
        imageView.contentMode = .ScaleAspectFit
        // 4
        let image = UIImage(named: "MyMovies.png")
        imageView.image = image
        // 5
        navigationItem.titleView = imageView
        
    }
    
}

