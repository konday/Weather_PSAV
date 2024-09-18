//
//  HomeViewController.swift
//  Weather_PSAV
//
//  Created by Andrei Kondaurov on 9/17/24.
//

import UIKit

class HomeViewController: UIViewController {
    
    private lazy var leftButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("Map", for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private lazy var rightButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("Search", for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .lightGray
        
        view.addSubview(leftButton)
        view.addSubview(rightButton)
        
        leftButton.addTarget(self, action: #selector(leftAction), for: .touchUpInside)
        rightButton.addTarget(self, action: #selector(rightAction), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            leftButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            leftButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            rightButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            rightButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        // Do any additional setup after loading the view.
    }
    @objc private func leftAction() {
        let searchVC = MapViewController()
        //searchVC.modalPresentationStyle = .fullScreen
        present(searchVC, animated: true)
    }
    
    @objc private func rightAction() {
        let searchVC = SearchViewController()
        //searchVC.modalPresentationStyle = .fullScreen
        present(searchVC, animated: true)
    }

}

