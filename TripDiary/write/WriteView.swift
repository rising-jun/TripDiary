//
//  WriteView.swift
//  TripDiary
//
//  Created by 김동준 on 2021/05/24.
//

import Foundation
import UIKit
import SnapKit

class WriteView: BaseView{
    
    lazy var choosePhoto = UIButton()
    lazy var contents = UITextField()
    
    override func setup() {
        super.setup()
        backgroundColor = .systemGray5
        
        addSubViews(choosePhoto, contents)
        choosePhoto.setTitle("사진선택", for: .normal)
        choosePhoto.setTitleColor(.blue, for: .normal)
        choosePhoto.snp.makeConstraints { make in
            make.top.equalTo(self).offset(100)
            make.leading.equalTo(self).offset(30)
            make.width.height.equalTo(100)
        }
        
        contents.backgroundColor = .white
        contents.layer.cornerRadius = 10
        contents.snp.makeConstraints { make in
            make.top.equalTo(choosePhoto.snp.bottom).offset(10)
            make.leading.equalTo(self).offset(15)
            make.trailing.equalTo(self).offset(-15)
            make.height.equalTo(200)
        }
    
        
    
    }
    
}
