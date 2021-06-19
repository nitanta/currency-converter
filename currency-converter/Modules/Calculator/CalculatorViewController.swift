//
//  CalculatorViewController.swift
//  currency-converter
//
//  Created by Nitanta Adhikari on 6/17/21.
//

import UIKit

protocol CalculatorViewControllerInput: AnyObject {
    func showDefaultCountry(code: String)
    func showDefaultCurrencyRate(code: String, rate: Double)
    func showLoader(show: Bool)
    func showError(message: String)
    func showConvertedValue(value: String)
}

protocol CalculatorViewControllerOutput: AnyObject {
    func loadRates()
    func convertCurrency()
}

class CalculatorViewController: UIViewController {

    var output: CalculatorInteractorInput?
    var router: CalculatorRoutingLogic?
    
    @IBOutlet weak var selectedCodeBtn: UIButton!
    @IBOutlet weak var convertedValueLbl: UILabel!
    @IBAction func selectedBodeBtnTap(_ sender: Any) {
        router?.showCurrencyRatePicker()
    }
    
    @IBOutlet var numberBtns: [UIButton]!
    @IBAction func numberBtnTapped(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        output?.loadRates()
    }
    
    private func setupViews() {
        
    }

    private func checkForCountryCode() -> String {
        guard let code = UserDefaults.standard.string(forKey: UserDefaultsKey.currencyCode) else {
            UserDefaults.standard.set(Global.defaultCode, forKey: UserDefaultsKey.currencyCode)
            return Global.defaultCode
        }
        return code
    }
    
    @objc func barButtonTapped() {
        router?.showCountryPicker()
    }
}

extension CalculatorViewController: CalculatorViewControllerInput {
    
    func showDefaultCountry(code: String) {
        let codeButton = UIBarButtonItem(title: code, style: .plain, target: self, action: #selector(barButtonTapped))
        codeButton.tintColor = .black
        self.navigationItem.rightBarButtonItem = codeButton
    }
    
    func showConvertedValue(value: String) {
        convertedValueLbl.text = value
    }
    
    func showDefaultCurrencyRate(code: String, rate: Double) {
        selectedCodeBtn.setTitle("\(rate) = \(code)", for: .normal)
    }
    
    func showLoader(show: Bool) {}
    
    func showError(message: String) {
        router?.showFailure(message: message)
    }
    
}

