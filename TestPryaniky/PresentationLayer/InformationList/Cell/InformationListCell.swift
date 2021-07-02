//
//  InformationListCell.swift
//  TestPryaniky
//
//  Created by Александр Рублев on 02.07.2021.
//

import UIKit
import Kingfisher

class InformationListCell: UITableViewCell {
    
    static let reuseId = "InformationListCell"

    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(viewModel: InformationListViewModel.Cell) {
        if let imageUrl = viewModel.url {
            KingfisherManager.shared.retrieveImage(with: imageUrl) { [weak self] result in
                switch result {
                case .success(let image):
                    self?.myImageView.image = image.image
                case .failure(let error):
                    print(error.localizedDescription)
                    self?.setPlaceholderImage()
                }
            }
        } else {
            setPlaceholderImage()
        }
        label.text = viewModel.name
    }

    private func setPlaceholderImage() {
        myImageView.image = UIImage(named: "pryaniky")
    }
}
