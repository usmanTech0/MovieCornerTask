//
//  ObservableObject.swift
//  MovieCorner
//
//  Created by M Usman on 21/11/2023.
//

import Foundation

final class ObservableObject <T> {
    var value : T {
        didSet{
            listener?(value)
        }
    }
    private var listener : ((T)->Void)?
    init(_ value: T) {
        self.value = value
    }
    func bind(_ listener: @escaping(T)->Void){
        self.listener = listener
    }
}
