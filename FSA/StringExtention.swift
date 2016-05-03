//
//  StringExtention.swift
//  FSA
//
//  Created by Blake Lockley on 28/04/2016.
//  Copyright © 2016 Blake Lockley. All rights reserved.
//

import Foundation

extension String {
  //http://stackoverflow.com/questions/25138339/nsrange-to-rangestring-index
  func rangeFromNSRange(nsRange : NSRange) -> Range<String.Index>? {
    let from16 = utf16.startIndex.advancedBy(nsRange.location, limit: utf16.endIndex)
    let to16 = from16.advancedBy(nsRange.length, limit: utf16.endIndex)
    if let from = String.Index(from16, within: self),
      let to = String.Index(to16, within: self) {
      return from ..< to
    }
    return nil
  }
}