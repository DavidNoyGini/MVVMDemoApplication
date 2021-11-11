//
//  FirstVM.swift
//  MVVMDemoApplication
//
//  Created by David Noy on 10/11/2021.
//

import Foundation

class FirstVM: Routing {
    
    var router: Router?
    
    init(router: Router)
    {
        self.router = router
    }
    
    func startTapped(text: String?)
    {
        router?.moveTo(with: .toSecondVC(text: text))
    }
    
    func dataPassedTapped(text: String?)
    {
        router?.moveTo(with: .toThirdVC(text: text))
    }
        
}
