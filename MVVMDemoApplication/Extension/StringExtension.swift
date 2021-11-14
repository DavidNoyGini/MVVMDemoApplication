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
    
    var toCharArray: [Character]
    {
        return Array(self)
    }
    
    var isLetters: Bool
    {
        let charArray = self.toCharArray
        
        for index in 0..<charArray.count
        {
            if !charArray[index].isLetter
            {
                return false
            }
        }
        return true
    }
    
}
