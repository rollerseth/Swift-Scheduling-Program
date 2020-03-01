//
//  Directions.swift
//  SchedulingApp
//
//  Created by Seth Roller on 1/25/18.
//  Copyright © 2018 Seth Roller. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class Directions: UIViewController, CLLocationManagerDelegate {
    
    
    @IBOutlet weak var directionsButton: UIButton!
    @IBOutlet weak var detailMapView: MKMapView!
    
    
    let manager = CLLocationManager()
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations[0]
        
        let span: MKCoordinateSpan = MKCoordinateSpanMake(0.005, 0.005)
        
        let myLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        
        let region: MKCoordinateRegion = MKCoordinateRegionMake(myLocation, span)
        
        detailMapView.setRegion(region, animated: true)
        
        
        self.detailMapView.showsUserLocation = true
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
  
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
            
        directionsButton.layer.shadowOffset = CGSize(width: 2, height: 2)
        directionsButton.layer.shadowOpacity = 0.75
        directionsButton.layer.shadowColor = UIColor.white.cgColor
        directionsButton.layer.shadowRadius = 5
        
        detailMapView.layer.masksToBounds = true
        detailMapView.layer.cornerRadius = 8
        detailMapView.layer.borderWidth = 1.5
        detailMapView.layer.borderColor = UIColor.black.cgColor
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
   
    
    
    @IBAction func directions(_ sender: Any) {
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }


}
