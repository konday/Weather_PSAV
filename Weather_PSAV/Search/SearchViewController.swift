//
//  SearchViewController.swift
//  Weather_PSAV
//
//  Created by Andrei Kondaurov on 9/17/24.
//
import UIKit

protocol SearchViewControllerDelegate: AnyObject {
    func citySelectByUser(city: String)
}

class SearchViewController: UIViewController {
    
    weak var delegate: SearchViewControllerDelegate?
    
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
    
    private lazy var cityTable: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    private lazy var closeButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("Close", for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    var tableView = UITableView()
    
    private var viewModel: SearchViewModel
    
    init(viewModel: SearchViewModel) {
        super.init(nibName: nil, bundle: <#T##Bundle?#>)
    }
    
    required init?(code: NSCoder ) {
        fatalError("init(coder:) has not been implement")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTable()
        
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        
        view.addSubview(cityTable)
        
        navigationItem.searchController = searchController
        navigationItem.hidesBackButton = true
        navigationItem.title = "Weather"
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "ellipsis.circle"),style: .plain, target: self, action: #selector(showMenue))
        navigationController?.navigationBar.prefersLargeTitles = true
        
        view.backgroundColor = .gray
                
        NSLayoutConstraint.activate([
            cityTable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            cityTable.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            cityTable.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            cityTable.bottomAnchor.constraint(equalTo:  view.bottomAnchor)
        ])
        // Do any additional setup after loading the view.
    }
    
    func searchedData(data: String) {
        filteredData = infoData.filter{(text: String) -> Bool in
            return text.lowercased().hasPrefix(data.lowercased())
            }
        cityTable.reloadData()
    }
    
    @objc func showMenue() {
        print ("Show Menue")
    }
    
    private func setupTable() {
        cityTable.dataSource = self
        cityTable.delegate = self
        cityTable.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
}
    
// MARK: SearchViewController
extension SearchViewController: UITableViewDataSource {
    func tableView(_ tabCity: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearchBarEmpty ? infoData.count : filteredData.count
    }
    
    func tableView(_ tabCity: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tabCity.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let isEmpty = searchController.searchBar.text?.isEmpty ?? true
        cell.textLabel?.text = isSearchBarEmpty ? infoData[indexPath.row] : filteredData[indexPath.row]
        return cell
    }
}

// MARK: UITableViewDelegate
extension SearchViewController: UITableViewDelegate {
    func tableView(_ tabCity: UITableView, didSelectRowAt indexPath: IndexPath) {
        let city = isSearchBarEmpty ? infoData[indexPath.row] : filteredData[indexPath.row]
        delegate?.citySelectByUser(city: city)
        print(isSearchBarEmpty ? infoData[indexPath.row] : filteredData[indexPath.row])
        navigationController?.popViewController(animated: true)
    }
}

// MARK: UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        searchedData(data: searchBar.text ?? "")
    }
}

// MARK: SearchViewController
extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        searchedData(data: searchController.searchBar.text ?? "")
    }
}
