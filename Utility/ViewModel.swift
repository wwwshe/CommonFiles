//
//  ViewModel.swift
//  Created by jungwook on 2019/12/03.
//  Copyright © 2019 jungwook. All rights reserved.
//

import Foundation



class ViewModel : ViewModelType{
    struct Input {
       
    }
    struct Output {
    
    }
    private let networking: NetworkManager
   
    init() {
        self.networking = NetworkManager.shared
    }
    func transform(input: Input) -> Output {
       
        return Output()
    }
    
}
