//
//  Model.swift
//  Mart
//
//  Created by Jackeline Pires De Lima on 05/09/22.
//

import Foundation

struct Product {
    let name: String
    let price: String
    let url: String
}

struct SectionHome {
    let type: CategorySections
    let data: Any
}

enum CategorySections: Int, CaseIterable {
    case banner
    case segmentedControl
    case collection
}
