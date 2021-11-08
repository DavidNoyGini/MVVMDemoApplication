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
    var choosenNumber: String?
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
//        dataPassedButton.configuration?.title = StringsConstans.dataPasssedButtonTitle
//        dataPassedButton.configuration?.attributedTitle?.font = .systemFont(ofSize: 5)
       
    }
    
    @IBAction func dataPassedTapped(_ sender: UIButton) {
        
        let thirdDataSource = ThirdDataSource()
        let thirdVC = ThirdViewController()
        thirdVC.thirdDataSource = thirdDataSource.makeDataSource(number: choosenNumber)
        
        let toThirdVC = UINavigationController(rootViewController: thirdVC)
        toThirdVC.modalPresentationStyle = .fullScreen
        
        present(toThirdVC, animated: true)
    }
    
    @IBAction func startTapped(_ sender: UIButton) {
        
        let secondVC = SecondViewController()
        secondVC.numberSelsctedDelegate = self
        secondVC.choosenNumber = choosenNumber
        let toSeconedVC = UINavigationController(rootViewController: secondVC)
        toSeconedVC.modalPresentationStyle = .fullScreen
        present(toSeconedVC, animated: true)
        
    }

}

extension HomeViewController: NumberSelsctedDelegate {
    func didSelectNumber(number: String?) {
        
        choosenNumber = number
        if let checkedNumber = number{
            
            startButton.configuration?.title = checkedNumber
            dataPassedButton.isHidden = false
            tapIsUnable = true
            animateButtonText()
        } else {
            startButton.configuration?.title = StringsConstans.startButtonTitle
            dataPassedButton.isHidden = true
            tapIsUnable = false
        }
        
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
    
//    func buttonAnimation(){
//
//        dataPassedButton.configuration?.attributedTitle?.font = .systemFont(ofSize: 25)
//
//        UIView.animate(withDuration: 5.0) { [weak self]  in
//                    self?.view.layoutIfNeeded()
//                }
//
//    }
        
    private func animateButtonText()
      {
        guard let buttonTitleLabel = dataPassedButton.titleLabel else { return }
        UIView.transition(with: buttonTitleLabel, duration: 2.0, options: [.curveEaseOut])
        { [weak self] in
            self?.dataPassedButton.setTitle(StringsConstans.dataPasssedButtonTitle, for: .normal)
          self?.view.layoutIfNeeded()
        }
      }
    
}


