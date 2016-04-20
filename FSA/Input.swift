//
//  Input.swift
//  FSA
//
//  Created by Blake Lockley on 26/03/2016.
//  Copyright © 2016 Blake Lockley. All rights reserved.
//

import Foundation

func input(message message: String? = nil) -> String? {
  if let mes = message {
    print(mes, terminator: "")
  }
  let keyboard = NSFileHandle.fileHandleWithStandardInput()
  let inputData = keyboard.availableData
  let rawString = NSString(data: inputData, encoding:NSUTF8StringEncoding)
  return rawString?.stringByTrimmingCharactersInSet(NSCharacterSet.newlineCharacterSet())
}