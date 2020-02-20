//
//  MapView.swift
//  Closer - 2.0
//
//  Created by macbook-estagio on 28/01/20.
//  Copyright © 2020 macbook-estagio. All rights reserved.
//

import UIKit
import SnapKit
import MapKit
import CoreLocation

class MapView: UIViewController, MapViewProtocol {
    
    //MARK: - Variáveis
    var presenter : MapPresenterProtocol?
    let locationManager = CLLocationManager()
    var regionInMeters : Double = 1000
    let cellID = "cellID"

    var categoriesDefault = [Categorys]()
    lazy var categories : [Categorys] = {
        var category = [Categorys]()
        for i in self.categoriesDefault {
            category.append(i)
        }
        return category
    }()
    
    var marginRight: CGFloat?
    var coordinateCenterCurrentPosition: CLLocationCoordinate2D?
    static var coordinateLongPress: CLLocationCoordinate2D?
    
    
    //MARK: - Componentização
    lazy var mapView : MKMapView = {
        let mv = MKMapView()
        mv.isZoomEnabled = true // default true
        mv.isRotateEnabled = false // default true
        mv.isScrollEnabled = true // default true
        mv.showsCompass = true // default true
        mv.showsPointsOfInterest = true  //default true
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(goToRegisterMarker(sender:)))
        longPress.minimumPressDuration = 1
        view.addGestureRecognizer(longPress)
        
        return mv
    }()
    
    @objc func goToRegisterMarker(sender: UILongPressGestureRecognizer) {
        if sender.state != UIGestureRecognizer.State.began { return }
        let touchLocation = sender.location(in: mapView)
        print("Touch in MapView : ", touchLocation)
        let locationCoordinate = mapView.convert(touchLocation, toCoordinateFrom: mapView)
        print("latitude: ", locationCoordinate.latitude, "longitude: ", locationCoordinate.longitude)
        MapView.coordinateLongPress = locationCoordinate
        
        presenter?.pushToRegistrationMarkerView()
    }
    
    
    
    
    
    
    lazy var collectionViewCategoryInMap : UICollectionView = {
        let left = CGFloat.calculateLeftToCollectionView()
        marginRight = left
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        if CGFloat.widthScreen < 450 {
            layout.minimumLineSpacing = 17.5
        } else {
            layout.minimumLineSpacing = CGFloat.heigthComponent
        }
        
        layout.itemSize = CGSize(width: CGFloat.heigthComponent, height: CGFloat.heigthComponent)
        layout.sectionInset = UIEdgeInsets(top: 5, left: left, bottom: 5, right: 0)
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return cv
    }()
    lazy var buttonToZoomToCurrentLocation : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "mira"), for: .normal)
        button.layer.cornerRadius = CGFloat.heigthComponent/2
        button.imageEdgeInsets = UIEdgeInsets(top: 7, left: 7, bottom: 7, right: 7)
        button.backgroundColor = .white
        button.setShadow(alpha: 1, offSetX: 1, offSetY: 1, shadowOpacity: 1, shadowRadius: 2, boolean: true)
        button.addTarget(self, action: #selector(focusesOnCurrentLocation(sender:)), for: .touchUpInside)
        button.tag = 0
        return button
    }()
    @objc func focusesOnCurrentLocation(sender: UIButton) {
        print(sender.tag)
        
        if sender.tag == 0 {
            print("Foca na posição atual!!! ")
            mapView.setCenter(self.coordinateCenterCurrentPosition!, animated: true)
            buttonToZoomToCurrentLocation.setShadow(alpha: 1, offSetX: 0, offSetY: 0, shadowOpacity: 0, shadowRadius: 0, boolean: true)
            mapView.isScrollEnabled = false
            self.regionInMeters = 100
//            buttonToZoomToCurrentLocation.tag = 1
            buttonToZoomToCurrentLocation.tag = buttonToZoomToCurrentLocation.tag.togleInt()
            
        } else {
            buttonToZoomToCurrentLocation.setShadow(alpha: 1, offSetX: 1, offSetY: 1, shadowOpacity: 1, shadowRadius: 2, boolean: true)
            mapView.isScrollEnabled = true
            self.regionInMeters = 1000
//            buttonToZoomToCurrentLocation.tag = 0
            buttonToZoomToCurrentLocation.tag = buttonToZoomToCurrentLocation.tag.togleInt()
        }
        
    }
    
    //MARK: - Reenderizando...
    func render() {
        view.addSubviews(viewsToAdd: mapView, collectionViewCategoryInMap, buttonToZoomToCurrentLocation)
        mapView.snp.makeConstraints { (make) in
            make.center.size.equalToSuperview()
        }
        collectionViewCategoryInMap.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-3*CGFloat.margin)
            make.height.equalTo(CGFloat.heigthComponent*1.3)
        }
        buttonToZoomToCurrentLocation.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-marginRight!)
            make.bottom.equalTo(collectionViewCategoryInMap.snp.top).offset(-CGFloat.margin)
            make.height.width.equalTo(CGFloat.heigthComponent)
        }
    }
    //MARK: - Sign Out
    @objc func signOut() {
        presenter?.signOut()
    }
    
    //MARK: - ViewDidLoad()
    override func viewDidLoad() {
        
        super.viewDidLoad()
        MapWireFrame.createModulo(viewRef: self)
        
        mapView.delegate = self

        presenter?.viewDidLoad()
    }
    
    func showMyLocation() {
        print("Mostrando minha localização")
        checkLocationServices()
    }
    
    func saveDefaultCategories() {
        presenter?.saveDefaultCategories()
    }
    
    func additionalConfiguration() {
        navigationController?.isNavigationBarHidden = false
        navigationItem.title = "Mapa"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Sign Out", style: .plain, target: self, action: #selector(signOut))
        
        collectionViewCategoryInMap.delegate = self
        collectionViewCategoryInMap.dataSource = self
        collectionViewCategoryInMap.register(CollectionViewCellInMap.self, forCellWithReuseIdentifier: cellID)
    }
    
    

}

extension MapView : MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
//        print("Annotation: \(String(describing:view.annotation?.title))")
    }
    
}

extension MapView : CLLocationManagerDelegate {
    
    //1
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            //setup our locationManager
            setupLocationManager()
        } else {
            //Show Alert letting the user know they have turn this on
        }
    }
    //2
    func setupLocationManager() {
        locationManager.delegate = self
        //nível de presição de localização
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        checkLocationAutorization()
    }
    //3
    func checkLocationAutorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            mapView.showsUserLocation = true
            centerViewOnUserLocation()
            locationManager.startUpdatingLocation()
            break
        case .denied:
            //Show Alert instructing them how to turn on permissions
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            break
        case .restricted:
            //Show an alert letting them know what`s up
            break
        case .authorizedAlways:
            break
        default:
            break
        }
    }
    //4
    func centerViewOnUserLocation() {
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
            mapView.setRegion(region, animated: true)
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {return}
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        self.coordinateCenterCurrentPosition = center
        let region = MKCoordinateRegion(center: center, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
        mapView.setRegion(region, animated: true )
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAutorization()
    }
    
}

extension MapView : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        collectionView.backgroundColor = .clear
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! CollectionViewCellInMap
        cell.backgroundColor = .white
        cell.layer.cornerRadius = CGFloat.heigthComponent/2
        cell.setShadow(alpha: 1, offSetX: 1, offSetY: 1, shadowOpacity: 1, shadowRadius: 2, boolean: true)
                
//        let selectedCategory = categories[indexPath.item].image
//        cell.buttonCategorias.image = UIImage(named: selectedCategory)
        
        let selectedCategoryDefault = categories[indexPath.item].image
        cell.buttonCategorias.image = UIImage(named: selectedCategoryDefault)?.imageWithInsets(insetDimen: 40)
        
        
        return cell
    }
    
    
}

