//
//  PhotoCell.swift
//  UIColViewTask1
//
//  Created by Сергей Сырбу on 20.09.2023.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) { // если захотим инициализировать через сториборд ячейку
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() { // метод, настраивающий ячейку
        contentView.addSubview(imageView)
        imageView.layer.cornerRadius = 50
        imageView.contentMode = .scaleAspectFill
        clipsToBounds = true // чтобы не выходили фото за пределы вью
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
//            make.size.equalTo(CGSize(width: 150, height: 150))
        }
        
    }
}
