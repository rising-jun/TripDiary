//
//  CameraDelegate.swift
//  TripDiary
//
//  Created by 김동준 on 2021/05/30.
//

import Foundation
import UIKit
class CameraDelegate: NSObject{
    var imageVC = UIImagePickerController()
}

extension CameraDelegate: UIImagePickerControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
    }
}
