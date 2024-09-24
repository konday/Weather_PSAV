//
//  SearchViewController.swift
//  Weather_PSAV
//
//  Created by Andrei Kondaurov on 9/17/24.
//
import UIKit

protocol SearchViewControllerDelegate: AnyObject {
    func citySelectedByUser(city: String)
}

class SearchViewController: UIViewController {
    
    weak var delegate:SearchViewControllerDelegate?
    
    let infoData = ["Los Angeles", "New York", "Miami"]
    
    var filteredData: [String] = []
    
    var isSearchBarEmpty: Bool {
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
    
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        
        navigationItem.searchController = searchController
        navigationItem.hidesBackButton = true
        navigationItem.title = "Weather"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "ellipsis.circle"), style: .plain, target: self, action: #selector(showMenu))
        
        //        let backButton = UIBarButtonItem(systemItem: .camera)
        //        let systemButton = UIBarButtonItem(systemItem: .stop)
        //        navigationItem.rightBarButtonItems = [backButton, systemButton]
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.hidesSearchBarWhenScrolling = false
        
        view.backgroundColor = .blue

        setupTable()
    }
    
    func searchedData (data:String) {
        filteredData = infoData.filter{(text: String) -> Bool in
            return text.lowercased().contains(data.lowercased())
        }
        tableView.reloadData()
    }
    
    @objc func showMenu(){
        print ("Show Menu")
    }
    
    //MARK: fix
    func setupTable() {
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

//MARK: UITableViewDataSource
extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearchBarEmpty ? infoData.count : filteredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = isSearchBarEmpty ? infoData[indexPath.row] : filteredData[indexPath.row]
        return cell
    }
}

// MARK: UITableViewDelegate
extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let city = isSearchBarEmpty ? infoData[indexPath.row] : filteredData[indexPath.row]
        delegate?.citySelectedByUser(city: city)
        print(city)
        navigationController?.popViewController(animated: true)
    }
}

//MARK: UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        searchedData(data: searchBar.text ?? "")
    }
}
 
// MARK: UISearchResultsUpdating
extension SearchViewController : UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        searchedData(data: searchController.searchBar.text ?? "")
    }
}
