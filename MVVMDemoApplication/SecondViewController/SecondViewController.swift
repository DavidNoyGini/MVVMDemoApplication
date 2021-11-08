//
//  SecondViewController.swift
//  MVVMDemoApplication
//
//  Created by David Noy on 03/11/2021.
//

import UIKit

protocol NumberSelsctedDelegate: AnyObject {
    func didSelectNumber(number: String?)
}

class SecondViewController: UIViewController, Routing {
    
    var router: Router?
    
    @IBOutlet weak var goButtonOutlet: UIButton!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    private var dataSource: SecondDataSource = SecondDataSource()
    weak var numberSelsctedDelegate: NumberSelsctedDelegate?
    var choosenNumber: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpMethod()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let number = choosenNumber {
            textField.text = number
            loadDataToTable(number: number)
        }
    }
    
    @IBAction func goButton(_ sender: UIButton) {
        numberCheck()
    }
    
    private func setUpMethod(){
        addNavigationItem()
        tableView.register(UINib(nibName: "SecondVCTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isHidden = true
        goButtonOutlet.configuration?.attributedTitle?.font = .systemFont(ofSize: 15)
        goButtonOutlet.configuration?.titlePadding = 2
    }
    
    private func numberCheck(){
        guard textField.text != nil,
              let number = textField.text else {return}
        loadDataToTable(number: number)
        
    }
    
    private func loadDataToTable(number: String){
        if let count = Int(number) {
            dataSource.makeDataSource(number: count)
            choosenNumber = number
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
        choosenNumber = nil
    }
    
    
    private func addNavigationItem(){
        navigationItem.leftBarButtonItem =
        UIBarButtonItem(image: UIImage(systemName: "arrow.backward"),
                        style: .plain,
                        target: self,
                        action: #selector(backToHome))
    }
    
    @objc private func backToHome(){
        numberSelsctedDelegate?.didSelectNumber(number: choosenNumber)
        dismiss(animated: true, completion: nil)
    }
    
}

extension SecondViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.cellNumbers.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellModel = dataSource.getCellModel(i: indexPath.row)
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? SecondVCTableViewCell {
            cell.configure(with: cellModel)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        backToHome()
    }
    
}
