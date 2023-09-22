//
//  HeaderReusableView.swift
//  UIColViewTask1
//
//  Created by Сергей Сырбу on 20.09.2023.
//

import UIKit
    //создание хедера
class HeaderReusableView: UICollectionReusableView {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.layer.borderColor = UIColor.green.cgColor
        label.layer.borderWidth = 2
        label.layer.cornerRadius = 5
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 24)
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame:frame)
         setupTitle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented") // если натсраиваем элемент через сториборд
    }
    func setupTitle() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8))
        }
    }
}
