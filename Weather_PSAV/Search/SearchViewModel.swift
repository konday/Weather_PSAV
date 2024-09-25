//
//  SearchViewModel.swift
//  Weather_PSAV
//
//  Created by Andrei Kondaurov on 9/23/24.
//

import UIKit

protocol SearchViewModelDelegate: AnyObject {
    func dataLoaded()
}

class SearchViewModel {
    
    weak var delegate: SearchViewModelDelegate?
    
    private let infoData = ["New York", "Boston", "New Jersy"]
    
    private var filteredData: [String] = []
    
    func didLoad(){
        delegate?.dataLoaded()
    }
    
    func searchedData(data: String) {
        filteredData = infoData.filter{(text: String) -> Bool in
            return text.lowercased().hasPrefix(data.lowercased())
            }
        delegate?.dataLoaded()
    }
    
    func getData() -> [String]{
        return filteredData.isEmpty ? infoData : filteredData
    }
    
}
