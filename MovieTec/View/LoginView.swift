//
//  LoginView.swift
//  MovieTec
//
//  Created by Furry Ruiz on 24/02/23.
//

import UIKit

class LoginView: UIView, UITextFieldDelegate {
    private var viewModel: LoginViewModel
    private let usernameTF = UITextField()
    private let passwordTF = UITextField()
    private var btnLogin = UIButton(type: .system)
    private var logoImg = UIImageView()
    private let invalidLabel = UILabel()
    private let moviesVC = MoviesViewController()
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIView.endEditing))
        self.addGestureRecognizer(tap)
        
        self.setup()
        self.styleViews()
        self.setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        self.addSubview(self.logoImg)
        self.addSubview(self.usernameTF)
        self.addSubview(self.passwordTF)
        self.addSubview(self.btnLogin)
        self.addSubview(self.invalidLabel)
        self.moviesVC.modalPresentationStyle = .fullScreen
        self.invalidLabel.isHidden = true
        self.btnLogin.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
    }
    
    @objc func didTapButton(_ sender: UIButton) {
        //self.invalidLabel.isHidden = false
        //self.window?.rootViewController?.present(moviesVC, animated: true)
        self.window?.rootViewController = UINavigationController(rootViewController: moviesVC)
        self.window?.rootViewController?.present(moviesVC, animated: true)
    }
    
    func styleViews(){
        self.backgroundColor = #colorLiteral(red: 0.01176470588, green: 0.1450980392, blue: 0.2549019608, alpha: 1)
        self.logoImg.image = #imageLiteral(resourceName: "Logo")
        self.logoImg.clipsToBounds = true
        self.logoImg.translatesAutoresizingMaskIntoConstraints = false
        styleTF(self.usernameTF, pHolder: "Username")
        styleTF(self.passwordTF, pHolder: "Password")
        styleBtn(self.btnLogin, title: "Login")
        self.invalidLabel.textColor = .systemRed
        self.invalidLabel.font = .boldSystemFont(ofSize: UIFont.systemFontSize)
        self.invalidLabel.numberOfLines = 2
        self.invalidLabel.textAlignment = .center
        self.invalidLabel.text = "Invalid username and/or password.\nYou did not provide a valid login."
        self.invalidLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func styleTF(_ txtField: UITextField, pHolder: String){
        txtField.backgroundColor = .white
        txtField.placeholder = pHolder
        txtField.borderStyle = .roundedRect
        txtField.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func styleBtn(_ btn: UIButton, title: String) {
        btn.backgroundColor = .gray
        btn.setTitle(title, for: .normal)
        btn.tintColor = .white
        btn.layer.cornerRadius = 2
        btn.clipsToBounds = true
        btn.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupBindings() {
        
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            self.logoImg.bottomAnchor.constraint(equalTo: self.usernameTF.topAnchor, constant: -50),
            self.logoImg.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.logoImg.widthAnchor.constraint(equalToConstant: 200),
            self.logoImg.heightAnchor.constraint(equalToConstant: 200)
        ])
        NSLayoutConstraint.activate([
            self.usernameTF.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.usernameTF.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 50),
            self.usernameTF.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -50),
            self.usernameTF.heightAnchor.constraint(equalToConstant: 40)
        ])
        NSLayoutConstraint.activate([
            self.passwordTF.topAnchor.constraint(equalTo: self.usernameTF.bottomAnchor, constant: 20),
            self.passwordTF.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 50),
            self.passwordTF.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -50),
            self.passwordTF.heightAnchor.constraint(equalToConstant: 40)
        ])
        NSLayoutConstraint.activate([
            self.btnLogin.topAnchor.constraint(equalTo: self.passwordTF.bottomAnchor, constant: 20),
            self.btnLogin.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 50),
            self.btnLogin.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -50),
            self.btnLogin.heightAnchor.constraint(equalToConstant: 40)
        ])
        NSLayoutConstraint.activate([
            self.invalidLabel.topAnchor.constraint(equalTo: self.btnLogin.bottomAnchor, constant: 10),
            self.invalidLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 50),
            self.invalidLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -50),
        ])
    }
}
