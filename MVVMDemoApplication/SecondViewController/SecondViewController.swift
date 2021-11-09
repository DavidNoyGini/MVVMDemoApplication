//
//  SecondViewController.swift
//  MVVMDemoApplication
//
//  Created by David Noy on 03/11/2021.
//

import UIKit
import Reusable

protocol SearchDelegate: AnyObject {
    func didSearch(search: String?,type: ViewModelType)
}

class SecondViewController: UIViewController, Routing {
    
    var router: Router?
    
    @IBOutlet weak var goButtonOutlet: UIButton!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    private var dataSource: ViewModel
    weak var searchDelegate: SearchDelegate?
    var searchedString: String?
    
    init(dataSource: ViewModel) {
        self.dataSource     = dataSource
        if dataSource.type == .FourthVC {searchedString = nil}
        super.init(nibName: "SecondViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpMethod()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let number = searchedString {
            textField.text = number
            loadDataToTable(number: number)
        }
    }
    
    @IBAction func goButton(_ sender: UIButton) {
        numberCheck()
    }
    
    private func setUpMethod(){
          tableView.register(cellType: SecondVCTableViewCell.self)

        tableView.delegate = self
        tableView.dataSource = self
        tableView.isHidden = true
        goButtonOutlet.configuration?.attributedTitle?.font = .systemFont(ofSize: 15)
        goButtonOutlet.configuration?.titlePadding = 2
        navigationItem.leftBarButtonItem?.image = UIImage(systemName: "arrow.backward")
    }
    
    private func numberCheck(){
        guard textField.text != nil,
              let number = textField.text else {return}
        loadDataToTable(number: number)
        
    }
    
    private func loadDataToTable(number: String){
        if let count = Int(number) {
            dataSource.cellModels = []
            dataSource.makeDataSource(number: count)
            searchedString = number
            view.backgroundColor = .systemTeal
            tableView.isHidden = false
            tableView.reloadData()
            tableView.isHidden = false
        } else {
            inValiedNuber()
        }
    }
    
    private func inValiedNuber(){
        view.backgroundColor = .red
        tableView.isHidden = true
        searchedString = nil
    }
    
    private func backToHome(){
        searchDelegate?.didSearch(search: searchedString, type: dataSource.type)
        router?.remove(type: dataSource.type)
    }
    
}

extension SecondViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.cellModels.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellModel = dataSource.getCellModel(i: indexPath.row)
        let cell = tableView.dequeueReusableCell(for: indexPath) as SecondVCTableViewCell
        cell.configure(with: cellModel)

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch dataSource.type {
        case .FourthVC:
            let cellString = dataSource.getCellModel(i: indexPath.row)
            searchedString = cellString.tappedString
        default: break
        }
        backToHome()
    }
    
}
