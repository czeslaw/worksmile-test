//
//  PathParser.swift
//  worksmile-test
//
//  Created by Piotr Nietrzebka on 14/05/2022.
//

import UIKit

class DetailViewController: UIViewController {

    var detailDescriptionLabel: UILabel?

    func configureView() {
        if let detail = detailItem {
            if let label = detailDescriptionLabel {
                label.text = detail.description
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
    }

    var detailItem: NSDate? {
        didSet {
            configureView()
        }
    }


}

