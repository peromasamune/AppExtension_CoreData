//
//  ViewController.swift
//  AppExtensiton_CoreData
//
//  Created by Taku Inoue on 2015/12/09.
//  Copyright (c) 2015年 Taku Inoue. All rights reserved.
//

import UIKit
import ACFramework

private let CellIdentifier : String = "Cell"

class ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    // MARK: - Properties
    // MARK: Private
    private var tableView: UITableView!
    private var dataArray : Array<ACMemoEntity> = Array()

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        tableView = UITableView(frame: self.view.bounds)
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)

        let plusButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "plusButtonDidPush:")
        self.navigationItem.rightBarButtonItem = plusButton

        self.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Private Method
    private func reloadData(){
        dataArray = ACDataManager.getMemo()
        tableView.reloadData()
    }

    private func stringFromTimeInterval(interval : NSTimeInterval) -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "US")
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        let dateString = dateFormatter.stringFromDate(NSDate(timeIntervalSince1970: interval))
        return dateString
    }

    // MARK: - Button Action
    @objc private func plusButtonDidPush(sender : AnyObject?){
        ACDataManager.createMemo("title")
        self.reloadData()
    }

    // MARK: - UITableViewDataSource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell : UITableViewCell? = tableView.dequeueReusableCellWithIdentifier(CellIdentifier) as? UITableViewCell
        if (cell == nil) {
            cell = UITableViewCell(style: .Subtitle, reuseIdentifier: CellIdentifier)
        }

        let memo : ACMemoEntity = dataArray[indexPath.row]
        cell!.textLabel?.text = memo.title
        cell!.detailTextLabel?.text = self.stringFromTimeInterval(memo.date)

        return cell!
    }

    // MARK: - UITableViewDelegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

    }
}

