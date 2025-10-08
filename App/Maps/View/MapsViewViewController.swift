//
//  MapsViewViewController.swift
//  RioDailyNews
//
//  Created by Rion on 6.10.25.
//

import UIKit
import MapKit

class MapsViewViewController: UIViewController, UISearchBarDelegate, MKMapViewDelegate,Storyboarded, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var mapsView: MKMapView!
    let mapView = MKMapView()
    let searchBar = UISearchBar()
    let dropdownTable = UITableView()
    
    var viewModel : MapsViewModelProtocol?
    var coordinator : MapsCoordinator?
    
    var headquarters = [
       ("BBC Broadcasting House", "London, UK", CLLocationCoordinate2D(latitude: 51.5186, longitude: -0.1430)), ("CNN Center", "Atlanta, GA, USA", CLLocationCoordinate2D(latitude: 33.7550, longitude: -84.3963)), ("Fox News Headquarters", "New York, NY, USA", CLLocationCoordinate2D(latitude: 40.7560, longitude: -73.9855)), ("Deutsche Welle", "Bonn, Germany", CLLocationCoordinate2D(latitude: 50.7374, longitude: 7.0982)), ("Euronews", "Lyon, France", CLLocationCoordinate2D(latitude: 45.7626, longitude: 4.8280)), ("Al Jazeera Media Network", "Doha, Qatar", CLLocationCoordinate2D(latitude: 25.2842, longitude: 51.4415)), ("NBC Universal", "New York, NY, USA", CLLocationCoordinate2D(latitude: 40.7570, longitude: -73.9855)), ("CBS Broadcast Center", "New York, NY, USA", CLLocationCoordinate2D(latitude: 40.7540, longitude: -73.9840)), ("The New York Times", "New York, NY, USA", CLLocationCoordinate2D(latitude: 40.7128, longitude: -74.0060)),
        // --- Additional European countries ---
        // Western Europe
        ("RTBF (Belgian Radio and Television)", "Brussels, Belgium", CLLocationCoordinate2D(latitude: 50.8503, longitude: 4.3517)),
        ("SRG SSR (Swiss Broadcasting Corporation)", "Bern, Switzerland", CLLocationCoordinate2D(latitude: 46.9481, longitude: 7.4474)),
        ("ORF (Austrian Broadcasting Corporation)", "Vienna, Austria", CLLocationCoordinate2D(latitude: 48.2100, longitude: 16.3738)),
        ("TV Luxembourg (RTL Belgium/TV Luxembourg)", "Luxembourg City, Luxembourg", CLLocationCoordinate2D(latitude: 49.6117, longitude: 6.1319)),
        ("RUV (Icelandic National Broadcasting Service)", "Reykjavik, Iceland", CLLocationCoordinate2D(latitude: 64.1355, longitude: -21.8954)), // Already included

        // Northern Europe
        ("RTE (Raidió Teilifís Éireann)", "Dublin, Ireland", CLLocationCoordinate2D(latitude: 53.3192, longitude: -6.2197)),
        ("SVT (Sveriges Television)", "Stockholm, Sweden", CLLocationCoordinate2D(latitude: 59.3293, longitude: 18.0686)),
        ("NRK (Norwegian Broadcasting Corporation)", "Oslo, Norway", CLLocationCoordinate2D(latitude: 59.9180, longitude: 10.7330)), // Already included
        ("DR (Danish Broadcasting Corporation)", "Copenhagen, Denmark", CLLocationCoordinate2D(latitude: 55.6727, longitude: 12.5701)), // Already included
        ("YLE (Finnish Broadcasting Company)", "Helsinki, Finland", CLLocationCoordinate2D(latitude: 60.1699, longitude: 24.9384)), // Already included

        // Eastern Europe (additional)
        ("BNT (Bulgarian National Television)", "Sofia, Bulgaria", CLLocationCoordinate2D(latitude: 42.6966, longitude: 23.3260)), // Already included
        ("ČT (Czech Television)", "Prague, Czech Republic", CLLocationCoordinate2D(latitude: 50.0697, longitude: 14.4477)), // Already included
        ("HRT (Croatian Radiotelevision)", "Zagreb, Croatia", CLLocationCoordinate2D(latitude: 45.8150, longitude: 15.9770)), // Already included
        ("RTM (Macedonia)", "Skopje, North Macedonia", CLLocationCoordinate2D(latitude: 41.9981, longitude: 21.4254)), // Already included
        ("RT (Latvia)", "Riga, Latvia", CLLocationCoordinate2D(latitude: 56.9496, longitude: 24.1052)), // Already included
        ("LTV (Latvijas Televīzija)", "Riga, Latvia", CLLocationCoordinate2D(latitude: 56.9496, longitude: 24.1052)), // Already included
        ("LRT (Lithuanian National Radio and Television)", "Vilnius, Lithuania", CLLocationCoordinate2D(latitude: 54.6872, longitude: 25.2797)), // Already included
        ("TVP (Telewizja Polska)", "Warsaw, Poland", CLLocationCoordinate2D(latitude: 52.2297, longitude: 21.0122)), // Already included
        ("RTS (Radio Television of Serbia)", "Belgrade, Serbia", CLLocationCoordinate2D(latitude: 44.8186, longitude: 20.4569)), // Already included
        ("RTK (Radio Television of Kosovo)", "Pristina, Kosovo", CLLocationCoordinate2D(latitude: 42.6675, longitude: 21.1662)), // Already included
        ("RTCG (Radio and Television of Montenegro)", "Podgorica, Montenegro", CLLocationCoordinate2D(latitude: 42.4410, longitude: 19.2627)), // Already included
        ("BHRT (Radio and Television of Bosnia and Herzegovina)", "Sarajevo, Bosnia and Herzegovina", CLLocationCoordinate2D(latitude: 43.8563, longitude: 18.4131)), // Already included

        // Southern Europe
        ("RAI (Radiotelevisione Italiana)", "Rome, Italy", CLLocationCoordinate2D(latitude: 41.9028, longitude: 12.4964)),
        ("TVE (Televisión Española)", "Madrid, Spain", CLLocationCoordinate2D(latitude: 40.4168, longitude: -3.7038)),
        ("ERT (Hellenic Broadcasting Corporation)", "Athens, Greece", CLLocationCoordinate2D(latitude: 37.9887, longitude: 23.7678)), // Already included
        ("RTP (Rádio e Televisão de Portugal)", "Lisbon, Portugal", CLLocationCoordinate2D(latitude: 38.7167, longitude: -9.1415)), // Already included

        // --- Australia & Oceania ---
        ("ABC (Australian Broadcasting Corporation)", "Sydney, Australia", CLLocationCoordinate2D(latitude: -33.8688, longitude: 151.2093)),
        ("SBS (Special Broadcasting Service)", "Sydney, Australia", CLLocationCoordinate2D(latitude: -33.8688, longitude: 151.2093)),

        // --- Asia: China & Japan ---
        ("CCTV (China Central Television)", "Beijing, China", CLLocationCoordinate2D(latitude: 39.9042, longitude: 116.4074)),
        ("NHK (Japan Broadcasting Corporation)", "Tokyo, Japan", CLLocationCoordinate2D(latitude: 35.6895, longitude: 139.6917)),

        ("RTL Germany", "Cologne, Germany", CLLocationCoordinate2D(latitude: 50.9375, longitude: 6.9603)),
        ("TVR (Televiziunea Română)", "Bucharest, Romania", CLLocationCoordinate2D(latitude: 44.4268, longitude: 26.1025)),
       
       ("Saudi Broadcasting Authority (Al Saudiya TV)", "Riyadh, Saudi Arabia", CLLocationCoordinate2D(latitude: 24.7136, longitude: 46.6753)), ("Abu Dhabi TV (UAE Media Corp)", "Abu Dhabi, UAE", CLLocationCoordinate2D(latitude: 24.4667, longitude: 54.3667)),
       
       ("CBC/Radio-Canada", "Ottawa, Canada", CLLocationCoordinate2D(latitude: 45.4215, longitude: -75.6992)),
       
       ("Rede Globo", "Rio de Janeiro, Brazil", CLLocationCoordinate2D(latitude: -22.9786, longitude: -43.2234)), ("TV Pública Argentina", "Buenos Aires, Argentina", CLLocationCoordinate2D(latitude: -34.6037, longitude: -58.3816)), ("TVN (Televisión Nacional de Chile)", "Santiago, Chile", CLLocationCoordinate2D(latitude: -33.4489, longitude: -70.6693)), ("Caracol Televisión", "Bogotá, Colombia", CLLocationCoordinate2D(latitude: 4.7110, longitude: -74.0721)), ("TV Perú", "Lima, Peru", CLLocationCoordinate2D(latitude: -12.0464, longitude: -77.0428)), ("Televisión Nacional Uruguay (TNU)", "Montevideo, Uruguay", CLLocationCoordinate2D(latitude: -34.9011, longitude: -56.1645)), ("SNT (Sistema Nacional de Televisión)", "Asunción, Paraguay", CLLocationCoordinate2D(latitude: -25.2637, longitude: -57.5759)), ("Bolivia TV", "La Paz, Bolivia", CLLocationCoordinate2D(latitude: -16.5000, longitude: -68.1193)), ("Ecuador TV", "Quito, Ecuador", CLLocationCoordinate2D(latitude: -0.1807, longitude: -78.4678)), ("Venezolana de Televisión (VTV)", "Caracas, Venezuela", CLLocationCoordinate2D(latitude: 10.4806, longitude: -66.9036)),
    ]
    var calloutViews: [HQCalloutView] = []
    
    let hqDescriptions: [String: String] = [
        "BBC Broadcasting House": "BBC is the UK’s public-service broadcaster, founded in 1922, providing news and entertainment worldwide.",
        "CNN Center": "CNN is an American news-based pay television channel founded in 1980.",
        "Fox News Headquarters": "Fox News is a US-based news channel focusing on conservative news and commentary.",
        "Deutsche Welle": "DW is Germany’s international broadcaster providing news in multiple languages.",
        "Euronews": "Euronews is a European news network based in Lyon, France, covering international news.",
        "Al Jazeera Media Network": "Al Jazeera is a Doha-based news network providing global news coverage.",
        "NBC Universal": "NBC Universal is a US-based media and entertainment company headquartered in New York.",
        "CBS Broadcast Center": "CBS is one of the major American broadcast television networks.",
        "The New York Times": "The New York Times is a leading American newspaper known for in-depth reporting.",
        
        "RTK (Radio Television of Kosovo)": "RTK is Kosovo’s public broadcaster offering news and cultural programming.",
        "RTS (Radio Television of Serbia)": "RTS is Serbia’s national broadcaster for TV and radio content.",
        "RTV (Radio Television of Vojvodina)": "RTV provides regional TV and radio coverage in Vojvodina, Serbia.",
        "HRT (Croatian Radiotelevision)": "HRT is Croatia’s public broadcaster for TV and radio.",
        "MRT (Macedonian Radio Television)": "MRT is North Macedonia’s public broadcaster.",
        "TVP (Telewizja Polska)": "TVP is Poland’s public broadcasting corporation.",
        "UA:PBC (Public Broadcasting Company of Ukraine)": "UA:PBC is Ukraine’s national public broadcaster.",
        "MTVA (Hungarian Media Services)": "MTVA operates Hungary’s public media services.",
        "RTV Slovenija": "RTV Slovenia is Slovenia’s national public broadcaster.",
        
        "RTE (Raidió Teilifís Éireann)": "Ireland’s national public service broadcaster.",
        "RTP (Rádio e Televisão de Portugal)": "Portugal’s public broadcaster for television and radio.",
        "ERT (Hellenic Broadcasting Corporation)": "Greece’s state broadcaster providing TV and radio programming.",
        "DR (Danish Broadcasting Corporation)": "Denmark’s national broadcaster for TV, radio, and online.",
        "YLE (Finnish Broadcasting Company)": "Finland’s national public broadcasting company.",
        "NRK (Norwegian Broadcasting Corporation)": "Norway’s public broadcaster for television, radio, and online.",
        "RÚV (Icelandic National Broadcasting Service)": "Iceland’s national TV and radio broadcaster.",
        "Česká Televize (Czech Television)": "Czech Republic’s public television broadcaster.",
        
        "ERR (Estonian Public Broadcasting)": "Estonia’s public broadcaster providing news and media.",
        "LTV (Latvijas Televīzija)": "Latvia’s national television broadcaster.",
        "LRT (Lithuanian National Radio and Television)": "Lithuania’s national public broadcasting service.",
        
        "RTL Télé Lëtzebuerg": "Luxembourg-based broadcaster, part of RTL Group.",
        "BNT (Bulgarian National Television)": "Bulgaria’s public television broadcaster.",
        "RTM (Radio Télévision Marocaine)": "Morocco’s national broadcaster.",
        
        "Saudi Broadcasting Authority (Al Saudiya TV)": "Saudi Arabia’s national television network.",
        "Abu Dhabi TV (UAE Media Corp)": "United Arab Emirates’ state broadcaster.",
        
        "CBC/Radio-Canada": "Canada’s national public broadcaster providing TV, radio, and digital content.",
        
        "Rede Globo": "Brazil’s largest TV network, broadcasting nationwide.",
        "TV Pública Argentina": "Argentina’s national public TV network.",
        "TVN (Televisión Nacional de Chile)": "Chile’s state-run TV network.",
        "Caracol Televisión": "Colombian private TV network based in Bogotá.",
        "TV Perú": "Peru’s public television channel.",
        "Televisión Nacional Uruguay (TNU)": "Uruguay’s national TV broadcaster.",
        "SNT (Sistema Nacional de Televisión)": "Paraguay’s public television network.",
        "Bolivia TV": "Bolivia’s national broadcaster.",
        "Ecuador TV": "Ecuador’s public TV channel.",
        "Venezolana de Televisión (VTV)": "Venezuela’s national TV network.",
        
        "TRM (TeleRadio-Moldova)": "Moldova’s national broadcaster.",
        "RTCG (Radio and Television of Montenegro)": "Montenegro’s public TV and radio broadcaster.",
        "BHRT (Radio and Television of Bosnia and Herzegovina)": "Bosnia and Herzegovina’s national broadcaster.",
        
        "TV5Monde": "French-language international news network based in Paris.",
        "TNT Headquarters (Turner Broadcasting System)": "US-based entertainment network, part of Warner Bros. Discovery.",
        
        "RTL Germany": "Germany’s leading private TV broadcaster.",
        "TVR (Televiziunea Română)": "Romania’s national public broadcaster.",
        
        "ABC (Australian Broadcasting Corporation)": "Australia’s national public broadcaster.",
        "SBS (Special Broadcasting Service)": "Australia’s multicultural and multilingual broadcaster.",
        
        "CCTV (China Central Television)": "China’s state broadcaster, offering news and entertainment nationwide.",
        "NHK (Japan Broadcasting Corporation)": "Japan’s public broadcaster providing TV and radio content."
    ]
    var hqLogos: [String: String] = [
        "BBC Broadcasting House": "bbc_logo", // the name of the image in your Assets.xcassets
        "CNN Center": "cnn_logo",
        "Fox News Headquarters": "fox_logo",
        // … add logos for all headquarters
    ]

    var filteredHeadquarters: [(String, String, CLLocationCoordinate2D)] = []
    var isDropdownVisible = false
    
    override func viewDidLoad() {
           super.viewDidLoad()
        
        
        // --- Add all headquarters pins on map at launch ---
        for hq in headquarters {
            let annotation = MKPointAnnotation()
            annotation.title = hq.0
            annotation.subtitle = hq.1
            annotation.coordinate = hq.2
            mapView.addAnnotation(annotation)
        }

        // Optionally zoom out to show all pins
        mapView.showAnnotations(mapView.annotations, animated: true)

        
           view.backgroundColor = .white
           searchBar.backgroundColor = .clear
          searchBar.searchBarStyle = .minimal
          let textField = searchBar.searchTextField
          textField.backgroundColor = UIColor(white: 1.0, alpha: 0.9) // light background for text field
          textField.layer.cornerRadius = 10
           textField.clipsToBounds = true
           mapView.delegate = self
           mapView.translatesAutoresizingMaskIntoConstraints = false
           mapView.showsUserLocation = true
           view.addSubview(mapView)
           
           // Make map cover entire screen
           NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor,constant: 100),
               mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
               mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
               mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
           ])
           
           // --- Setup Search Bar ---
           searchBar.delegate = self
           searchBar.placeholder = "Search headquarters..."
           searchBar.translatesAutoresizingMaskIntoConstraints = false
           view.addSubview(searchBar)
           
           NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 120),
               searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
               searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15)
           ])
           
           // --- Setup Dropdown Table ---
           dropdownTable.delegate = self
           dropdownTable.dataSource = self
           dropdownTable.isHidden = true
           dropdownTable.layer.borderWidth = 1
           dropdownTable.layer.borderColor = UIColor.lightGray.cgColor
           dropdownTable.layer.cornerRadius = 8
           dropdownTable.translatesAutoresizingMaskIntoConstraints = false
           view.addSubview(dropdownTable)
           
           NSLayoutConstraint.activate([
               dropdownTable.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
               dropdownTable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
               dropdownTable.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
               dropdownTable.heightAnchor.constraint(equalToConstant: 400)
           ])
        
        
        // Add all HQ pins
        for hq in headquarters {
            let annotation = MKPointAnnotation()
            annotation.title = hq.0
            annotation.subtitle = hq.1
            annotation.coordinate = hq.2
            mapView.addAnnotation(annotation)
        }

           
           filteredHeadquarters = headquarters
       }

    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredHeadquarters = headquarters
            dropdownTable.isHidden = true
        } else {
            filteredHeadquarters = headquarters.filter { $0.0.lowercased().contains(searchText.lowercased()) }
            dropdownTable.isHidden = filteredHeadquarters.isEmpty
        }
        dropdownTable.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        dropdownTable.isHidden = true
    }
    
    // MARK: - Table View
    @objc func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredHeadquarters.count
    }
    
    @objc(tableView:cellForRowAtIndexPath:) func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "HQCell")
        let hq = filteredHeadquarters[indexPath.row]
        cell.textLabel?.text = hq.0
        cell.detailTextLabel?.text = hq.1
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        searchBar.resignFirstResponder()
        dropdownTable.isHidden = true
        
        let hq = filteredHeadquarters[indexPath.row]
        searchBar.text = hq.0
        
        // Add pin to map
        mapView.removeAnnotations(mapView.annotations)
        let annotation = MKPointAnnotation()
        annotation.coordinate = hq.2
        annotation.title = hq.0
        annotation.subtitle = hq.1
        mapView.addAnnotation(annotation)
        
        // Center map on HQ
        mapView.setRegion(MKCoordinateRegion(center: hq.2, latitudinalMeters: 5000, longitudinalMeters: 5000), animated: true)
    }
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation { return nil }

        let identifier = "HQPin"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView

        if annotationView == nil {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            annotationView?.markerTintColor = .systemBlue
        } else {
            annotationView?.annotation = annotation
        }

        // Always create/configure the callout for this annotation
        let calloutView = HQCalloutView(frame: CGRect(x: 0, y: 0, width: 300, height: 180))

        if let hqName = annotation.title ?? "",
           let hq = headquarters.first(where: { $0.0 == hqName }) {
            
            let description = hqDescriptions[hq.0] ?? "No description available"
            let logo = hqLogos[hq.0].flatMap { UIImage(named: $0) }

            calloutView.configure(
                title: hq.0,
                subtitle: hq.1,
                description: description
              
            )
        }

        calloutView.openButton.addTarget(self, action: #selector(openInMaps(_:)), for: .touchUpInside)

        annotationView?.detailCalloutAccessoryView = calloutView

        return annotationView
    }

    @objc func openInMaps(_ sender: UIButton) {
        guard let calloutView = sender.superview as? HQCalloutView else { return }
        guard let title = calloutView.titleLabel.text else { return }

        if let hq = headquarters.first(where: { $0.0 == title }) {
            let coordinate = hq.2
            let placemark = MKPlacemark(coordinate: coordinate)
            let mapItem = MKMapItem(placemark: placemark)
            mapItem.name = hq.0
            mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving])
        }
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let annotation = view.annotation else { return }

        let alert = UIAlertController(
            title: annotation.title ?? "Unknown HQ",
            message: annotation.subtitle ?? "No details available",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    @IBAction func btnaction(_ sender: Any) {
        print("click")
        self.coordinator?.stop()
    }
}
extension MapsViewViewController : Coordinated {
    func getCoordinator() -> Coordinator? {
        return coordinator
    }
    func setCoordinator(_ coordinator: Coordinator) {
        self.coordinator = coordinator as? MapsCoordinator
    }
}


class HQCalloutView: UIView {

    let titleLabel = UILabel()
       let subtitleLabel = UILabel()
       let descriptionLabel = UILabel() // <- add this
       let openButton = UIButton(type: .system)
       let logoImageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {
        backgroundColor = UIColor.white
        layer.cornerRadius = 12
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowRadius = 6

        // Logo/Image
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(logoImageView)

        // Title
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)

        // Subtitle / Location
        subtitleLabel.font = UIFont.systemFont(ofSize: 14)
        subtitleLabel.textColor = .darkGray
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(subtitleLabel)

        // Description / short info
        descriptionLabel.font = UIFont.systemFont(ofSize: 13)
        descriptionLabel.textColor = .gray
        descriptionLabel.numberOfLines = 3 // allow multiple lines
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(descriptionLabel)

        // Open button
        openButton.setTitle("Open in Maps", for: .normal)
        openButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(openButton)

        // Constraints
        NSLayoutConstraint.activate([
            // Logo on the left
            logoImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            logoImageView.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            logoImageView.widthAnchor.constraint(equalToConstant: 60),
            logoImageView.heightAnchor.constraint(equalToConstant: 60),

            // Title
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: logoImageView.trailingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),

            // Subtitle
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            subtitleLabel.leadingAnchor.constraint(equalTo: logoImageView.trailingAnchor, constant: 12),
            subtitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),

            // Description
            descriptionLabel.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 4),
            descriptionLabel.leadingAnchor.constraint(equalTo: logoImageView.trailingAnchor, constant: 12),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),

            // Open button
            openButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 8),
            openButton.leadingAnchor.constraint(equalTo: logoImageView.trailingAnchor, constant: 12),
            openButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12)
        ])
    }
    func configure(title: String, subtitle: String, description: String) {
          titleLabel.text = title
          subtitleLabel.text = subtitle
          descriptionLabel.text = description
          
      }
}
