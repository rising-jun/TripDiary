//
//  CategoryCollection.swift
//  TripDiary
//
//  Created by 김동준 on 2021/05/25.
//

import Foundation
import UIKit

class CategoryCollection: NSObject{
    private var categoryArr = ["혼자여행","가족여행","우정여행"]
    public var categoryArr_: [String]{
        get{
            return categoryArr
        }set(val){
            categoryArr = val
        }
    }
    
}

extension CategoryCollection: UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "category", for: indexPath) as! CategoryCell
        cell.grayView.snp.updateConstraints { (make) in
            make.width.equalTo(categoryArr[indexPath.row].count * 15 + 22)
        }
        
        cell.tagLabel.snp.updateConstraints { (make) in
            make.width.equalTo(categoryArr[indexPath.row].count * 15)
        }
        cell.tagLabel.text = categoryArr[indexPath.row]
        
        cell.awakeFromNib()
        return cell
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    
    // 옆 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    // cell 사이즈( 옆 라인을 고려하여 설정 )
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.row == 0{
            let size = CGSize(width: categoryArr[indexPath.row].count * 15 + 22, height: 45)
            return size
        }else{
            let size = CGSize(width: categoryArr[indexPath.row].count * 15 + 22, height: 45)
            return size
        }
    }
    
}
