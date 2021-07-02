//
//  InformationListViewModel.swift
//  TestPryaniky
//
//  Created by Александр Рублев on 02.07.2021.
//

import Foundation

protocol InformationListViewModelProtocol {
    func getInformationList(completion: @escaping () -> Void)
    func numberOfRows() -> Int
    func cellForRowAt(index: Int) -> InformationListViewModel.Cell
}

final class InformationListViewModel {
    struct Cell {
        let name: String
        let text: String
        let url: URL?
    }
    
    private let service: InformationListServiceable
    private var cells: [Cell]
    
    init(service: InformationListServiceable = InformationListService()) {
        self.service = service
        self.cells = []
    }
    
    private func setupCells(model: InformationListModel) {
        model.view.forEach { [weak self] text in
            if let listModel = model.data.filter({ $0.name == text }).first {
                var text: String = ""
                var url: URL? = nil
                if let variants = listModel.data.variants,
                   let selectedId = listModel.data.selectedId {
                    if let selectedVariant = variants.filter({ $0.id == selectedId }).first {
                        text = selectedVariant.text
                    }
                } else {
                    guard let listText = listModel.data.text else { return }
                    text = listText
                }
                
                if let stringURL = listModel.data.url {
                    url = URL(string: stringURL)
                }
                
                let cell = Cell(name: listModel.name,
                                text: text,
                                url: url)
                self?.cells.append(cell)
            }
        }
    }
}

extension InformationListViewModel: InformationListViewModelProtocol {
    func getInformationList(completion: @escaping () -> Void) {
        service.getInformationList { [weak self] result in
            switch result {
            case .success(let model):
                self?.setupCells(model: model)
                completion()
                print(model)
            case .failure(let error):
                completion()
                print(error.localizedDescription)
            }
        }
    }
    
    func numberOfRows() -> Int {
        return cells.count
    }
    func cellForRowAt(index: Int) -> InformationListViewModel.Cell {
        return cells[index]
    }
}
