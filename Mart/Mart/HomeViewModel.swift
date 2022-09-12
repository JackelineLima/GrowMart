//
//  HomeViewModel.swift
//  Mart
//
//  Created by Jackeline Pires De Lima on 27/08/22.
//

import Foundation

protocol HomeViewModelProtocol {
    func loadCategory()
    var products: [Product] { get }
    var categoryIndex: Int { get set }
}

class HomeViewModel: HomeViewModelProtocol {
    
    let coordinator: HomeCoordinator
    var categoryIndex: Int
    var products: [Product] = []
    
    private let clothesUrl = "https://fjallraven.vteximg.com.br/arquivos/ids/156206-751-936/F87314620_Camiseta_Masculina_Tornetrask_T-shirt_M_front_1.png"
        private let acessoriesUrl = "https://secure-static.arezzo.com.br/medias/sys_master/arezzo/arezzo/h79/h77/h00/h00/10406142246942/5002305310001U-01-BASEIMAGE-Midres.jpg"
        private let othersUrl = "https://www.mariapiacasa.com.br/media/catalog/product/cache/1/image/0dc2d03fe217f8c83829496872af24a0/t/o/toca-discos-vinil-retro-dallas-classic-35309-1.jpg"
    
    init(coordinator: HomeCoordinator,_ categoryIndex: Int) {
        self.coordinator = coordinator
        self.categoryIndex = categoryIndex
    }
    
    func loadCategory() {
        switch categoryIndex {
        case 0:
            addFakeProducts(name: "Roupas", imageUrl: clothesUrl)
        case 1:
            addFakeProducts(name: "Acessórios", imageUrl: acessoriesUrl)
        case 2:
            addFakeProducts(name: "Outros", imageUrl: othersUrl)
        default:
            break
        }
    }
    
    private func addFakeProducts(name: String, imageUrl: String) {
        products.removeAll()
        for i in 0...10 {
            products.append(.init(name: "\(name) \(i)", price: "R$ 99.00", url: imageUrl))
        }
    }
}
