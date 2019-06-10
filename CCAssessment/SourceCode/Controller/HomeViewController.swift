//
//  HomeViewController.swift
//  CCAssessment
//
//  Created by Waseem on 6/7/19.
//  Copyright © 2019 OVRS. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {

    @IBOutlet weak var homeTableView: UITableView!
     var contentArray : [PlistEntityModel]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Home"
        self.loadTableObject()
        LocationService.shared.startTrackingLocation()
        // Do any additional setup after loading the view.
    }
    
    
    func loadTableObject()
    {
        contentArray = PlistEntityModel.getHomeControllerData()
        homeTableView.reloadData()
    }


}

extension HomeViewController:UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contentArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let object: PlistEntityModel = contentArray[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: object.cellidentifier) as! UITableViewCell
        cell.textLabel?.text = object.title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
         let object: PlistEntityModel = contentArray[indexPath.row]
        let homeDetail = self.storyboard?.instantiateViewController(withIdentifier: object.controllerid)
        homeDetail?.title = object.navigationtitle
        self.navigationController?.pushViewController(homeDetail!, animated: true)
        
    }
    
    
}
