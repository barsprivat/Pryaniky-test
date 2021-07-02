//
//  InformationListViewController.swift
//  TestPryaniky
//
//  Created by Александр Рублев on 02.07.2021.
//

import UIKit

final class InformationListViewController: UITableViewController {
    private var selectedIndex: Int?
    
    var viewModel: InformationListViewModelProtocol = InformationListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getInformationList { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? DetailInfoViewController,
           let index = selectedIndex {
            let cellViewModel = viewModel.cellForRowAt(index: index)
            viewController.viewModel = DetailInfoViewModel(titleText: cellViewModel.name,
                                                           descriptionText: cellViewModel.text)
        }
    }
}

extension InformationListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: InformationListCell.reuseId, for: indexPath) as? InformationListCell else { return UITableViewCell() }
        
        let cellViewModel = viewModel.cellForRowAt(index: indexPath.row)
        cell.setupCell(viewModel: cellViewModel)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        performSegue(withIdentifier: "detailSegue", sender: nil)
    }
}
