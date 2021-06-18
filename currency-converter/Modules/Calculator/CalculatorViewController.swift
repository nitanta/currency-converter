//
//  CalculatorViewController.swift
//  currency-converter
//
//  Created by Nitanta Adhikari on 6/17/21.
//

import UIKit

class CalculatorViewController: UIViewController {

    @IBOutlet weak var selectedCodeBtn: UIButton!
    @IBOutlet weak var convertedValueLbl: UILabel!
    @IBAction func selectedBodeBtnTap(_ sender: Any) {
    }
    
    @IBOutlet var numberBtns: [UIButton]!
    @IBAction func numberBtnTapped(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        let codeButton = UIBarButtonItem(title: checkForCountryCode(), style: .plain, target: self, action: #selector(barButtonTapped))
        codeButton.tintColor = .black
        self.navigationItem.rightBarButtonItem = codeButton
    }

    @objc func barButtonTapped() {
        
    }

    private func checkForCountryCode() -> String {
        guard let code = UserDefaults.standard.string(forKey: UserDefaultsKey.currencyCode) else {
            UserDefaults.standard.set(Global.defaultCode, forKey: UserDefaultsKey.currencyCode)
            return Global.defaultCode
        }
        return code
    }
}

