//
//  ViewController.swift
//  Closer - 2.0
//
//  Created by macbook-estagio on 24/01/20.
//  Copyright © 2020 macbook-estagio. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import Lottie

protocol  LoginControllerDelegate: class{
    func finishLoggingIn(email: String, password: String)
}

class LoginView: UIViewController, UITextFieldDelegate, LoginViewProtocol, LoginControllerDelegate {
    
    var presenter: LoginPresenterProtocol?
    var boolAnimation : Bool?
    let cellID = "cellID"
    let loginCellID = "loginCellID"
    var pageControlBottomAnchor: NSLayoutConstraint?
    var skipButtonTopAnchor: NSLayoutConstraint?
    var nextButtonTopAnchor: NSLayoutConstraint?
    
    lazy var pages : [Page] = {
            let first = Page(title: "Mapa", message: "Aqui será mostrado sua localização atual no mapa, com isso, basta escolher o lugar de sua preferencia e segurar precionado em cima do local, assim sendo redirecionado a tela de Cadastro de Marker", imageName: "pag1")
            let second = Page(title: "Cadastro", message: "Aqui você cadastra algumas informações referente ao local, como foto, nome, telefone, site e categoria que melhor se enquadra o lugar ... Caso não exista uma categoria apropriada basta clicar no mais(+) que será redirecionado a tela de Cadastro de Categoria", imageName: "pag2")
            let third = Page(title: "Cadastro de Categoria", message: "Aqui você descreve o nome da categoria que queira cadastrar e a imagem que melhor a representa...", imageName: "pag3")
            let fourth = Page(title: "Marker Cadastrado", message: "Após ter clicado no botão Cadastrar, retornará ao mapa com o Marker redimensionado no exato local com as devidas informações, podendo ser acessadas ao clicar no 'balãozinho' ... ", imageName: "pag4")
            let fifth = Page(title: "Marker Cadastrado", message: "Ao clicar no menu do marker, aparecerá um 'pop-up' com opções de entrar em contato com o local ...", imageName: "pag5")
            let sixth = Page(title: "Menu", message: "Entre em contato com o local pelo telefone ou site", imageName: "pag6")
            let seventh = Page(title: "Excluíndo Categoria", message: "Ao segurar precisonado em alguma categoria, você estará ativando o modo de exclusão.", imageName: "pag7")
            let eighth = Page(title: "Excluindo Categoria", message: "Depois de ativado o modo de exclusão, basta arrastar o icone da categoria até a lixeira, e, soltar em cima dela, com isso você excluirá todos os markers cadatrados com aquela categoria, e caso não seje uma categoria default, a própria categoria será excluída.", imageName: "pag8")
            return [first, second, third, fourth, sixth, seventh, eighth]
        }()
    
    lazy var splashAnimationView : AnimationView = {
        let animation = AnimationView()
        animation.animation = Animation.named("splash")
        animation.animationSpeed = 0.5
        animation.clipsToBounds = true
        animation.backgroundColor = .clear
        animation.play()
        self.boolAnimation = animation.isAnimationPlaying
        return animation
    }()
    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.isPagingEnabled = true
        return cv
    }()
    lazy var pageControl : UIPageControl = {
        let pg = UIPageControl()
        pg.numberOfPages = self.pages.count
        pg.pageIndicatorTintColor = .lightGray
        pg.currentPageIndicatorTintColor = .yellow
        return pg
    }()
    //MARK: - Buttons to pages
    lazy var buttonSkip : UIButton = {
        let bt = UIButton()
        bt.setBasicButton(title: "SKIP", font: 22, backgroundColor: .clear, tintColor: .white, cornerRadius: 10)
        bt.addTarget(self, action: #selector(skip), for: .touchUpInside)
        return bt
    }()
    @objc func skip() {
        pageControl.currentPage = pages.count - 1
        nextPage()
    }
    lazy var buttonNext : UIButton = {
        let bt = UIButton()
        bt.setBasicButton(title: "NEXT", font: 22, backgroundColor: .clear, tintColor: .white, cornerRadius: 10)
        bt.addTarget(self, action: #selector(nextPage), for: .touchUpInside)
        return bt
    }()
    @objc func nextPage() {
        if pageControl.currentPage == pages.count { return }
        if pageControl.currentPage == pages.count - 1 {
            moveControlConstraintsOfScreen()
        }
        UIView.animate(withDuration: 3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
        let indexPath = IndexPath(item: pageControl.currentPage + 1, section: 0)
        collectionView.scrollToItem(at: indexPath, at: UICollectionView.ScrollPosition.centeredHorizontally, animated: true)
        pageControl.currentPage += 1
    }

    //MARK: - Cycle Life
    override func loadView() {
        super.loadView()
        collectionView.register(PageCell.self, forCellWithReuseIdentifier: cellID)
        collectionView.register(LoginCell.self, forCellWithReuseIdentifier: loginCellID)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Name from device: --> ",UIDevice.current.name)
        
        hideKeyboardTapped()
        observeKeyboardNotification()
        
        LoginWireFrame.createModulo(viewRef: self)
        
        presenter?.viewDidLoad()
    }
    
    //MARK: - Render
    func render() {
        view.backgroundColor = UIColor.backgroundColorGray
        view.addSubviews(viewsToAdd: splashAnimationView)
        splashAnimationView.snp.makeConstraints { (make) in
            make.center.size.equalToSuperview()
        }
        splashAnimationView.play { (boolAnimation) in
            self.splashAnimationView.alpha = 0
//            self.navigationController?.isNavigationBarHidden = false
//            self.navigationItem.title = "Tutorial"
            self.setupViews()
        }
    }
    func setupViews() {
        collectionView.backgroundColor = .clear
        view.addSubviews(viewsToAdd: collectionView, pageControl, buttonNext, buttonSkip)
        collectionView.snp.makeConstraints { (make) in
            make.center.size.equalToSuperview()
        }
        
        pageControlBottomAnchor = pageControl.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: CGFloat.bottomPageControl, rightConstant: 0, widthConstant: 0, heightConstant: CGFloat.margin*4)[1]
        skipButtonTopAnchor = buttonSkip.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, topConstant: CGFloat.margin*5, leftConstant: 0, bottomConstant: 0, rightConstant: 0,
            widthConstant: CGFloat.margin*6, heightConstant: CGFloat.margin*5).first
        nextButtonTopAnchor = buttonNext.anchor(top: view.topAnchor, left: nil, bottom: nil, right: view.rightAnchor, topConstant: CGFloat.margin*5, leftConstant: 0, bottomConstant: 0, rightConstant: 0,
            widthConstant: CGFloat.margin*6, heightConstant: CGFloat.margin*5).first
    }
    
    //MARK: - Logando com VIPER
    func finishLoggingIn(email: String, password: String) {
        print("LoginView --> ",email, password)
//        collectionView.cellForItem(at: <#T##IndexPath#>)
        presenter?.getDataLogIn(email: email, password: password)
    }
    
    func logInMap(value: Bool) {
        if value == true {
            dismiss(animated: true, completion: nil)
        } else {
            if let alerta = Notificacoes().alertaDeLoginErrado() {
                self.present(alerta, animated: true, completion: {
                    print("Chamando Alerta ... ")
                })
            }
        }
    }
    
    //MARK: - keyboard Did Show Notification
    fileprivate func observeKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide), name: UIResponder.keyboardDidHideNotification, object: nil)
    }
    @objc func keyboardShow() {
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.frame = CGRect(x: 0, y: UIScreen.main.bounds.height < 600 ? -150 : -50, width: self.view.frame.width, height: self.view.frame.height)
            self.collectionView.backgroundColor = UIColor.backgroundColorGray7
        }, completion: nil)
    }
    @objc func keyboardHide() {
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
            self.collectionView.backgroundColor = UIColor.backgroundColorGray
        }, completion: nil)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
}

//MARK: - CollectionView Delegates
extension LoginView : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    //MARK: - CollectionView Delegates
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count + 1
    }
    // var oi = "dsadsa"
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.row == pages.count {
            let loginCell = collectionView.dequeueReusableCell(withReuseIdentifier: loginCellID, for: indexPath) as! LoginCell
            loginCell.delegate = self
//            let indexpath = IndexPath(item: 7, section: 0)
//            let cell = collectionView.cellForItem(at: indexPath) as! LoginCell
            
            
            return loginCell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! PageCell
        let page = pages[indexPath.row]
        cell.page = page
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    //MARK: - Funcoes de Scroll
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let pageNumber = Int(targetContentOffset.pointee.x / view.frame.width)
        print("Page Number:", pageNumber)
        pageControl.currentPage = pageNumber
        
        if pageNumber == pages.count {
            moveControlConstraintsOfScreen()
        } else {
            pageControlBottomAnchor?.constant = -CGFloat.margin
            skipButtonTopAnchor?.constant = CGFloat.margin*5
            nextButtonTopAnchor?.constant = CGFloat.margin*5
        }
    
        UIView.animate(withDuration: 2, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    fileprivate func moveControlConstraintsOfScreen() {
//        pageControlBottomAnchor?.constant = CGFloat.margin*5//CGFloat.bottomPageControl
        pageControlBottomAnchor?.constant = UIDevice.current.name == "iPhone 5 Fulltime 2" ? CGFloat.bottomPageControl*5 : CGFloat.bottomPageControl*5
        skipButtonTopAnchor?.constant = -CGFloat.margin*5
        nextButtonTopAnchor?.constant = -CGFloat.margin*5
    }
    
    
}

