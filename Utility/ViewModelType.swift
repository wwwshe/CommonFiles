//
//  ViewModelType.swift
//  DDota
//
//  Created by jungwook on 2019/11/26.
//  Copyright © 2019 jungwook. All rights reserved.
//

import Foundation

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}
