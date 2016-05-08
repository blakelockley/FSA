//
//  NDState.swift
//  FSA
//
//  Created by Blake Lockley on 6/05/2016.
//  Copyright © 2016 Blake Lockley. All rights reserved.
//

import Foundation

class NDState: State {
  var tn = [NDState]()
  
  override init(n: Int) {
    super.init(n: n)
    self.accept = false
  }
}