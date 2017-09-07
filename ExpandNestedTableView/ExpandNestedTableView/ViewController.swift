//
//  ViewController.swift
//  ExpandNestedTableView
//
//  Created by Appinventiv Technologies on 07/09/17.
//  Copyright © 2017 Appinventiv Technologies. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
//--------------- Outlet's -------------------
    @IBOutlet weak var nestedTableView: UITableView!
    //--------------- Structure's ----------------
    
        var countryArray = ["India"]
        var stateArray = ["UP","MP","Rajisthan"]
        var cityArray = ["Agra","Aligarh","Greater Noida","Lucknow","Mathura","Noida"]
        var expandedSections : NSMutableSet = [""]
        var clickOnButton = false
//--------------- Variable's -----------------
    
  
//--------------- ViewDidLoad ----------------
    override func viewDidLoad() {
        super.viewDidLoad()
        let headerNib = UINib(nibName: "TableHeader", bundle: nil)  // --Registere Header nib.......
        nestedTableView.register(headerNib, forHeaderFooterViewReuseIdentifier: "TableHeaderId")
        let cellNib = UINib(nibName: "ExpendedCustomCell", bundle: nil)
        nestedTableView.register(cellNib, forCellReuseIdentifier: "ExpendedCustomCellId")   //---Register Cell.......
        
        
        
//-------------------------
        nestedTableView.dataSource = self
        nestedTableView.delegate = self
// -------- Assigning data in structure ------
        
    }
    //--------- Function for action on header button ----------
    @objc func headerButtonAction(sender: UIButton){
        let section = sender.tag
        let shouldExpand = !expandedSections.contains(section)
        if (shouldExpand) {
            expandedSections.add(section)
        } else {
            expandedSections.remove(section)
        }
        self.nestedTableView.reloadSections([section], with: .automatic)
        
    }

   

}
//===================== Extension of ViewController ================
extension ViewController: UITableViewDataSource,UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
       return countryArray.count
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "TableHeaderId") as? TableHeader else{fatalError("Header not found")}
       
        header.headerButton.tag = section
        if (expandedSections.contains(section)) {    // ----- for changing button image on click..........
            header.headerUpDownImg.image = UIImage(named: "up")
        } else {
            header.headerUpDownImg.image = UIImage(named: "down")
        }
         header.contentView.backgroundColor = UIColor.orange
        header.headerButton.setTitle(countryArray[section], for: .normal)
        header.headerButton.addTarget(self, action: #selector(ViewController.headerButtonAction(sender:)), for: .touchUpInside)
        return header
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 2
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 600
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(expandedSections.contains(section)) {
            switch section {
            case 0:
                return 1
            default :
                return 0
            }
            
        }else{
            return 0
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      guard let cell = tableView.dequeueReusableCell(withIdentifier: "ExpendedCustomCellId", for: indexPath) as? ExpendedCustomCell else{fatalError("Cell not found")}
        cell.dataInSection = stateArray
        cell.dataInCell = cityArray
      return cell
    }
    
    
}













