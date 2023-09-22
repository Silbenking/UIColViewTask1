//
//  ImageViewController.swift
//  UIColViewTask1
//
//  Created by Сергей Сырбу on 20.09.2023.
//

import UIKit
import SnapKit

class ImageViewController: UIViewController {

    let imageView: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 300, height: 300))
            make.center.equalToSuperview()
        }
        
      
    }
    

   
    

}
