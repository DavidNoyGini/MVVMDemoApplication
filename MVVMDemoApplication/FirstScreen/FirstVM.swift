//
//  FirstVM.swift
//  MVVMDemoApplication
//
//  Created by David Noy on 10/11/2021.
//

import Foundation

protocol FirstVMActivityIndicator: AnyObject {
    func showActivityIndicator()
    func dismissActivityIndicator()
}

class FirstVM: Routing {
    
    var router: Router?
    weak var firstVMActivityIndicatorDelegate: FirstVMActivityIndicator?
    
    init(router: Router)
    {
        self.router = router
    }
    
    func startTapped(text: String?)
    {
        router?.navigate(to: .secondVC(text: text))
    }
    
    func dataPassedTapped(text: String?)
    {
        router?.navigate(to: .thirdVC(text: text))
    }
}

extension FirstVM: ThirdVCActivityIndicator {
    func setActivityIndicatorVisibility(isVisible : Bool)
    {
        if isVisible
        {
            firstVMActivityIndicatorDelegate?.showActivityIndicator()
        } else
        {
            firstVMActivityIndicatorDelegate?.dismissActivityIndicator()
        }
    }
    
}
