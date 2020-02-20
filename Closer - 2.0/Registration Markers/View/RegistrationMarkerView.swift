//
//  RegistrationMarkerView.swift
//  Closer - 2.0
//
//  Created by macbook-estagio on 04/02/20.
//  Copyright © 2020 macbook-estagio. All rights reserved.
//

import UIKit

class RegistrationMarkerView : UIViewController, RegistrationMarkerViewProtocol {
    
    var presenter: RegistrationMarkerPresenterProtocol?
    var categories : [Categorys] = {
        let categories = UserDefaults.standard.data(forKey: "categoriesDefault")
        let decoder = JSONDecoder()
        let dataDecode = try! decoder.decode([Categorys].self, from: categories!)

        return dataDecode
    }()
//    static var categories : [CategorysDefault] = MapView.
    var descricao = String()
    var telefone = String()
    var site = String()
    fileprivate let cellID = "cellID"
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        RegistrationMarkerWireFrame.createModule(viewRef: self)
        presenter?.viewDidLoad()
    }
    
    //MARK: - Componentização
    let viewToPhoto : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.backgroundColorGray2
        
        if #available(iOS 11.0, *) {
            view.layer.cornerRadius = 10
            view.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        } else {
            // Fallback on earlier versions
            print("Versão IOS Inferior ao 11 ... NÃO DA PARA USAR O MASK ...")
        }
        return view
    }()
    let imageViewPhoto : UIImageView = {
        let view = UIImageView()
//        view.layer.masksToBounds = true
        view.backgroundColor = .white
        view.layer.borderColor = UIColor().hexaToColor(hex: "fff").cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = CGFloat.Constants.sizeImagePhoto/2
        view.setShadow(alpha: 1, offSetX: 2, offSetY: 2, shadowOpacity: 1, shadowRadius: 2, boolean: true)
        
        return view
    }()
    let textFieldDesc : UITextField = {
        let textField = UITextField()
        let raio = CGFloat.heigthComponent/2
        textField.setTextField(raio, raio, .white, "Nome do lugar", .black, 25, 0)
        return textField
    }()
    let textFieldPhone : UITextField = {
        let textField = UITextField()
        let raio = CGFloat.heigthComponent/2
        textField.setTextField(raio, raio, .white, "Telefone do lugar", .black, 25, 1)
        return textField
    }()
    let textFieldSite : UITextField = {
        let textField = UITextField()
        let raio = CGFloat.heigthComponent/2
        textField.setTextField(raio, raio, .white, "Site do lugar", .black, 25, 2)
        return textField
    }()
    lazy var tableViewCategories : UITableView = {
        let tb = UITableView()
        tb.layer.cornerRadius = CGFloat.heigthComponent/2
        return tb
    }()
    //MARK: - BUTTON TO TURN ON CAMERA
    lazy var buttonPhoto : UIButton = {
        let button = UIButton()
        button.setImage(UIImage.init(named: "camera"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 9, left: 9, bottom: 9, right: 9)
        button.backgroundColor = .white
        button.layer.cornerRadius = .heigthComponent/2
        button.setShadow(alpha: 1, offSetX: -1, offSetY: 1, shadowOpacity: 0.95, shadowRadius: 2 , boolean: true)
        button.addTarget(self, action: #selector(showOptionsMenuToAccessCamera(sender:)), for: .touchUpInside)
        return button
    }()
    @objc func showOptionsMenuToAccessCamera(sender:UIButton) {
        let menu = Notificacoes().menuDeOpcoes { (opcao) in
            let multimidia = UIImagePickerController()
                multimidia.delegate = self
                
                if opcao == .camera && UIImagePickerController.isSourceTypeAvailable(.camera) {
                    multimidia.sourceType = .camera
                } else {
                    multimidia.sourceType = .photoLibrary
                }
                self.present(multimidia, animated: true, completion: nil)
            }
        self.present(menu, animated: true, completion: nil)
        }

    
    //MARK: - BUTTON TO ADD ANOTHER CATEGORIE
    let buttonToAddANewCategory : UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.backgroundColorGray
        button.layer.cornerRadius = .heigthComponent/2
        button.setImage(UIImage.init(named: "plus"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        button.setShadow(alpha: 1, offSetX: -1, offSetY: 1, shadowOpacity: 0.95, shadowRadius: 2 , boolean: true)
        button.addTarget(self, action: #selector(goToRegisterNewCategory), for: .touchUpInside)
        return button
    }()
    @objc func goToRegisterNewCategory() {
        print("Chamando o presenter para transição de tela para tela de Cadastro Categoria")
        presenter?.wireframe?.goToRegistrationCategories(categories: categories)
    }
    //MARK: - BUTTON TO REGISTER IN BANK
    lazy var buttonRegister : UIButton = {
        let edgesInsetSides = CGFloat.calculateEdgesInsetSides()
        
        let button = UIButton()
        button.backgroundColor = .blue
        button.setImage(UIImage.init(named: "save"), for: .normal)
        button.layer.cornerRadius = CGFloat.heigthComponent/2
        button.imageEdgeInsets = UIEdgeInsets(top: 5, left: edgesInsetSides, bottom: 5, right: edgesInsetSides)
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(registeringCustomMarker(sender:)), for: .touchUpInside)
        return button
    }()
    @objc func registeringCustomMarker(sender:UIButton) {
        self.textFieldDesc.endEditing(true)
        self.textFieldPhone.endEditing(true)
        self.textFieldSite.endEditing(true)
//        guard let descricao = textFieldDesc.text else {return}
        
//        presenter?.registerMarker(dictionary:getDictionary(), descricao:self.descricao!, telefone: self.telefone!, site: self.site!, view: self)
        
    }
    
    func render() {
        view.backgroundColor = UIColor.backgroundColorGray
        view.addSubviews(viewsToAdd: viewToPhoto, imageViewPhoto, textFieldDesc, textFieldPhone, textFieldPhone, textFieldSite, tableViewCategories, buttonPhoto, buttonToAddANewCategory, buttonRegister)
        
        viewToPhoto.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(66)//heightNavBar+20)
            make.left.right.equalToSuperview()
            make.height.equalTo(CGFloat.Constants.screenHeight*1/3)
        }
        imageViewPhoto.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(viewToPhoto)
            make.height.width.equalTo(CGFloat.Constants.sizeImagePhoto)
        }
        textFieldDesc.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(CGFloat.margin)
            make.right.equalToSuperview().offset(-CGFloat.margin)
            make.top.equalTo(viewToPhoto.snp.bottom).offset(CGFloat.margin*3)
            make.height.equalTo(CGFloat.heigthComponent)
        }
        textFieldPhone.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(CGFloat.margin)
            make.right.equalToSuperview().offset(-CGFloat.margin)
            make.top.equalTo(textFieldDesc.snp.bottom).offset(CGFloat.margin)
            make.height.equalTo(CGFloat.heigthComponent)
        }
        textFieldSite.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(CGFloat.margin)
            make.right.equalToSuperview().offset(-CGFloat.margin)
            make.top.equalTo(textFieldPhone.snp.bottom).offset(CGFloat.margin)
            make.height.equalTo(CGFloat.heigthComponent)
        }
        tableViewCategories.snp.makeConstraints { (make) in
            make.top.equalTo(textFieldSite.snp.bottom).offset(CGFloat.margin)
            make.right.equalTo(textFieldSite.snp.right)
            make.left.equalTo(textFieldSite.snp.left)
            make.bottom.equalTo(buttonRegister.snp.top).offset(-CGFloat.margin)
        }
        buttonRegister.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(CGFloat.margin)
            make.right.equalToSuperview().offset(-CGFloat.margin)
            make.bottom.equalToSuperview().offset(-CGFloat.margin*2)
            make.height.equalTo(CGFloat.heigthComponent)
        }
        buttonToAddANewCategory.snp.makeConstraints { (make) in
            make.top.equalTo(tableViewCategories.snp.top).offset(CGFloat.heigthComponent*0.2)
            make.right.equalToSuperview().offset(-(CGFloat.margin*2+10))
            make.height.width.equalTo(CGFloat.heigthComponent)
        }
        buttonPhoto.snp.makeConstraints { (make) in
//            make.right.equalTo(buttonToAddANewCategory.snp.right)
            make.left.equalToSuperview().offset((CGFloat.margin*2+10))
            make.top.equalTo(viewToPhoto.snp.bottom).offset(-CGFloat.heigthComponent/2)
            make.height.width.equalTo(CGFloat.heigthComponent)
        }
        
    }
    
    //MARK: - Configurações Add
    func additionalConfiguration() {
        hideKeyboardTapped()
        
        navigationItem.title = "Cadastro Marker"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Mapa", style: .plain, target: self, action: #selector(handleBackToMap))
        
        textFieldDesc.delegate = self
        textFieldSite.delegate = self
        textFieldPhone.delegate = self
        tableViewCategories.delegate = self
        tableViewCategories.dataSource = self
        tableViewCategories.register(CategoriesTableViewCell.self, forCellReuseIdentifier: cellID)
    }
    @objc func handleBackToMap() {
        presenter?.backToMap()
    }
    

}

//MARK: - Delegate dos TextsField
extension RegistrationMarkerView : UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let data = textField.text else {return}
        switch textField.tag {
        case 0:
            self.descricao = data
        case 1:
            self.telefone = data
        case 2:
            self.site = data
        default:
            break
        }
        
    }
    
}

//MARK: - Delegates da TabelView
extension RegistrationMarkerView : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(categories.count)
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewCategories.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! CategoriesTableViewCell
        cell.setShadow(alpha: 1, offSetX: 1, offSetY: 1, shadowOpacity: 1, shadowRadius: 2, boolean: true)
        let cat = categories[indexPath.row]
        cell.imageCategory.image = UIImage(named: cat.image)
        cell.labelCategory.text = cat.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        CGFloat.heigthComponent * 1.4
    }
    
}

//MARK: - Pegando a foto
extension RegistrationMarkerView : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let foto = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        self.imageViewPhoto.image = foto
        self.imageViewPhoto.layer.masksToBounds = true
        picker.dismiss(animated: true, completion: nil)
    }
    
}
