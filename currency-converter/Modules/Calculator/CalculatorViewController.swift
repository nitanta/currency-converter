//
//  CalculatorViewController.swift
//  currency-converter
//
//  Created by Nitanta Adhikari on 6/17/21.
//

import UIKit

protocol CalculatorViewControllerInput: AnyObject {
    func showDefaultCountry(code: String)
    func showDefaultCurrencyRate(code: String, source: String, rate: Double)
    func showLoader(show: Bool)
    func showError(message: String)
    func showConvertedValue(value: String)
}

protocol CalculatorViewControllerOutput: AnyObject {
    func loadCurrentCountry()
    func loadCurrentRate()
    func loadRates(reload: Bool)
    func convertCurrency(value: Double)
}

class CalculatorViewController: UIViewController {

    var output: CalculatorInteractorInput?
    var router: CalculatorRoutingLogic?
    
    var typedInteger: Double {
        guard let value = convertedValueLbl.text, let intValue = Double(value) else { return 0 }
        return intValue
    }
    
    @IBOutlet weak var selectedCodeBtn: UIButton!
    @IBOutlet weak var convertedValueLbl: UILabel!
    @IBAction func selectedBodeBtnTap(_ sender: Any) {
        router?.showCurrencyRatePicker()
    }
    
    @IBOutlet var numberBtns: [UIButton]!
    @IBAction func numberBtnTapped(_ sender: Any) {
        guard let button = sender as? UIButton else { return }
        switch button.tag {
        case 0...9: addDigitTapped(button: button)
        case 20: equalsTapped()
        case 30: deleteTapped()
        case 40: resetTapped()
        default: break
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupData()
    }
    
    private func setupViews() {
        selectedCodeBtn.isHidden = true
    }
    
    private func setupData() {
        output?.loadCurrentCountry()
        output?.loadCurrentRate()
        output?.loadRates(reload: false)
    }
    
    @objc func barButtonTapped() {
        router?.showCountryPicker()
    }
    
    private func resetTapped() {
        guard typedInteger != 0 else { return }
        convertedValueLbl.text = "0"
    }
    
    private func deleteTapped() {
        guard typedInteger != 0, let typedText = convertedValueLbl.text else { return }
        convertedValueLbl.text = typedText.count > 1 ? String(typedText.dropLast()) : "0"
    }
    
    private func equalsTapped() {
        guard typedInteger != 0 else { return }
        output?.convertCurrency(value: typedInteger)
    }
    
    private func addDigitTapped(button: UIButton) {
        guard let typedText = convertedValueLbl.text else { return }
        convertedValueLbl.text = typedText == "0" ? "\(button.tag)" : "\(typedText)\(button.tag)"
    }
}

// MARK: - CalculatorViewControllerInput
extension CalculatorViewController: CalculatorViewControllerInput {
    func showDefaultCurrencyRate(code: String, source: String, rate: Double) {
        selectedCodeBtn.isHidden = false
        selectedCodeBtn.setTitle("\(code) = \(rate)", for: .normal)
    }
    
    func showDefaultCountry(code: String) {
        let codeButton = UIBarButtonItem(title: code, style: .plain, target: self, action: #selector(barButtonTapped))
        codeButton.tintColor = .black
        self.navigationItem.rightBarButtonItem = codeButton
    }
    
    func showConvertedValue(value: String) {
        convertedValueLbl.text = value
    }
    
    func showLoader(show: Bool) {}
    
    func showError(message: String) {
        router?.showFailure(message: message)
    }
    
}

// MARK: - PickerViewControllerParentOutput
extension CalculatorViewController: PickerViewControllerParentOutput {
    func reloadRates() {
        output?.loadCurrentRate()
    }
}

// MARK: - CountriesViewControllerParentOutput
extension CalculatorViewController: CountriesViewControllerParentOutput {
    func reloadCountry() {
        selectedCodeBtn.isHidden = true
        output?.loadCurrentCountry()
        output?.loadRates(reload: true)
    }
}

