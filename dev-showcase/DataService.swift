//
//  DataService.swift
//  dev-showcase
//
//  Created by 안수근 on 2016. 2. 11..
//  Copyright © 2016년 ansugeun.k. All rights reserved.
//

import Foundation
import Firebase

class DataService {
    static let ds = DataService()
    
    
    private var _REF_BASE = Firebase(url: "https://dev-show.firebaseio.com")
    
    var REF_BASE:Firebase {
        return _REF_BASE
    }
    
}