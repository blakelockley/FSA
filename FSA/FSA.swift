//
//  FSA.swift
//  FSA
//
//  Created by Blake Lockley on 26/03/2016.
//  Copyright © 2016 Blake Lockley. All rights reserved.
//

import Foundation

class FSA {
  let states: [State]
  private var state: State
  
  init(states: [State]) {
    if states.isEmpty {
      fatalError("FSA must have atleast one state")
    }
    
    self.states = states
    self.state = states.first!
  }
  
  func resetState() {
    state = states.first!
  }
  
  func run(str: String) -> Bool {
    let inputs = str.characters.map({Int(String($0))!})
    for input in inputs {
      state = state.newStateForInput(input)
    }
    return state.accept
  }
  
  func eqStates() -> [[State]] {
    var eqPrevious = [Int]()
    var eqCurrent = states.map({$0.accept! ? 1 : 0})
    
    while eqCurrent != eqPrevious {
      eqPrevious = eqCurrent
      eqCurrent = []
      
      let temps: [Pseudo] = states.map({(state: State) in
        let t0 = eqPrevious[states.indexOf(state.t0)!]
        let t1 = eqPrevious[states.indexOf(state.t1)!]
        return (t0: t0, t1: t1, accept: state.accept)
      })
      
      var checked = [Pseudo]()
      var current = 0
      
      for temp in temps {
        if let idx = checked.indexOf({$0 == temp}) {
          eqCurrent.append(idx)
          continue
        }
        checked.append(temp)
        eqCurrent.append(current)
        current += 1
      }
    }
    
    var eqStates = [[State]]()
    for (i, eq) in eqCurrent.enumerate() {
      if eq == eqStates.count {
        eqStates.append([states[i]])
      } else {
        eqStates[eq].append(states[i])
      }
    }
    
    return eqStates.filter({$0.count > 1})
  }
  
  //TODO: Method to return a FSA in standard form using the result of the eqStates method.
}