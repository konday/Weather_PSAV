//
//  SearchViewModel.swift
//  Weather_PSAV
//
//  Created by Andrei Kondaurov on 9/23/24.
//

import UIKit

protocol SearchViewModelDelegate: AnyObject {
    func getData()
}

class SearchViewModel {
    
    weak var delegate: SearchViewModelDelegate?
    
    let infoData = ["New York", "Boston", "New Jersy"]
    
    var filteredData: [String] = []
    
    func didLoad(){
        
    }
}
