//
//  main.swift
//  FSA
//
//  Created by Blake Lockley on 26/03/2016.
//  Copyright © 2016 Blake Lockley. All rights reserved.
//

import Foundation

main:
  while true {
    print("Creating new FSA  0 1 *")
    print("-----------------------")
    
    //TODO: Input should be editable ie. states can be amened if need be
    //TODO: Take inout from a file.
    
    var inputs = [Pseudo]()
    var largestTransition = 0 //Holds how many more states to be made.
    
    while true {
      guard let str = input(message: "Creating State #\(inputs.count) ") else {
        print("Issue with string.")
        continue
      }
      
      //TODO: Use regex here, given a bad input the program will most likely crash, this needs to be handled.
      let tokens = str.componentsSeparatedByString(" ")
      let t0 = Int(tokens[0])!, t1 = Int(tokens[1])!
      let accepting = tokens.contains("*")
      inputs.append((t0: t0, t1: t1, accept: accepting))
      
      largestTransition = max(max(t0, t1), largestTransition)
      if inputs.count > largestTransition {
        break
      }
    }
    
    //We need to create all the states first before we assign to them as each transition is a reference.
    //TODO: This could be improved for example, intit a machine with number of states, then pass in array of Pseduo to init states correctly.
    var states = [State]()
    for (i, _) in inputs.enumerate() {
      states.append(State(n: i))
    }
    for (i, input) in inputs.enumerate() {
      states[i].t0 = states[input.t0]
      states[i].t1 = states[input.t1]
      states[i].accept = input.accept
    }
    let machine = FSA(states: states)
    
    let eqStates = machine.eqStates()
    print("Equivalent States: \(eqStates.count)")
    for eqs in machine.eqStates() {
      print(eqs)
    }
    
    print("Input string to test (n for new machine.)")
    
    while true {
      guard let str = input(message: "Input: ") else {
        print("Issue with string!")
        continue
      }
      
      if str == "n" {
        continue main
      }
      
      let invalid = str.characters.contains({ (c: Character) in
        let s = String(c)
        return s != String(0) && s != String(1) //TODO: Regex!!!!
      })
      if invalid {
        print("Invalid string!")
        continue
      }
      
      print(machine.run(str) ? "ACCEPT" : "REJECT")
      machine.resetState()
    }
}