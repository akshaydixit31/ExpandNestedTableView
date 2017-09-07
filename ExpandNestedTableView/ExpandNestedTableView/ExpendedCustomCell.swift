//
//  ExpendedCustomCell.swift
//  ExpandNestedTableView
//
//  Created by Appinventiv Technologies on 07/09/17.
//  Copyright © 2017 Appinventiv Technologies. All rights reserved.
//

import UIKit

class ExpendedCustomCell: UITableViewCell {
//------------ Outlet's ------------
    @IBOutlet weak var tableViewOnCell: UITableView!
//----------- Variable's -----------
    
    var dataInSection = [""]
    var dataInCell = [""]
    var mpCity = ["Bhopal","Gwalior","Ujjain"]
    var rajCity = ["Ajmer","Alwar","Bikaner","Jaipur"]
    var expandedSections : NSMutableSet = [""]
    var clickOnButton = false
//------------------------------------------
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let headerNib = UINib(nibName: "TableHeader", bundle: nil)  // --Registere Header nib.......
        tableViewOnCell.register(headerNib, forHeaderFooterViewReuseIdentifier: "TableHeaderId")
        let cellNib = UINib(nibName: "CustomCellForCell", bundle: nil)
        tableViewOnCell.register(cellNib, forCellReuseIdentifier: "CustomCellForCellId")   //---Register Cell.......
        tableViewOnCell.dataSource = self
        tableViewOnCell.delegate = self
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
        self.tableViewOnCell.reloadSections([section], with: .automatic)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
//=================== Extension of ExpendedCustomCell ===========
extension ExpendedCustomCell: UITableViewDataSource,UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataInSection.count
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
       guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "TableHeaderId") as? TableHeader else{fatalError("Header not found")}
        header.headerButton.tag = section
        if (expandedSections.contains(section)) {    // ----- for changing button image on click..........
            header.headerUpDownImg.image = UIImage(named: "up")
        } else {
            header.headerUpDownImg.image = UIImage(named: "down")
        }
        header.contentView.backgroundColor = UIColor.cyan
        header.headerButton.setTitle(dataInSection[section], for: .normal)
        header.headerButton.addTarget(self, action: #selector(ViewController.headerButtonAction(sender:)), for: .touchUpInside)
        return header
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(expandedSections.contains(section)) {
            switch section {
            case 0:
                return dataInCell.count
            case 1:
                return mpCity.count
            case 2:
                return rajCity.count
            default :
                return 0
            }
            
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "CustomCellForCellId", for: indexPath) as! CustomCellForCell
        
        switch indexPath.section {
        case 0:
            cell.customCellLabel.text = dataInCell[indexPath.row]
        case 1:
            cell.customCellLabel.text = mpCity[indexPath.row]
        default :
            cell.customCellLabel.text = rajCity[indexPath.row]
        }
        return cell
    }
    
    
}

