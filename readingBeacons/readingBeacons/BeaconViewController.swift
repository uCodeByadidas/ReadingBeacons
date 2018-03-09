import UIKit
import CoreLocation

class BeaconViewController: UIViewController {
    
    @IBOutlet weak var beaconsTableView: UITableView!
    
    var locationManager: CLLocationManager!
    var beaconsReached: [CLBeacon] = []
    
    let uuid = UUID(uuidString: "Enter here the UUID")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
    }
    
    func startScanning() {
        
        guard let beaconUUID = uuid else {
            return
        }
        
        let region = CLBeaconRegion(proximityUUID: beaconUUID, identifier: "hackaton")
        locationManager.startMonitoring(for: region)
        locationManager.startRangingBeacons(in: region)
    }
}

extension BeaconViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways &&
            CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) &&
            CLLocationManager.isRangingAvailable() {
            startScanning()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        print(beacons)
        beaconsReached = beacons.sorted {
            
            if $0.major.compare($1.major) == .orderedSame {
                return $0.minor.compare($1.minor) == .orderedAscending
            }
            
            return $0.major.compare($1.major) == .orderedAscending
        }
        beaconsTableView.reloadData()
    }
}

extension BeaconViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beaconsReached.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BeaconCell", for: indexPath) as! BeaconCell
        cell.beacon = beaconsReached[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
}

