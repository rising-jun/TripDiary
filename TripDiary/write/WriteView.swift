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
    
    lazy var addPhotoBtn = UIButton()
    lazy var contents = UITextView()
    lazy var publicSet = UISwitch()
    lazy var publicLabel = UILabel()
    
    let categoryLayout = UICollectionViewFlowLayout()
    lazy var categorySet = UICollectionView(frame: .zero, collectionViewLayout: categoryLayout)
    lazy var dateSet = UIDatePicker()
    
    
    override func setup() {
        super.setup()
        backgroundColor = .systemGray5
        
        addSubViews(addPhotoBtn, contents, publicSet, categorySet, dateSet, publicLabel)

        addPhotoBtn.backgroundColor = .blue
        addPhotoBtn.snp.makeConstraints { make in
            make.top.equalTo(self).offset(200)
            make.width.equalTo(50)
            make.height.equalTo(30)
            make.leading.equalTo(15)
        }
        
        contents.textAlignment = .left
        contents.font = .systemFont(ofSize: 18)
        contents.backgroundColor = .white
        contents.layer.cornerRadius = 10
        contents.snp.remakeConstraints { make in
            make.top.equalTo(addPhotoBtn.snp.bottom).offset(10)
            make.leading.equalTo(self).offset(15)
            make.trailing.equalTo(self).offset(-15)
            make.height.equalTo(150)
        }
    
        
        dateSet.translatesAutoresizingMaskIntoConstraints = false
        dateSet.preferredDatePickerStyle = .wheels
        dateSet.snp.makeConstraints { make in
            make.top.equalTo(contents.snp.bottom).offset(10)
            make.width.equalTo(281)
            make.leading.equalTo(self).offset(10)
            make.height.equalTo(100)
        }
        
        categorySet.backgroundColor = .yellow
        categorySet.snp.makeConstraints { make in
            make.top.equalTo(dateSet.snp.bottom).offset(10)
            make.leading.equalTo(self).offset(15)
            make.trailing.equalTo(self).offset(-15)
            make.height.equalTo(50)
        }
        
        publicSet.backgroundColor = .green
        publicSet.snp.makeConstraints { make in
            make.top.equalTo(categorySet.snp.bottom).offset(20)
            make.trailing.equalTo(self).offset(-15)
            make.width.equalTo(80)
        }
    
        
        publicLabel.text = "공개"
        publicLabel.snp.makeConstraints { make in
            make.centerY.equalTo(publicSet)
            make.trailing.equalTo(publicSet.snp.leading).offset(-10)
            make.height.equalTo(80)
            make.width.equalTo(50)
        }
        
    }
    
}
