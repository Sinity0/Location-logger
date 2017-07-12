//
//  HistoryController.swift
//  LocationLogger
//
//  Created by Niar on 7/11/17.
//  Copyright © 2017 Niar. All rights reserved.
//

import UIKit
import Foundation

class HistoryController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    private var tableArray = [AnyObject]()
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableArray = CoreDataManager.sharedInstance.fetchTokens()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableArray.count
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: HistoryCell = tableView.dequeueReusableCell(withIdentifier: Utils.stringFromClassName(obj: HistoryCell.self), for: indexPath) as! HistoryCell
        let location: Locations = tableArray[indexPath.row] as! Locations
        
        cell.lblDate.text = Utils.formatDate(date: location.date as! Date)
        cell.lblLocation.text = location.city! + " Latitude: " + String(location.latitude) + " Longitude" + String(location.longitude)

        return (cell)
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let location: Locations = tableArray[indexPath.row] as! Locations
        pushUIView(identifier: Utils.stringFromClassName(obj: DetailsController.self), data: location)
    }
    
    func pushUIView(identifier: String,  data: Locations){
        let detailsController : DetailsController = storyboard?.instantiateViewController(withIdentifier: identifier) as! DetailsController
        detailsController.populateWithData(data: data)
        self.navigationController?.pushViewController(detailsController, animated: true)
    }
}
