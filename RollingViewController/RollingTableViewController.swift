//
//  RollingTableViewController.swift
//  RollingViewController
//
//  Created by Muronaka Hiroaki on 2017/05/06.
//  Copyright © 2017年 Muronaka Hiroaki. All rights reserved.
//

import UIKit

class RollingTableViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    var headerView: RollingHeaderView!
    var currentDisplayIndexPath:IndexPath!
    var isFirstWillAppear = true
    var currentDipslayCellRect:CGRect = CGRect.zero

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let bundle = Bundle(for: RollingTableViewCell.self)
        let nib = UINib(nibName: "RollingTableViewCell", bundle: bundle)
        self.tableView.register(nib, forCellReuseIdentifier: "RollingTableViewCell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        
        self.headerView = RollingHeaderView.createFromNib()
        self.headerView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 23)
        self.view.addSubview(headerView)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isFirstWillAppear {
            DispatchQueue.main.async {
                self.tableView.scrollToRow(at: self.currentDisplayIndexPath, at: .top, animated: false)
                self.isFirstWillAppear = false
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    var previousDisplayIndex:IndexPath?
    var previousOffset: CGFloat = 0
    var previousY: CGFloat = 0
    var previousImage: UIImage?

}

extension RollingTableViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        print("scrollView: \(scrollView)")
        
        let cellRect = self.tableView.ts_rectFromParent(at: self.currentDisplayIndexPath)
        
        let isDown = (self.tableView.contentOffset.y - previousOffset) > 0
        previousOffset = self.tableView.contentOffset.y
        
        if isDown {
            if cellRect.bottom > 0 && cellRect.bottom < headerView.frame.height {
                self.headerView.frame.origin.y = cellRect.bottom - self.headerView.frame.height
                print("1: ")
            } else if cellRect.bottom < 0 {
                if let nextRow = self.currentDisplayIndexPath.nextRow(numRows: 100) {
                    previousDisplayIndex = self.currentDisplayIndexPath
                    previousImage = self.headerView.headerImageView.image
                    self.currentDisplayIndexPath = nextRow
                    
                    self.headerView.frame.origin.y = 0
                    let cell = self.tableView.cellForRow(at: self.currentDisplayIndexPath)
                    let oldColor = cell?.backgroundColor
                    cell?.backgroundColor = .clear
                    let image = cell!.ts_toImage(opaque: false)
                    cell?.backgroundColor = oldColor
                    let image2 = image.ts_crop(rect: self.headerView.frame)
                    self.headerView.headerImageView.image = image2

                    print("2: \(self.currentDisplayIndexPath.row)")
                } else {
                    print("3: ")
                }
            }
        } else {
            if cellRect.top > 0 && cellRect.top < headerView.frame.height {
                self.headerView.frame.origin.y = cellRect.top - self.headerView.frame.height
                print("1: ")
            } else if cellRect.top >= headerView.frame.height {
                if let previousRow = currentDisplayIndexPath.previousRow() {
                    var cell:UITableViewCell! = self.tableView.cellForRow(at: previousRow)
                    if cell == nil {
                        cell = self.tableView(tableView, cellForRowAt: previousRow)
                    }
                    let oldColor = cell?.backgroundColor
                    cell?.backgroundColor = .clear
                    let image = cell!.ts_toImage(opaque: false)
                    cell?.backgroundColor = oldColor
                    let image2 = image.ts_crop(rect: self.headerView.frame)
                    self.headerView.headerImageView.image = image2
                    print("2: \(self.currentDisplayIndexPath.row)")
                    
                    self.previousDisplayIndex = self.currentDisplayIndexPath
                    self.currentDisplayIndexPath = previousRow
                }
            }
        }
        previousY = cellRect.origin.y
//            print("in header")
//        } else if (cellRect.origin.y - previousY) > 0 && cellRect.origin.y >= 0 && cellRect.origin.y < self.headerView.frame.height {
//            self.headerView.frame.origin.y = -self.headerView.frame.height + cellRect.origin.y
//            self.headerView.headerImageView.image = previousImage
//            print("4: ")
//        } else if cellRect.origin.y < (self.headerView.frame.height) && cellRect.origin.y > 0 {
//            self.headerView.frame.origin.y = cellRect.origin.y - self.headerView.frame.height
//            print("2: ")
//        } else if cellRect.origin.y < 0 {
//            if let previousRow = currentDisplayIndexPath.nextRow(numRows: 100) {
//                previousDisplayIndex = self.currentDisplayIndexPath
//                previousImage = self.headerView.headerImageView.image
//                self.currentDisplayIndexPath = previousRow
//                print("3: ")
//            }
//        }
//             
//            
//        }
//        
//        
//        if previousY >= 0 && cellRect.origin.y <= 0 {
//            if previousDisplayIndex != self.currentDisplayIndexPath {
//                self.headerView.frame.origin.y = 0
//                
//                let cell = self.tableView.cellForRow(at: self.currentDisplayIndexPath)
//                let oldColor = cell?.backgroundColor
//                cell?.backgroundColor = .clear
//                let image = cell!.ts_toImage(opaque: false)
//                cell?.backgroundColor = oldColor
//                let image2 = image.ts_crop(rect: self.headerView.frame)
//                self.headerView.headerImageView.image = image2
//                print("1: ")
//            }
//            print("in header")
//        } else if (cellRect.origin.y - previousY) > 0 && cellRect.origin.y >= 0 && cellRect.origin.y < self.headerView.frame.height {
//            self.headerView.frame.origin.y = -self.headerView.frame.height + cellRect.origin.y
//            self.headerView.headerImageView.image = previousImage
//            print("4: ")
//        } else if cellRect.origin.y < (self.headerView.frame.height) && cellRect.origin.y > 0 {
//            self.headerView.frame.origin.y = cellRect.origin.y - self.headerView.frame.height
//            print("2: ")
//        } else if cellRect.origin.y < 0 {
//            if let previousRow = currentDisplayIndexPath.nextRow(numRows: 100) {
//                previousDisplayIndex = self.currentDisplayIndexPath
//                previousImage = self.headerView.headerImageView.image
//                self.currentDisplayIndexPath = previousRow
//                print("3: ")
//            }
//        }
//        previousY = cellRect.origin.y
    }
    
}


extension RollingTableViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "RollingTableViewCell") as! RollingTableViewCell
        cell.titleLabel.text = "\(indexPath.row)"
        var str = ""
        for _ in 0..<indexPath.row {
            str.append("\(indexPath.row)\n")
        }
        cell.messageLabel.text = str
        return cell
    }
    
}

extension RollingTableViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.tableView.bounds.height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.dismiss(animated: true, completion: nil)
    }
}
