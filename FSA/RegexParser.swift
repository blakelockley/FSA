//
//  RegexParser.swift
//  FSA
//
//  Created by Blake Lockley on 3/05/2016.
//  Copyright © 2016 Blake Lockley. All rights reserved.
//

import Foundation

/**
 Represents a regular expression recursively composed of other expressions.
 Example: (10|01)*(111|0)+ -> And(Kleene(Or(And(One, Zero), And(Zero, One))), Multiple(Or(And(And(One, One), One), Zero)))
 */
indirect enum Expression {
  case Zero                         //0
  case One                          //1
  case Or(Expression, Expression)   //<expression>|<expression>
  case And(Expression, Expression)  //<expression><expression>
  case Multiple(Expression)         //<expression>+
  case Kleene(Expression)           //<expression>*
  
  //Any regular expresion
  private static func matchInPattern(pattern: String, forString str: String) -> Bool {
    let regex = try! NSRegularExpression(pattern: pattern, options: [])
    let matches = regex.matchesInString(str, options: [], range: NSMakeRange(0, str.characters.count))
    return matches.count == 1
  }
  
  private static func stripParans(inout str: String) {
    if matchInPattern("^\\(.*\\)$", forString: str) {
      str.removeAtIndex(str.startIndex)
      str.removeAtIndex(str.endIndex.predecessor())
    }
  }
  
  static func new(str: String) -> Expression {
    var str = str
    
    //Expressions inside parans are much like the clothes on a beautiful woman and are much better stripped off.
    stripParans(&str)
    
    if str == "0" {
      return .Zero
    }
    if str == "1" {
      return .One
    }
    
    if matchInPattern("^(0|1|\\(.*\\))\\+$", forString: str) {
      str.removeAtIndex(str.endIndex.predecessor())
      stripParans(&str)
      return .Multiple(new(str))
    }
    if matchInPattern("^(0|1|\\(.*\\))\\*$", forString: str) {
      str.removeAtIndex(str.endIndex.predecessor())
      stripParans(&str)
      return .Kleene(new(str))
    }
    
    //Potential issue with nested ors but this should never be the case in a decent regex
    //(00|(01|10)) is the same as (00|01|10) so thats fine, but...
    //FIXME: (00|11)|(01|10) would split at the first pipe not the second.. I think, test this!
    if matchInPattern("^.*\\|.*$", forString: str) {
      let split = str.rangeOfString("|")!
      let first = str.substringToIndex(split.startIndex)
      let second = str.substringFromIndex(split.endIndex)
      return .Or(new(first), new(second))
    }

    let and = try! NSRegularExpression(pattern: "(0|1|\\(.*\\))(\\*|\\+)?", options: [])
    let andMatches = and.matchesInString(str, options: [], range: NSMakeRange(0, str.characters.count))
    if andMatches.count > 1 {
      let first = str.substringWithRange(str.rangeFromNSRange(andMatches.first!.range)!)
      let following = str.substringWithRange(first.endIndex..<str.endIndex)
      return .And(new(first), new(following))
    }
    
    fatalError("Invalid regular expression.")
  }
}