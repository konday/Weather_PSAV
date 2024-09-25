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
    
   // let infoData = ["New York", "Boston", "New Jersy"]
    
    //var filteredData: [String] = []
    
    var isSearchBarEmpty: Bool{
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    let searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        return searchController
    }()
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.register(CityTableViewCell.self, forCellReuseIdentifier: "cell")
        table.translatesAutoresizingMaskIntoConstraints = false
        table.dataSource = self
        table.delegate = self
        return table
    }()
    
    private lazy var closeButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("Close", for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private var viewModel: SearchViewModel
    
    init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        
        view.addSubview(tableView)
        
        navigationItem.searchController = searchController
        navigationItem.hidesBackButton = true
        navigationItem.title = "Weather"
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "ellipsis.circle"),style: .plain, target: self, action: #selector(showMenue))
        navigationController?.navigationBar.prefersLargeTitles = true
        
        view.backgroundColor = .gray
                
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo:  view.bottomAnchor)
        ])
        // Do any additional setup after loading the view.
    }
    
//    func searchedData(data: String) {
//        filteredData = viewModel.infoData.filter{(text: String) -> Bool in
//            return text.lowercased().hasPrefix(data.lowercased())
//            }
//        tableView.reloadData()
//    }
    
    @objc func showMenue() {
        print ("Show Menue")
    }
    
}
    
// MARK: UITableViewDataSource
extension SearchViewController: UITableViewDataSource {
    func tableView(_ tabCity: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getData().count
    }
    
    func tableView(_ tabCity: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tabCity.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CityTableViewCell
        else {return UITableViewCell()}
       // let isEmpty = searchController.searchBar.text?.isEmpty ?? true
        cell.setup(title: viewModel.getData()[indexPath.row])
        return cell
    }
}

// MARK: UITableViewDelegate
extension SearchViewController: UITableViewDelegate {
    func tableView(_ tabCity: UITableView, didSelectRowAt indexPath: IndexPath) {
        let city = viewModel.getData()[indexPath.row]
        delegate?.citySelectByUser(city: city)
        navigationController?.popViewController(animated: true)
    }
}

// MARK: UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        viewModel.searchedData(data: searchBar.text ?? "")
    }
}

// MARK: SearchViewController
extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        viewModel.searchedData(data: searchController.searchBar.text ?? "")
    }
}

extension SearchViewController: SearchViewModelDelegate{
    func dataLoaded () {
        tableView.reloadData()
    }
}
