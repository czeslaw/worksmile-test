//
//  PathParser.swift
//  worksmile-test
//
//  Created by Piotr Nietrzebka on 14/05/2022.
//

import Foundation
import MapKit

class Point: NSObject, Decodable, MKAnnotation {
    var coordinate: CLLocationCoordinate2D {
        get {
            CLLocationCoordinate2D(latitude: Double(latitude) ?? 0,
                                   longitude: Double(longitude) ?? 0)
        }
        set {
            latitude = String(newValue.latitude)
            longitude = String(newValue.longitude)
        }
    }
    
    var longitude: String
    var latitude: String
    let altitude: String
    let accuracy: String
    let timestamp: String
    let distance: String
}

class PointsParser {
    
    let url: URL
    
    init(url: URL) {
        self.url = url
    }
    
    func parse() -> [Point]? {
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let points = try decoder.decode([Point].self, from: data)
            return points
        } catch {
            print("error:\(error)")
        }
        return nil
    }
}
