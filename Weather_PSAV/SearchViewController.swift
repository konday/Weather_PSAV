//
//  SearchViewController.swift
//  Weather_PSAV
//
//  Created by Andrei Kondaurov on 9/17/24.
//
import UIKit

class SearchViewController: UIViewController {
    
    let infoData = ["New York", "Boston", "New Jersy"]
    
    var filteredData: [String] = []
    
    var isSearchBarEmpty: Bool{
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    let searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        return searchController
    }()
    
    private lazy var closeButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("Close", for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    var tableView = UITableView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        
        navigationItem.searchController = searchController
        navigationItem.hidesBackButton = true
        navigationItem.title = "Weather"
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "ellipsis.circle"),style: .plain, target: self, action: #selector(showMenue))
//        let backButton = UIBarButtonItem(systemItem: .camera)
//        let systemButton = UIBarButtonItem(systemItem: .stop)
//        navigationItem.rightBarButtonItems = [backButton, systemButton]
        navigationController?.navigationBar.prefersLargeTitles = true
        
        view.backgroundColor = .gray
        
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
    
    func searchedData(data: String){
        filteredData = infoData.filter{(text: String) -> Bool in
            return text.lowercased().contains(data.lowercased())
            }
        tableView.reloadData()
    }
    
    @objc func showMenu(){
        print ("Show Menu")
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
    
    @objc private func showMenue() {
        print("closeBtn")
    }
}
    
//    @objc private func closeAction() {
//        print("closeBtn")
////        dismiss(animated: true)
//        navigationController?.popViewController(animated: true)
//    }



extension SearchViewController: UITableViewDataSource {
    func tableView(_ tabCity: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearchBarEmpty ? infoData.count : filteredData.count
    }
    
    func tableView(_ tabCity: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tabCity.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let isEmpty = searchController.searchBar.text?.isEmpty ?? true
        cell.textLabel?.text = isEmpty ? infoData[indexPath.row] : filteredData[indexPath.row]
        return cell
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tabCity: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        searchedData(data: searchBar.text ?? "")
    }
}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        searchedData(data: searchController.searchBar.text ?? "")
    }
}
