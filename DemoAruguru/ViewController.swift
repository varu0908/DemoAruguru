//
//  ViewController.swift
//  DemoAruguru
//
//  Created by Varsha Verma on 09/05/24.
//

import UIKit

class ViewController: UIViewController {
    
     let data = [
        ["id": "MR0001", "isChild": false, "parentid": nil],
        ["id": "MR0002", "isChild": true, "parentid": "MR0001"],
        ["id": "MR0003", "isChild": false, "parentid": nil],
        ["id": "MR0004", "isChild": true, "parentid": "MR0003"],
        ["id": "MR0005", "isChild": true, "parentid": "MR0003"],
        ["id": "MR0006", "isChild": false, "parentid": nil],
        ["id": "MR0007", "isChild": true, "parentid": "MR0006"],
        ["id": "MR0008", "isChild": false, "parentid": nil],
        ["id": "MR0009", "isChild": false, "parentid": nil],
        ["id": "MR0010", "isChild": true, "parentid": "MR0009"]]
    
    
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    var sorteddata = [[String:Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        sorteddata = data.reduce([[String:Any]](), { partialResult, dict in
            var x = partialResult
            let isChild = dict["isChild"] as! Bool
            
            if !isChild{
                x.append(dict)
            }else{
               if let parentIndex = x.firstIndex { xx in
                    return xx["id"] as! String == dict["parentid"] as! String
               }{
                   var parent = x[parentIndex]
                   var parentChild = parent["child"] as? [[String:Any]] ?? []
                   parentChild.append(dict)
                   parent["child"] = parentChild
                   x[parentIndex] = parent
               }
            }
            return x
        }
        )
        print(sorteddata)
    }
}

extension ViewController : UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sorteddata.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let data = sorteddata[section]["child"] as? [[String:Any]] ?? []
        
        return data.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = sorteddata[indexPath.section]["child"] as? [[String:Any]] ?? []
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellP")!
        let lbl = cell.viewWithTag(101) as! UILabel
        let lbl2 = cell.viewWithTag(102) as! UILabel
        lbl.text = "Serial No: \(indexPath.section+1).\(indexPath.row+1)"
        lbl2.text = data[indexPath.row]["id"] as! String
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let data = sorteddata[section]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellP")!
        let lbl = cell.viewWithTag(101) as! UILabel
        let lbl2 = cell.viewWithTag(102) as! UILabel
        lbl.text = "Serial No: \(section+1)"
        lbl2.text = data["id"] as! String
        cell.backgroundColor = UIColor.lightGray
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}
