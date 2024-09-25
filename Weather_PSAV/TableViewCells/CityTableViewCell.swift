//
//  CityTableViewCell.swift
//  Weather_PSAV
//
//  Created by Andrei Kondaurov on 9/24/24.
//

import UIKit

class CityTableViewCell: UITableViewCell {
    
    private var cityNamelabel: UILabel = {
        let name = UILabel()
        name.text = ""
        name.textColor = .black
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
        
    }
        
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
        
    }
    
    private func commonInit() {
        selectionStyle = .none
        setupSubViews()
        setupConstraints()
    }
    
    private func setupSubViews() {
        contentView.addSubview(cityNamelabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            cityNamelabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            cityNamelabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
                                    ])
    }
    
    func setup(title: String) {
        cityNamelabel.text = title
    }
}
