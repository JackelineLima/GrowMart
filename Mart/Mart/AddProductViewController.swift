//
//  AddProductViewController.swift
//  Mart
//
//  Created by Jackeline Pires De Lima on 04/10/22.
//

import UIKit

protocol AddProductDisplayable: AnyObject {
    func displaySomething()
}

class AddProductViewController: DefaultViewController {
    
    private lazy var contentView = AddProductView()
    private let viewModel: AddProductViewModelProtocol

    init(viewModel: AddProductViewModelProtocol) {
      self.viewModel = viewModel
      super.init(nibName: nil, bundle: .main)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        contentView.delegate = self
        view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func openGalery() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.allowsEditing = false
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        present(imagePickerController, animated: true)
    }
    
    private func confirmPhotoDeletion(index: Int) {
        
        let confirmAlert = UIAlertController(title: "Atenção", message: "Deseja realmente remover esta foto?", preferredStyle: .alert)
        
        confirmAlert.addAction(.init(title: "OK", style: .default, handler: { [weak self] _ in
            self?.contentView.removePhoto(index)
        }))
        
        confirmAlert.addAction(.init(title: "Cancel", style: .cancel, handler: nil))
        present(confirmAlert, animated: true)
    }
}

extension AddProductViewController: AddProductViewDelegate {
    
    func addProduct(_ product: Product) {
        print("adicionar produtos")
    }
    
    func didTapAddPhotoButton() {
        openGalery()
    }
    
    func didTapPhoto(at index: Int) {
        confirmPhotoDeletion(index: index)
    }

}

extension AddProductViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            dismiss(animated: true)
            return
        }
        
        contentView.addPhoto(image: image)
        dismiss(animated: true)
    }
}
