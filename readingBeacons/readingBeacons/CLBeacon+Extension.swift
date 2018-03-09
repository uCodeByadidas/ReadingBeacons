//
//  CLBeacon+Extension.swift
//  readingBeacons
//
import Foundation
import CoreLocation

extension CLBeacon {
    
    func majorDescription() -> String {
        return String(describing: major)
    }
    
    func minorDescription() -> String {
        return String(describing: minor)
    }
    
    func locationString() -> String {
        
        let proximity = proximityDescription()
        let accuracy = accuracyDescription()
        
        var location = proximity
        if self.proximity != .unknown {
            location += " (approx. \(accuracy)m)"
        }
        
        return location
    }
    
    func accuracyDescription() -> String {
        return String(format: "%.2f", accuracy)
    }
    
    func proximityDescription() -> String {
        switch proximity {
        case .unknown:
            return "Unknown"
        case .immediate:
            return "Immediate"
        case .near:
            return "Near"
        case .far:
            return "Far"
        }
    }
}
