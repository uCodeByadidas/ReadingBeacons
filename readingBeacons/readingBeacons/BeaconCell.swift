import UIKit
import CoreLocation

class BeaconCell: UITableViewCell {
    
    @IBOutlet weak var major_label: UILabel!
    @IBOutlet weak var minor_label: UILabel!
    @IBOutlet weak var distance_label: UILabel!
    
    var beacon: CLBeacon? = nil {
        didSet {
            if let beacon = beacon {
                major_label.text = beacon.majorDescription()
                minor_label.text = beacon.minorDescription()
                distance_label.text = beacon.locationString()
            } else {
                major_label.text = ""
                minor_label.text = ""
                distance_label.text = ""
            }
        }
    }

}
