//
//  CameraDelegate.swift
//  TripDiary
//
//  Created by 김동준 on 2021/05/30.
//

import Foundation
import UIKit
import RxSwift

class CameraDelegate: NSObject{
    var imageVC = UIImagePickerController()
    var imagePublish: PublishSubject<UIImage>?
}

extension CameraDelegate: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            imagePublish?.onNext(image)
        }
        
    }
    
    
    
}
