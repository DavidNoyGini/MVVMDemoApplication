//
//  SecondVC.swift
//  MVVMDemoApplication
//
//  Created by David Noy on 03/11/2021.
//

import UIKit
import Reusable

class SecondVC: UIViewController {
    
    // MARK: - Privtae @IBOutlet
    @IBOutlet private weak var goButtonOutlet: UIButton!
    @IBOutlet private weak var textField: UITextField!
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Privtae var
    private var viewModel: TableScreenVM
    private var text: String?
    
    // MARK: - Init
    init(viewModel: TableScreenVM)
    {
        self.viewModel     = viewModel
        super.init(nibName: "SecondVC", bundle: nil)
    }
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - lifecycle
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupTableView()
        setupGoButtonAndTextField()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        checkVM()
    }
    
    // MARK: - Privtae methods
    private func setupTableView()
    {
        tableView.register(cellType: SecondVCTableViewCell.self)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isHidden = true
    }
    
    private func setupGoButtonAndTextField()
    {
        textField.becomeFirstResponder()
        goButtonOutlet.configuration?.attributedTitle?.font = .systemFont(ofSize: 15)
        goButtonOutlet.configuration?.titlePadding = 2
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
    
    // MARK: - @IBAction
    @IBAction private func goButton(_ sender: UIButton)
    {
        // numberCheck()
        viewModel.goButtonTapped(text: textField.text)
    }
    
}

// MARK: - TableView Methods
extension SecondVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return viewModel.numberOfItemInSection(section: section)
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

//MARK: - TableScreenVMDelegate

extension SecondVC: TableScreenVMDelegate {
    func reloadDataFromVM()
    {
        loadDataToTable()
    }
    
    func showErrorAlert(errorType: StateAndErrors)
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

