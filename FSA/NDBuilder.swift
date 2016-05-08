//
//  NDBuilder.swift
//  FSA
//
//  Created by Blake Lockley on 8/05/2016.
//  Copyright © 2016 Blake Lockley. All rights reserved.
//

import Foundation

class NDBuilder {
  
  static func NDStatesFromRegex(regex: Expression) -> NDState {
    var _current = -1
    var current: Int { get { _current += 1; return _current }}
    let start = NDState(n: current)
    
    /**
     Creates new states from the regex supplied. The regex will be recursivly evalutaed and accessiable from the provided state.
     - parameters:
        - regex: The expression to be evaluated.
        - fromState: The state to which the transitions outlined in the regex will stem from.
     - returns:
        The last "appending state" from evaluating the expression. This means subsequent states would be appended to this state if the expression were to continue. If this is the last state in the expression then it would be made accepting.
     */
    func translateRegex(regex: Expression, fromState state: NDState) -> NDState {
      switch regex {
        
      case .Zero:
        let new = NDState(n: current)
        state.t0 = new
        return new
      
      case .One:
        let new = NDState(n: current)
        state.t1 = new
        return new
        
      case .And(let a, let b):
        let first = translateRegex(a, fromState: state)
        let second = translateRegex(b, fromState: first)
        return second
        
      case .Or(let a, let b):
        let first = NDState(n: current)
        let second = NDState(n: current)
        
        let firstEnd = translateRegex(a, fromState: first)
        let secondEnd = translateRegex(b, fromState: second)
        
        state.tn.appendContentsOf([first, second])
        
        let end = NDState(n: current)
        firstEnd.tn.append(end)
        secondEnd.tn.append(end)
        
        return end
        
      case .Multiple(let exp):
        let end = translateRegex(exp, fromState: state)
        end.tn.append(state)
        return end
        
      case .Kleene(let exp):
        let end = translateRegex(exp, fromState: state)
        end.tn.append(state)
        return state
      }
      
    }
    
    //Create new states and return final state, which we want to accept.
    translateRegex(regex, fromState: start).accept = true
    
    return start
  }
}