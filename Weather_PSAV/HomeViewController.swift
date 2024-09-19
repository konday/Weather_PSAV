//
//  HomeViewController.swift
//  Weather_PSAV
//
//  Created by Andrei Kondaurov on 9/17/24.
//

import UIKit

class HomeViewController: UIViewController {
    
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
        
        view.addSubview(mapButton)
        view.addSubview(searchButton)
        
        mapButton.addTarget(self, action: #selector(mapAction), for: .touchUpInside)
        searchButton.addTarget(self, action: #selector(searchAction), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            mapButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            mapButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            searchButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            searchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        // Do any additional setup after loading the view.
    }
    @objc private func mapAction() {
        let mapVC = MapViewController()
        //searchVC.modalPresentationStyle = .fullScreen
        present(mapVC, animated: true)
    }
    
    @objc private func searchAction() {
        let searchVC = SearchViewController()
        //searchVC.modalPresentationStyle = .fullScreen
//        present(searchVC, animated: true)
        navigationController?.pushViewController(searchVC, animated: true)
    }

}

