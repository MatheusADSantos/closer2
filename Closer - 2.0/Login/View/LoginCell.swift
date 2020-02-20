//
//  LoginCell.swift
//  Closer - 2.0
//
//  Created by macbook-estagio on 27/01/20.
//  Copyright © 2020 macbook-estagio. All rights reserved.
//

import UIKit

class LoginCell: UICollectionViewCell {
    
    var email: String? = ""
    var password: String? = ""
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        emailTextField.delegate = self
        passwordTextField.delegate = self
        loadViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let logoImagemView : UIImageView = {
        let image = UIImage(named: "man-user")
        let imageView = UIImageView(image: image)
        return imageView
    }()
    let emailTextField : UITextField = {
        let tf = UITextField()
        tf.setTextField(5, 5, .white, "Enter Email", .black, 20, 0)
        tf.layer.borderColor = UIColor.backgroundColorGray.cgColor
        tf.layer.borderWidth = 1
        tf.keyboardType = .emailAddress
        tf.keyboardAppearance = .alert
        return tf
    }()
    let passwordTextField : UITextField = {
        let tf = UITextField()
        tf.setTextField(5, 5, .white, "Enter Password", .black, 20, 1)
        tf.layer.borderColor = UIColor.backgroundColorGray.cgColor
        tf.layer.borderWidth = 1
        tf.isSecureTextEntry = true
        tf.keyboardType = .emailAddress
        tf.keyboardAppearance = .dark
        return tf
    }()
    lazy var buttonLogin : UIButton = {
        let bt = UIButton()
        bt.setTitle("Log in", for: .normal)
        bt.backgroundColor = .blue
        bt.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return bt
    }()
//    weak var presenter : LoginPresenterProtocol?
    weak var delegate: LoginControllerDelegate?
    @objc func handleLogin() {
        guard let email = email else { return }
        guard let password = password else { return }
        print("Email: ",email,"Senha: ", password)
        delegate?.finishLoggingIn(email: email, password: password)
//        presenter?.getDataLogIn(email: email, password: password)
    }
    
    
    
    //MARK: - Funcoes
    func loadViews() {
        addSubviews(viewsToAdd: logoImagemView, emailTextField, passwordTextField, buttonLogin)
        _ = logoImagemView.anchor(top: centerYAnchor, left: nil, bottom: nil, right: nil, topConstant: -200, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 160, heightConstant: 160)
        logoImagemView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        _ = emailTextField.anchor(top: logoImagemView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 16, leftConstant: 32, bottomConstant: 0, rightConstant: 32, widthConstant: 0, heightConstant: 50)
        _ = passwordTextField.anchor(top: emailTextField.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 16, leftConstant: 32, bottomConstant: 0, rightConstant: 32, widthConstant: 0, heightConstant: 50)
        _ = buttonLogin.anchor(top: passwordTextField.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 32, leftConstant: 32, bottomConstant: 0, rightConstant: 32, widthConstant: 0, heightConstant: 50)
    }
    
}

extension LoginCell : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        dealWithLoginText(textField: textField)
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        dealWithLoginText(textField: textField)
    }
    //MARK: - Tratando LOGIN
    func dealWithLoginText(textField: UITextField) {
        switch textField.tag {
        case 0:
            email = textField.text
        case 1:
            password = textField.text
        default:
            return
        }
        emailTextField.endEditing(true)
        passwordTextField.endEditing(true)
        guard let email = email else { return }
        guard let password = password else { return }
//        delegate?.finishLoggingIn(email: email, password: password)
//        presenter?.getDataLogIn(email: email, password: password)
    }
       
}
