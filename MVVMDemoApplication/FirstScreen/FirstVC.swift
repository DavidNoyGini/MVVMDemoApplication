//
//  FirstVC.swift
//  MVVMDemoApplication
//
//  Created by David Noy on 03/11/2021.
//

import UIKit

class FirstVC: UIViewController {
    
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var dataPassedButton: UIButton!

    var text: String?
    var viewModel: FirstVM
    
    private var tapIsUnable: Bool = false
    private var tapCount: Int = 0
    
    init(viewModel: FirstVM)
    {
        self.viewModel = viewModel
        super.init(nibName: "FirstVC", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - lifecycle & setup
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setUpMethod()
    }
    
    private func setUpMethod()
    {
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
    
    func setPassedDataTitle(dataPassed: String?)
    {
        animateButtonText(dataPassed: dataPassed)
    }

    // MARK: - @IBAction
    @IBAction func startTapped(_ sender: UIButton)
    {
        viewModel.startTapped(text: text)
    }
    
    @IBAction func dataPassedTapped(_ sender: UIButton)
    {
      //  router?.moveTo(with: .toThirdVC, text: text, searchDelegate: self)
        viewModel.dataPassedTapped(text: text)
    }

}

// MARK: Touches
extension FirstVC {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        if tapIsUnable
        {
            tapCount += 1
            if tapCount == 6
            {
                view.backgroundColor = .random()
                tapCount = 0
            }
        }
    }
    
    func animateButtonText(dataPassed: String?)
    {
        dataPassedButton.setTitle(dataPassed, for: .normal)
        dataPassedButton.isHidden = false
        dataPassedButton.titleLabel?.alpha = 1
        UIView.animate(withDuration: 1,
                       delay: 0.5,
                       options: [.autoreverse,.repeat])
        { [weak self] in
            self?.dataPassedButton.titleLabel?.alpha = 0.3
        }
        
    }
}


