//
//  InformationListModel.swift
//  TestPryaniky
//
//  Created by Александр Рублев on 02.07.2021.
//

import Foundation

struct InformationListModel: Decodable {
    let data: [ListModel]
    let view: [String]
}

struct ListModel: Decodable {
    let name: String
    let data: ListData
}

struct ListData: Decodable {
    let text: String?
    let url : String?
    let selectedId : Int?
    let variants : [Variant]?
}

struct Variant: Decodable {
    let id: Int
    let text: String
}
