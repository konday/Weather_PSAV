//
//  CityTableViewCell.swift
//  Weather_PSAV
//
//  Created by Andrei Kondaurov on 9/24/24.
//

import UIKit

class CityTableViewCell: UITableViewCell {
    
    private var cityBlock: UIView = {
        let block =  UIView()
        block.backgroundColor = .red
        block.layer.cornerRadius = 12
        block.layer.borderColor = UIColor.clear.withAlphaComponent(0).cgColor
        block.layer.borderWidth = 4
        block.translatesAutoresizingMaskIntoConstraints = false
        return block
    }()
    
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
        contentView.addSubview(cityBlock)
        contentView.addSubview(cityNamelabel)
        
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            cityBlock.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            cityBlock.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 8),
            cityBlock.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 4),
            cityBlock.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -4),
            cityNamelabel.centerXAnchor.constraint(equalTo: cityBlock.centerXAnchor),
            cityNamelabel.centerYAnchor.constraint(equalTo: cityBlock.centerYAnchor)
                                    ])
    }
    
    func setup(title: String) {
        cityNamelabel.text = title
    }
}
