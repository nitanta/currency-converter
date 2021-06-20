//
//  PickerViewController.swift
//  currency-converter
//
//  Created by Nitanta Adhikari on 6/17/21.
//

import UIKit

protocol PickerViewControllerInput: AnyObject {
    func showRateList(list: [String: Double])
    func showLoader(show: Bool)
    func goBack()
    func showError(message: String)
}

protocol PickerViewControllerOutput: AnyObject {
    func loadRates()
    func selectRate(code: String, rate: Double)
}

class PickerViewController: UIViewController {

    var rates: [(code: String, value: Double)] = []
    var output: PickerInteractorInput?
    var router: PickerRoutingLogic?
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableViews()
        output?.loadRates()
    }
    
    private func setupTableViews() {
        tableView.register(UINib(nibName: PickerTableViewCell.identifer, bundle: Bundle.main), forCellReuseIdentifier: PickerTableViewCell.identifer)
        tableView.separatorStyle = .singleLine
        tableView.dataSource = self
        tableView.delegate = self
    }

}

extension PickerViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PickerTableViewCell.identifer, for: indexPath) as? PickerTableViewCell else {
            return UITableViewCell()
        }
        let item = rates[indexPath.row]
        cell.configure(code: item.code, value: item.value)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = rates[indexPath.row]
        output?.selectRate(code: item.code, rate: item.value)
    }
    
}

extension PickerViewController: PickerViewControllerInput {
    func showRateList(list: [String : Double]) {
        rates = list.map { (code: $0.key, value: $0.value) }
        tableView.reloadData()
    }
    
    func goBack() {
        router?.goBack()
    }
    
    func showError(message: String) {
        router?.showFailure(message: message)
    }    
    
    func showLoader(show: Bool) {}
    
}
