//
//  InformationListService.swift
//  TestPryaniky
//
//  Created by Александр Рублев on 02.07.2021.
//

import Foundation

protocol InformationListServiceable {
    func getInformationList(completion: @escaping (Result<InformationListModel, Error>) -> Void)
}

final class InformationListService {
    private let service: NetworkServiceable
    
    init(service: NetworkServiceable = NetworkService()) {
        self.service = service
    }
}

extension InformationListService: InformationListServiceable {
    func getInformationList(completion: @escaping (Result<InformationListModel, Error>) -> Void) {
        service.request(.getInformationList, completion: completion)
    }
}
