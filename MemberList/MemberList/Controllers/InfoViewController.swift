//
//  IndfoViewController.swift
//  MemberList
//
//  Created by JinSeok Yang on 2022/10/05.
//

import UIKit
import PhotosUI

final class InfoViewController: UIViewController {
    
    var infoView = InfoView()
    
    var member: Member?
    
    weak var delegate: MemeberDelegate?
    
    
    override func loadView() {
        view = infoView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupButtonAction()
        setupData()
        setupTapGestures()
    }
    
    private func setupData() {
        // didset 동작을 위해서
        infoView.member = member
    }
    
    func setupButtonAction() {
        infoView.saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }
    
    func setupTapGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(touchUpImageView))
        infoView.mainImageView.addGestureRecognizer(tapGesture)
        infoView.mainImageView.isUserInteractionEnabled = true
    }
    
    @objc func touchUpImageView() {
        print(#function)
        setupImagePicker()
    }
    
    
    func setupImagePicker() {
        // 기본설정 셋팅
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = 0
        configuration.filter = .any(of: [.images, .videos])
        
        // 기본설정을 가지고, 피커뷰컨트롤러 생성
        let picker = PHPickerViewController(configuration: configuration)
        // 피커뷰 컨트롤러의 대리자 설정
        picker.delegate = self
        // 피커뷰 띄우기
        self.present(picker, animated: true, completion: nil)
    }
    
    
    @objc func saveButtonTapped() {
        print(#function)
        
        if member == nil {
            
            let name = infoView.nameTextField.text ?? ""
            let age = Int(infoView.ageTextField.text ?? "")
            let phone = infoView.phoneTextField.text ?? ""
            let address = infoView.addressTextField.text ?? ""
            
            // 새로운 멤버 (구조체) 생성
            var newMember =
            Member(name: name, age: age, phone: phone, address: address)
            newMember.memberImage = infoView.mainImageView.image
            
            delegate?.addNewMember(newMember)
            
            
        } else {
            
            member?.memberImage = infoView.mainImageView.image
            
            let memberId = Int(infoView.idTextField.text!) ?? 0
            member!.name = infoView.nameTextField.text
            member!.age = Int(infoView.ageTextField.text!) ?? 0
            member!.phone = infoView.phoneTextField.text ?? ""
            member!.address = infoView.addressTextField.text ?? ""
            
            infoView.member = member
            
            delegate?.update(index: memberId, member!)
            
           
//            let index = navigationController!.viewControllers.count - 2  // count == viewControllers + InfoViewController
//
//            let vc = navigationController?.viewControllers[index] as! ViewController  // navigationController?.viewControllers[0] viewControllers 접근 가능
//
//            vc.memberListManager.updateMemberInfo(index: memberId, member!)
            
            
        }
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
    
}


extension InfoViewController: PHPickerViewControllerDelegate {
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        // 피커뷰 dismiss
        picker.dismiss(animated: true)
        
        let itemProvider = results.first?.itemProvider
        
        if let itemProvider = itemProvider, itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) { (image, error) in
                DispatchQueue.main.async {
                    // 이미지뷰에 표시
                    self.infoView.mainImageView.image = image as? UIImage
                }
            }
        } else {
            print("이미지 못 불러옴!")
        }
    }
    
}
