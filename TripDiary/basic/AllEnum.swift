//
//  AllEnum.swift
//  TripDiary
//
//  Created by 김동준 on 2021/05/24.
//

enum ViewLifeState{
    case viewWillAppear
}

enum ReadyState{
    case ready
    case yet
}

enum RealmState{
    case read
    case write
    case modify
    case delete
    case none
}

enum VCState{
    case tripView
    case writeView
}
