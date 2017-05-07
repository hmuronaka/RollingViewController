//
//  ViewController.swift
//  RollingViewController
//
//  Created by Muronaka Hiroaki on 2017/05/06.
//  Copyright © 2017年 Muronaka Hiroaki. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let bundle = Bundle(for: SampleTableViewCell.self)
        let nib:UINib = UINib(nibName: "SampleTableViewCell", bundle: bundle)
        self.tableView.register(nib, forCellReuseIdentifier: "SampleTableViewCell")
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SampleTableViewCell") as! SampleTableViewCell
        cell.titleLabel.text = "\(indexPath.row)"
        
        var str = ""
        for _ in 0..<indexPath.row {
            str.append("\(indexPath.row)\n")
        }
        cell.messageLabel.text = str
        return cell
    }
    
}


extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = RollingTableViewController(nibName: "RollingTableViewController", bundle: nil)
        vc.currentDisplayIndexPath = indexPath
        self.present(vc, animated: true, completion: nil)
    }
}
