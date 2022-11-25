//
//  InfoView.swift
//  MemberList
//
//  Created by JinSeok Yang on 2022/10/04.
//

import UIKit

final class InfoView: UIView {
    
    
    
    var member: Member? {
        didSet {
            guard var member = member else {
                saveButton.setTitle("SAVE", for: .normal)
                idTextField.text = "\(Member.memberNumbers)"
                return
            }
            
            mainImageView.image = member.memberImage
            idTextField.text = "\(member.memberId)"
            nameTextField.text = member.name
            phoneTextField.text = member.phone
            addressTextField.text = member.address
            
            guard let age = member.age else {
                ageTextField.text = ""
                return
            }
            ageTextField.text = "\(age)"
            
            //ageTextField.text = member.age != nil ? "\(member.age!)" : ""
            
        }
    }
    
    // MARK: - UI
    
    let mainImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 75
        image.clipsToBounds = true
        image.backgroundColor = .lightGray
        return image
    }()
    // 이미지 정렬을 위한 뷰
    lazy var imageContainView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mainImageView)
        return view
    }()

    // MARK: - ID UI
    
    let idLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16)
        label.text = "멤버번호:"
        return label
    }()
    
    let idTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.frame.size.height = 22
        tf.borderStyle = .roundedRect                  // 테두리 스타일
        tf.returnKeyType = .done                       // 키보드 엔터키(return, done... )
        tf.autocorrectionType = .no
        tf.spellCheckingType = .no
        tf.clearsOnBeginEditing = false
        tf.textColor = .black
        tf.borderStyle = .roundedRect
        return tf
    }()
    
    lazy var idStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [idLabel, idTextField])
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.spacing = 5
        sv.axis = .horizontal
        sv.distribution = .fill
        sv.alignment = .fill
        return sv
    }()
    
    // MARK: - Name UI
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16)
        label.text = "이       름:"
        return label
    }()
    
    let nameTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.frame.size.height = 22
        tf.keyboardType = UIKeyboardType.default  // 키보드 타입
        tf.borderStyle = .roundedRect                  // 테두리 스타일
        tf.clearButtonMode = .always                   // 입력내용 한번에 지우는 x버튼(오른쪽)
        tf.returnKeyType = .done                       // 키보드 엔터키(return, done... )
        tf.becomeFirstResponder()                      // 화면에서 첫번째로 반응(포커스 시킴)
        tf.autocorrectionType = .no
        tf.spellCheckingType = .no
        tf.clearsOnBeginEditing = false
        tf.textColor = .black
        tf.borderStyle = .roundedRect
        return tf
    }()
    
    lazy var nameStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [nameLabel, nameTextField])
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.spacing = 5
        sv.axis = .horizontal
        sv.distribution = .fill
        sv.alignment = .fill
        return sv
    }()
    
    // MARK: - AGE UI
    
    let ageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16)
        label.text = "나       이:"
        return label
    }()
    
    let ageTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.frame.size.height = 22
        tf.keyboardType = UIKeyboardType.default  // 키보드 타입
        tf.borderStyle = .roundedRect                  // 테두리 스타일
        tf.clearButtonMode = .always                   // 입력내용 한번에 지우는 x버튼(오른쪽)
        tf.returnKeyType = .done                       // 키보드 엔터키(return, done... )
        tf.becomeFirstResponder()                      // 화면에서 첫번째로 반응(포커스 시킴)
        tf.autocorrectionType = .no
        tf.spellCheckingType = .no
        tf.clearsOnBeginEditing = false
        tf.textColor = .black
        tf.borderStyle = .roundedRect
        return tf
    }()
    
    lazy var ageStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [ageLabel, ageTextField])
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.spacing = 5
        sv.axis = .horizontal
        sv.distribution = .fill
        sv.alignment = .fill
        return sv
    }()
    
    // MARK: - Phone UI
    
    let phoneLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16)
        label.text = "전화번호:"
        return label
    }()
    
    let phoneTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.frame.size.height = 22
        tf.keyboardType = UIKeyboardType.default  // 키보드 타입
        tf.borderStyle = .roundedRect                  // 테두리 스타일
        tf.clearButtonMode = .always                   // 입력내용 한번에 지우는 x버튼(오른쪽)
        tf.returnKeyType = .done                       // 키보드 엔터키(return, done... )
        tf.becomeFirstResponder()                      // 화면에서 첫번째로 반응(포커스 시킴)
        tf.autocorrectionType = .no
        tf.spellCheckingType = .no
        tf.clearsOnBeginEditing = false
        tf.textColor = .black
        tf.borderStyle = .roundedRect
        return tf
    }()
    
    lazy var phoneStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [phoneLabel, phoneTextField])
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.spacing = 5
        sv.axis = .horizontal
        sv.distribution = .fill
        sv.alignment = .fill
        return sv
    }()
    
    // MARK: - ADDRESS
    
    let addressLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16)
        label.text = "주       소:"
        return label
    }()
    
    let addressTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.frame.size.height = 22
        tf.keyboardType = UIKeyboardType.default  // 키보드 타입
        tf.borderStyle = .roundedRect                  // 테두리 스타일
        tf.clearButtonMode = .always                   // 입력내용 한번에 지우는 x버튼(오른쪽)
        tf.returnKeyType = .done                       // 키보드 엔터키(return, done... )
        tf.becomeFirstResponder()                      // 화면에서 첫번째로 반응(포커스 시킴)
        tf.autocorrectionType = .no
        tf.spellCheckingType = .no
        tf.clearsOnBeginEditing = false
        tf.textColor = .black
        tf.borderStyle = .roundedRect
        return tf
    }()
    
    lazy var addressStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [addressLabel, addressTextField])
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.spacing = 5
        sv.axis = .horizontal
        sv.distribution = .fill
        sv.alignment = .fill
        return sv
    }()
    
    // MARK: - BUTTON UI
    
    var saveButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.frame.size.height = 40
        btn.setTitle("UPDATE", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .systemBlue
        return btn
    }()
    
    // MARK: - STACKVIEW UI
    
    lazy var stavkView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [imageContainView, idStackView, nameStackView, ageStackView, phoneStackView, addressStackView, saveButton])
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.spacing = 10
        sv.axis = .vertical
        sv.distribution = .fill
        sv.alignment = .fill
        return sv
    }()
    
    // MARK: - 레이블 크기
    
    let labelWidth: CGFloat = 70
    
    // 애니메이션을 위한 속성
    var stackViewTopCOnstraint: NSLayoutConstraint!
    
    // MARK: - 초기화
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setupAddViews()
        setupIdTextfield()
        setupNotification()
    }
    
    func setupAddViews() {
        self.addSubview(stavkView)
    }
    
    func setupIdTextfield() {
        idTextField.delegate = self
        nameTextField.delegate = self
        ageTextField.delegate = self
        phoneTextField.delegate = self
        addressTextField.delegate = self
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - notification
    
    func setupNotification() {
        // default 싱글톤의 형태
        NotificationCenter.default.addObserver(self, selector: #selector(moveUpAction), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(moveDownAction), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        
        
    }

    
    // MARK: - SETUP CONSTRAINTS
    
    override func updateConstraints() {
        setupConstraints()
        super.updateConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            mainImageView.heightAnchor.constraint(equalToConstant: 150),
            mainImageView.widthAnchor.constraint(equalToConstant: 150),
            mainImageView.centerXAnchor.constraint(equalTo: imageContainView.centerXAnchor),
            mainImageView.centerYAnchor.constraint(equalTo: imageContainView.centerYAnchor),
        ])
        
        NSLayoutConstraint.activate([
            imageContainView.heightAnchor.constraint(equalToConstant: 180)
        ])
        
        NSLayoutConstraint.activate([
            idLabel.widthAnchor.constraint(equalToConstant: labelWidth),
            nameLabel.widthAnchor.constraint(equalToConstant: labelWidth),
            ageLabel.widthAnchor.constraint(equalToConstant: labelWidth),
            phoneLabel.widthAnchor.constraint(equalToConstant: labelWidth),
            addressLabel.widthAnchor.constraint(equalToConstant: labelWidth),
        ])
        
        stackViewTopCOnstraint = stavkView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10)
        
        NSLayoutConstraint.activate([
            stackViewTopCOnstraint,
            stavkView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            stavkView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            stavkView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
        ])
    }
    
    // MARK: - 텍스트필드 다음으로
    
    func switchBasedNextTextField(_ textField: UITextField) {
        switch textField {
        case self.nameTextField:
            self.ageTextField.becomeFirstResponder()
        case self.ageTextField:
            self.phoneTextField.becomeFirstResponder()
        case self.phoneTextField:
            self.addressTextField.becomeFirstResponder()
        case self.addressTextField:
            self.addressTextField.resignFirstResponder()
        default:
            break
        }
        
    }
    
    // MARK: - 오토레이아웃 애니메이션
    
    @objc func moveUpAction() {
        stackViewTopCOnstraint.constant = -10
        UIView.animate(withDuration: 0.2) {
            self.layoutIfNeeded()
        }
    }
    
    @objc func moveDownAction() {
        stackViewTopCOnstraint.constant = 10
        UIView.animate(withDuration: 0.2) {
            self.layoutIfNeeded()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.endEditing(true)
    }
    
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
}

extension InfoView: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == idTextField {
            return false
        }
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.switchBasedNextTextField(textField)
        return false
    }
    
}
