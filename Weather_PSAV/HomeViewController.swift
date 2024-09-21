//
//  HomeViewController.swift
//  Weather_PSAV
//
//  Created by Andrei Kondaurov on 9/17/24.
//

import UIKit

class HomeViewController: UIViewController {
    
    private lazy var nameOfCity: UILabel = {
        let name = UILabel()
        name.text = ""
        name.textColor = .white
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
    private lazy var mapButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("Map", for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private lazy var searchButton: UIButton = {
        let btn = UIButton(type: .custom)
        let symbolImage = UIImage(systemName: "map")
        btn.setTitle("Search", for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .lightGray
        
        view.addSubview(nameOfCity)
        view.addSubview(mapButton)
        view.addSubview(searchButton)
        
        mapButton.addTarget(self, action: #selector(mapAction), for: .touchUpInside)
        searchButton.addTarget(self, action: #selector(searchAction), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            nameOfCity.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameOfCity.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            mapButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            mapButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            searchButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            searchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        // Do any additional setup after loading the view.
    }
    @objc private func mapAction() {
        let mapVC = MapViewController()
        present(mapVC, animated: true)
    }
    
    @objc private func searchAction() {
        let searchVC = SearchViewController()
//        searchVC.modalPresentationStyle = .fullScreen
//        present(searchVC, animated: true)
        searchVC.delegate = self
        navigationController?.pushViewController(searchVC, animated: true)
    }

}

extension HomeViewController: SearchViewControllerDelegate {
    func citySelectByUser(city: String) {
        nameOfCity.text = city
    }
}
