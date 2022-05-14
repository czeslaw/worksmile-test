//
//  PathParser.swift
//  worksmile-test
//
//  Created by Piotr Nietrzebka on 14/05/2022.
//

import UIKit
import MapKit

class MasterViewController: UITableViewController {
    var points: [Point]? {
        didSet {
            tableView.reloadData()
            headerView.mapView.removeAnnotations(headerView.mapView.annotations)
            headerView.mapView.addAnnotations(points!)
            headerView.mapView.showAnnotations(points!, animated: true)
        }
    }
    var headerView: HeaderView = {
        let nib = UINib(nibName: "HeaderView", bundle: nil)
        return nib.instantiate(withOwner: self, options: nil).first as! HeaderView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        headerView.scrollView = tableView
        headerView.frame = CGRect(
            x: 0,
            y: tableView.safeAreaInsets.top,
            width: view.frame.width,
            height: 250)

        tableView.backgroundView = UIView()
        tableView.backgroundView?.addSubview(headerView)
        tableView.contentInset = UIEdgeInsets(
            top: 250,
            left: 0,
            bottom: 0,
            right: 0)
        
        guard
             let url = Bundle.main.url(forResource: "path", withExtension: "json")
        else {
            //TODO: show alert
             return
        }
        
        let pointsParser = PointsParser(url: url)
        points = pointsParser.parse()
    }
    
    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()

        tableView.contentInset = UIEdgeInsets(top: 250 + tableView.safeAreaInsets.top,
                                              left: 0,
                                              bottom: 0,
                                              right: 0)
        headerView.updatePosition()
    }
    
//    override func viewWillLayoutSubviews() {
//        super.viewWillLayoutSubviews()
//
//        headerView.updatePosition()
//    }
    
    // MARK: - UIScrollViewDelegate methods

//    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        headerView.updatePosition()
//    }

    // MARK: - UITableViewDataSource methods

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return points?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let point = points?[indexPath.row]
        
        cell.textLabel!.text = point?.latitude;
        return cell
    }
}

