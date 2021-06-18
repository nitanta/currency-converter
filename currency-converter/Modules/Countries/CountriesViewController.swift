//
//  CountriesViewController.swift
//  currency-converter
//
//  Created by Nitanta Adhikari on 6/18/21.
//

import UIKit

protocol CountriesViewControllerInput: AnyObject {
    func showCountriesList(list: [CountryResponse])
    func showLoader(show: Bool)
    func goBack()
    func showError(message: String)
}

protocol CountriesViewControllerOutput: AnyObject {
    func loadCountries()
    func selectCountry(code: String)
}

class CountriesViewController: UIViewController {

    var countries: [CountryResponse] = []
    var output: CountriesInteractorInput?
    var router: CountriesRoutingLogic?
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableViews()
        output?.loadCountries()
    }
    
    private func setupTableViews() {
        tableView.register(UINib(nibName: CountryTableViewCell.identifer, bundle: Bundle.main), forCellReuseIdentifier: CountryTableViewCell.identifer)
        tableView.separatorStyle = .singleLine
        tableView.dataSource = self
        tableView.delegate = self
    }

}

extension CountriesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CountryTableViewCell.identifer, for: indexPath) as? CountryTableViewCell else {
            return UITableViewCell()
        }
        let item = countries[indexPath.row]
        cell.configure(data: item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = countries[indexPath.row]
        output?.selectCountry(code: item.code)
    }
    
}

extension CountriesViewController: CountriesViewControllerInput {
    func goBack() {
        router?.goBack()
    }
    
    func showError(message: String) {
        router?.showFailure(message: message)
    }
    
    func showCountriesList(list: [CountryResponse]) {
        countries = list
        tableView.reloadData()
    }
    
    func showLoader(show: Bool) {}
    
}
