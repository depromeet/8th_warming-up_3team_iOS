//
//  MainViewController+Delegate.swift
//  warmingUpProject_3
//
//  Created by 이규현 on 2020/09/07.
//  Copyright © 2020 team3. All rights reserved.
//
import UIKit
import NMapsMap
import CoreLocation

extension MainViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .denied:
            print("LocationManager didChangeAuthorization denied")
        case .notDetermined:
            print("LocationManager didChangeAuthorization notDetermined")
        case .authorizedWhenInUse:
            print("LocationManager didChangeAuthorization authorizedWhenInUse")
            
            locationManager?.requestLocation()
        case .authorizedAlways:
            print("LocationManager didChangeAuthorization authorizedAlways")
            
            locationManager?.requestLocation()
        case .restricted:
            print("LocationManager didChangeAuthorization restricted")
        default:
            print("LocationManager didChangeAuthorization")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locations.forEach { (location) in
            mapView.locationOverlay.location = NMGLatLng(lat: location.coordinate.latitude, lng: location.coordinate.longitude)
            print("location:  ",location.coordinate)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("----------- didFailWithError \(error.localizedDescription)")
        if let error = error as? CLError, error.code == .denied {
            locationManager?.stopMonitoringSignificantLocationChanges()
            return
        }
    }
}

extension MainViewController: NMFMapViewTouchDelegate {
    
    func mapView(_ mapView: NMFMapView, didTapMap latlng: NMGLatLng, point: CGPoint) {
        sortingMarker(picks: naverMapView.mapView.pickAll(point, withTolerance: 10))
    }
    
    private func sortingMarker(picks: [NMFPickable]? ) {
        let sortMarkers = picks?.filter { $0.isKind(of: NMFMarker.self) }
        let count = sortMarkers?.count ?? 0
        var selectedMarkers: [UInt] = []
        
        for idx in 0..<count {
            if let marker = sortMarkers?[idx] as? NMFMarker {
                selectedMarkers.append(marker.tag)
            }
        }
        
        viewModel.selectedData.onNext(selectedMarkers)
    }
    
}
