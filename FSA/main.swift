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
    //TODO: Take input from a file.
    
    var inputs = [Pseudo]()
    var largestTransition = 0 //Holds how many more states to be made.
    
    while true {
      guard let str = input(message: "Creating State #\(inputs.count) ") else {
        print("Issue with string.")
        continue
      }
      
      let regex = try! NSRegularExpression(pattern: "^([0-9]+) ([0-9]+)( \\*)?$", options: .CaseInsensitive)
      let matches = regex.matchesInString(str, options: [], range: NSMakeRange(0, str.characters.count))
      
      if matches.count != 1 {
        print("Issue with string format.")
        continue
      }
      
      let tokens = str.componentsSeparatedByString(" ")
      let t0 = Int(tokens[0])!, t1 = Int(tokens[1])!
      let accepting = tokens.contains("*")
      inputs.append((t0: t0, t1: t1, accept: accepting))
      
      largestTransition = max(max(t0, t1), largestTransition)
      if inputs.count > largestTransition {
        break
      }
    }
    
    //We need to create all the states first before we assign to them since each transition is a reference.
    let machine = FSA(pseudos: inputs)
    
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
      
      let regex = try! NSRegularExpression(pattern: "^(0|1)*$", options: .CaseInsensitive)
      let matches = regex.matchesInString(str, options: [], range: NSMakeRange(0, str.characters.count))
      
      if matches.count != 1 {
        print("Invalid string!")
        continue
      }
      
      print(machine.run(str) ? "ACCEPT" : "REJECT")
      machine.resetState()
    }
}