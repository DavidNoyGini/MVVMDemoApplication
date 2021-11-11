//
//  SecondVC.swift
//  MVVMDemoApplication
//
//  Created by David Noy on 03/11/2021.
//

import UIKit
import Reusable

class SecondVC: UIViewController {
        
    @IBOutlet weak var goButtonOutlet: UIButton!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel: TableScreenVM
    var text: String?
    
    init(viewModel: TableScreenVM)
    {
        self.viewModel     = viewModel
        super.init(nibName: "SecondVC", bundle: nil)
    }
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setUpMethod()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        checkVM()
    }
    
    private func checkVM()
    {
        if let secondVM = viewModel as? SecondVMTableScreenProtocol
        {
            if let textFieldText = secondVM.text
            {
                text = textFieldText
                textField.text = text
                viewModel.goButtonTapped(text: text)
            } else
            {
                textField.text = ""
            }
        }
    }

    
    @IBAction func goButton(_ sender: UIButton)
    {
       // numberCheck()
        viewModel.goButtonTapped(text: textField.text)
    }
        
    private func setUpMethod()
    {
        tableView.register(cellType: SecondVCTableViewCell.self)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isHidden = true
        
        goButtonOutlet.configuration?.attributedTitle?.font = .systemFont(ofSize: 15)
        goButtonOutlet.configuration?.titlePadding = 2
    }
}

extension SecondVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        viewModel.numberOfItemInSection(section: section)
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(for: indexPath) as SecondVCTableViewCell
        guard let cellModel = viewModel.getCellVM(indexPath: indexPath) else {return cell}
        cell.configure(with: cellModel)

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        viewModel.userDidSelectRowAt(indexPath: indexPath)
    }
    
}

extension SecondVC: TableScreenVMDelegate {
    func reloadDataFromVM()
    {
        loadDataToTable()
    }
    
    func showErrorAlert(errorType: TableScreenVMError)
    {
        DispatchQueue.main.async { [weak self] in
            self?.view.backgroundColor = .red
            self?.tableView.isHidden = true
            self?.tableView.reloadData()
            self?.createAlert(title: AlertState.error.rawValue, message: errorType.rawValue)
        }
        
    }
    
    private func loadDataToTable()
    {
            DispatchQueue.main.async
            { [weak self] in
                self?.view.backgroundColor = .systemTeal
                self?.tableView.reloadData()
                self?.tableView.isHidden = false
            }
    }
    
    private func createAlert(title: String, message: String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: {_ in }))
        present(alert, animated: true)
    }
}

enum AlertState: String {
    case error = "Error"
}
