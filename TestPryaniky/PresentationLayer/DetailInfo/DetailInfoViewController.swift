//
//  DetailInfoViewController.swift
//  TestPryaniky
//
//  Created by Александр Рублев on 02.07.2021.
//

import UIKit

final class DetailInfoViewController: UIViewController {
    
    var viewModel: DetailInfoViewModel?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let viewModel = self.viewModel {
            titleLabel.text = viewModel.titleText
            descriptionLabel.text = viewModel.descriptionText
        }
    }
}

