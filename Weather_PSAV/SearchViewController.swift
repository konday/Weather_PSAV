//
//  SearchViewController.swift
//  Weather_PSAV
//
//  Created by Andrei Kondaurov on 9/17/24.
//
import UIKit

class SearchViewController: UIViewController {
    
    let infoData = ["New York", "Boston", "New Jersy"]
    
    private lazy var closeButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("Close", for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    var tableView = UITableView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .blue
        
//        view.addSubview(closeButton)
//        
//        closeButton.addTarget(self, action: #selector(closeAction), for: .touchUpInside)
//        
//        NSLayoutConstraint.activate([
//            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
//            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
//        ])
        // Do any additional setup after loading the view.
        
        setupTable()
    }
    
    func setupTable() {
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo:  view.bottomAnchor)
            
        ])
    }
    
    
    @objc private func closeAction() {
        print("closeBtn")
//        dismiss(animated: true)
        navigationController?.popViewController(animated: true)
    }
}


extension SearchViewController: UITableViewDataSource {
    func tableView(_ tabCity: UITableView, numberOfRowsInSection section: Int) -> Int {
        return infoData.count
    }
    
    func tableView(_ tabCity: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tabCity.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = infoData[indexPath.row]
        return cell
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tabCity: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}
