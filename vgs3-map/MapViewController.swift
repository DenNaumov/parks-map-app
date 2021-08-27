//
//  ViewController.swift
//  vgs3-map
//
//  Created by Денис Наумов on 09.08.2021.
//  Copyright © 2021 Denis Naumov. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    private let locationManager = CLLocationManager()
    private let identifier = NSStringFromClass(AnnotationViewModel.self)

    var viewModel: ParkListViewModel?
    private var displayedAnnotations = [MKAnnotation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        checkLocationServices()
        setupNavBar()
        setupMap()
    }
    
    private func setupNavBar() {
        navigationItem.leftBarButtonItem?.title = ""
        navigationItem.rightBarButtonItem = MKUserTrackingBarButtonItem(mapView: mapView)
    }
}

// MARK: setup
extension MapViewController {
   
    private func setupMap() {
        guard
            let displayedParks = viewModel?.getDisplayedParks(),
            let centerPoint = viewModel?.centerPoint,
            let mapBoundary = viewModel?.mapBoundary
        else { return }
        
        mapView.delegate = self
        mapView.centerTo(centerPoint)
        mapView.setCameraBoundary(mapBoundary, animated: false)
        for park in displayedParks {
            displayParkOnMap(park)
        }
        mapView.register(MKMarkerAnnotationView.self, forAnnotationViewWithReuseIdentifier: identifier)
    }
    
    private func displayParkOnMap(_ park: ParkViewModel) {
        mapView.addOverlay(park.polygonCoordinates as MKPolygon)
        let annotation = AnnotationViewModel(coordinate: park.annotationCoordinate, title: park.displayName)
        mapView.addAnnotation(annotation)
    }
    
    private func setupAnnotationView(with annotation: AnnotationViewModel) -> MKAnnotationView {
        let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier, for: annotation)
        guard let markerAnnotationView = annotationView as? MKMarkerAnnotationView else { fatalError() }
        markerAnnotationView.animatesWhenAdded = true
        markerAnnotationView.markerTintColor = .purple
        markerAnnotationView.canShowCallout = true
        markerAnnotationView.rightCalloutAccessoryView = UIButton.init(type: .detailDisclosure)
        return markerAnnotationView
    }
}

extension MapViewController: MKMapViewDelegate {

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotationviewModel = annotation as? AnnotationViewModel else { fatalError() }
        let annotationView = setupAnnotationView(with: annotationviewModel)
        return annotationView
    }

    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        guard let polygon = overlay as? MKPolygon else { fatalError() }
        let renderer = MKPolygonRenderer(polygon: polygon)
        renderer.fillColor = UIColor.green.withAlphaComponent(0.5)
        renderer.strokeColor = .green
        renderer.lineWidth = 2
        return renderer
    }
}

// MARK: location manager
extension MapViewController: CLLocationManagerDelegate {

    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    private func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkLocationAuthorization()
        } else {
        }
    }
    
    func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            mapView.showsUserLocation = true
            break
        case .denied:
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            break
        case.restricted:
            break
        case .authorizedAlways:
            break
        @unknown default:
            break
        }
    }
}

private extension MKMapView {

    func centerTo(_ coordinate: CLLocationCoordinate2D, regionRadius: CLLocationDistance = 15000) {
        let coordinateRegion = MKCoordinateRegion(
            center: coordinate,
            latitudinalMeters: regionRadius,
            longitudinalMeters: regionRadius
        )
        setRegion(coordinateRegion, animated: true)
    }
}
