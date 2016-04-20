//
//  State.swift
//  FSA
//
//  Created by Blake Lockley on 28/03/2016.
//  Copyright © 2016 Blake Lockley. All rights reserved.
//

import Foundation

//Pseudo Represents a State but without a number or references to other states with Ints inseatd.
typealias Pseudo = (t0: Int, t1: Int, accept: Bool)

///State Represents the internal state of a FSA
class State: Equatable, CustomStringConvertible {
  let n: Int
  weak var t0: State!
  weak var t1: State!
  var accept: Bool!
  
  init(n: Int) {
    self.n = n
  }
  
  func newStateForInput(input: Int) -> State {
    return (input == 0 ? t0 : t1)!
  }
  
  var description: String {
    return "State: #\(n)"//, t0: \(t0.num), t1: \(t1.num)" + (accepting ? " *" : "")
  }
}

//MARK: Equatable
func == (lhs: State, rhs: State) -> Bool {
  return lhs.t0 === rhs.t0
    && lhs.t1   === rhs.t1
    && lhs.accept == rhs.accept
}

func == (lhs: Pseudo, rhs: Pseudo) -> Bool {
  return lhs.t0 == rhs.t0
    && lhs.t1 == rhs.t1
    && lhs.accept == rhs.accept
}