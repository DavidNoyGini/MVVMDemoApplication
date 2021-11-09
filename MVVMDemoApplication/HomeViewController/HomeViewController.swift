//
//  HomeViewController.swift
//  MVVMDemoApplication
//
//  Created by David Noy on 03/11/2021.
//

import UIKit

class HomeViewController: UIViewController, Routing {
    
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var dataPassedButton: UIButton!

    var router: Router?
    var searchedString: String?
    
    private var tapIsUnable: Bool = false
    private var tapCount: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpMethod()
    }
    
    private func setUpMethod(){
        
        startButton.configuration?.title = StringsConstans.startButtonTitle
        startButton.configuration?.baseBackgroundColor = .systemYellow
        startButton.configuration?.baseForegroundColor = .black
        
        dataPassedButton.isHidden = true
        dataPassedButton.layer.shadowColor = UIColor.gray.cgColor
        dataPassedButton.layer.shadowOffset = CGSize(width: 5.0, height: 10.0)
        dataPassedButton.layer.shadowOpacity = 1.0
        dataPassedButton.layer.shadowRadius = 4.0
        dataPassedButton.layer.masksToBounds = false

        dataPassedButton.configuration?.baseBackgroundColor = .green
        dataPassedButton.configuration?.baseForegroundColor = .black
       
    }
    
    @IBAction func startTapped(_ sender: UIButton) {
        router?.eventOccurred(with: .toSecondVC)
    }
    
    @IBAction func dataPassedTapped(_ sender: UIButton) {
        router?.eventOccurred(with: .toThirdVC)
    }
    


}

extension HomeViewController: SearchDelegate {
    
    func didSearch(search: String?, type: ViewModelType) {
        
        switch type {
        case .secondVC:
            fromSecondVC(search: search)
        case .FourthVC:
            fromFourthVC(search: search)
        default: break
        }
        
        
    }
    
    private func fromSecondVC(search: String?)
    {
        searchedString = search
        if let checkedNumber = search
        {
            startButton.configuration?.title = checkedNumber
            dataPassedButton.isHidden = false
            tapIsUnable = true
            animateButtonText()
        } else
        {
            startButton.configuration?.title = StringsConstans.startButtonTitle
            dataPassedButton.isHidden = true
            tapIsUnable = false
        }
    }
    
    private func fromFourthVC(search: String?)
    {
        if let checkedCity = search
        {
            dataPassedButton.setTitle(checkedCity, for: .normal)
        }
        searchedString = nil
    }
    
}

extension HomeViewController {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if tapIsUnable {
            tapCount += 1
            if tapCount == 6 {
                view.backgroundColor = .random()
                tapCount = 0
            }
        }
    }
    

        
    private func animateButtonText()
      {
        guard let buttonTitleLabel = dataPassedButton.titleLabel else { return }
        UIView.transition(with: buttonTitleLabel, duration: 1.0, options: [.curveEaseOut])
        { [weak self] in
            self?.dataPassedButton.setTitle(StringsConstans.dataPasssedButtonTitle, for: .normal)
          self?.view.layoutIfNeeded()
        }
      }
    
}


