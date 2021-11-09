//
//  StringExtension.swift
//  MVVMDemoApplication
//
//  Created by David Noy on 09/11/2021.
//

import Foundation

extension String
{
  var isInt: Bool
  {
    return Int(self) != nil
  }
}
