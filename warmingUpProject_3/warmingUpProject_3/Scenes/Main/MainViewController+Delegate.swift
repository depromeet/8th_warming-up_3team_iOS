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
            
            //MARK: 위치 오버레이 현재 위치 설정
            let currentLocation = NMGLatLng(lat: location.coordinate.latitude, lng: location.coordinate.longitude)
            mapView.locationOverlay.location = currentLocation
            viewModel.beforeCameraPosition = NMFCameraPosition(NMGLatLng(lat: location.coordinate.latitude, lng: location.coordinate.longitude), zoom: mapView.zoomLevel)
        }
    }
    
    // MARK: 위치 오버레이 헤딩 조절
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        // MARK: newHeading.magneticHeading == degrees(도) 단위 측정
        let degree = CGFloat(newHeading.magneticHeading)
        mapView.locationOverlay.heading = degree
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
        var selectedMarkers: [[AnyHashable : Any]] = []
        
        for idx in 0..<count {
            if let marker = sortMarkers?[idx] as? NMFMarker {
                selectedMarkers.append(marker.userInfo)
            }
        }
        
        viewModel.selectedData.onNext(selectedMarkers)
    }
    
}

extension MainViewController: NMFMapViewCameraDelegate {
    
    func mapView(_ mapView: NMFMapView, cameraIsChangingByReason reason: Int) {
        print("===== \n", mapView.cameraPosition.target.toLatLng())
    }
    
    //MARK: 카메라 움직임이 끝났을때
    func mapView(_ mapView: NMFMapView, cameraDidChangeByReason reason: Int, animated: Bool) {
        
        
        /*
         reason -1 : 사용자의 제스처로 인해 카메라가 움직였음을 나타내는 값.
         
         */
        if reason == -1 {
            
            // 지우고
            circleOverlay?.mapView = nil
            var radius: Double = 0
            let zoomLevel = floor(mapView.zoomLevel)
            
            // 줌 레벨에 따른 반경
            switch zoomLevel {
            case 12: // 1_000
                radius = 2_500
            case 13: // 500
                radius = 1_250
            case 14: // 200
                radius = 500
            case 15: // 100
                radius = 250
            default:
                radius = 3_000
            }
            
            circleOverlay =  NMFCircleOverlay(mapView.cameraPosition.target.toLatLng(), radius: radius)
            circleOverlay?.fillColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.07)
            circleOverlay?.outlineColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.07)
            circleOverlay?.outlineWidth = 1
            circleOverlay?.mapView = mapView
        }
        
        guard let coordinate = locationManager?.location?.coordinate else { return }
        
//        print(mapView.cameraPosition)
        
        let currentLocationFromDistance = mapView.cameraPosition.target.distance(to: NMGLatLng(lat: viewModel.beforeCameraPosition?.target.lat ?? NMGLatLng.init(from: coordinate).lat, lng: viewModel.beforeCameraPosition?.target.lng ?? NMGLatLng.init(from: coordinate).lng))

        
        // 카메라 현재 위치 기준으로 요청하면 다시 카메라 센터 기준으로 3km
        if currentLocationFromDistance >= 3_000 {
            viewModel.beforeCameraPosition = NMFCameraPosition(mapView.cameraPosition.target, zoom: mapView.zoomLevel)
            viewModel.getDocumentNearBy(latitude: mapView.cameraPosition.target.lat , longitude: mapView.cameraPosition.target.lng, distance: 1)
        }
        
        let center =  CLLocation ( latitude : 37.7832889 , longitude : -122.4056973 )
        
         // 반경 600 미터의 [37.7832889, -122.4056973] 위치 쿼리
//        var circleQuery = geoFire.q ueryAtLocation (center, withRadius : 0.6 ) // 지역별
//        위치 쿼리
//        geofi

        
    }
}
