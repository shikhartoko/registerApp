//
//  ViewController.swift
//  formUI
//
//  Created by Shikhar Sharma on 25/02/22.
//

import UIKit

class ViewController: UIViewController {
    
    struct customer: Codable {
        let firstName : String?
        let lastName : String?
        let password : String?
        let city : String?
        let state : String?
        let country : String?
        let age : Int?
        let address : String?
        let phoneNumber : String?
        let securityNumber : String?
        let gender : String?
        let dateOfBirth : String?
        let newsLetter : Bool?
        
// classes with capital letters
// properties with small letters
// mostly camel case
        
//        init (firstName : String? = nil, lastName : String? = nil, password : String? = nil, city : String? = nil, state : String? = nil, country : String? = nil, age : Int? = 18, address : String? = nil, phoneNumber : String? = nil, securityNumber : String? = nil, gender : String? = nil, dateOfBirth : String? = nil, newsLetter : Bool? = true) {
//            self.firstName = firstName
//            self.lastName = lastName
//            self.password = password
//            self.city = city
//            self.state = state
//            self.country = country
//            self.age = age
//            self.address = address
//            self.phoneNumber = phoneNumber
//            self.securityNumber = securityNumber
//            self.gender = gender
//            self.dateOfBirth = dateOfBirth
//            self.newsLetter = newsLetter
//        }
        
        
    }

    
    @IBOutlet weak var firstNameInput: UITextField!
    @IBOutlet weak var lastNameInput: UITextField!
    @IBOutlet weak var pswdInput: UITextField!
    @IBOutlet weak var cityInput: UITextField!
    @IBOutlet weak var stateInput: UITextField!
    @IBOutlet weak var countryInput: UITextField!
    @IBOutlet weak var ageSliderInput: UISlider!
    @IBOutlet weak var AddressInput: UITextField!
    @IBOutlet weak var phoneNumberInput: UITextField!
    @IBOutlet weak var securityNumberInput: UITextField!
    @IBOutlet weak var genderInput: UITextField!
    @IBOutlet weak var dateOfBirthInput: UIDatePicker!
    @IBOutlet weak var newsLetterSwitch: UISwitch!
    @IBOutlet weak var ageLabel: UILabel!
    
    var age : Int = 18
    var newsLetter : Bool = true
    
    @IBAction func ageDidSlide(_ sender: UISlider) {
        age = Int(sender.value)
        ageLabel.text = String(age)
    }
    
    @IBAction func submitTapped(_ sender: Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "en_US")
        
        var cus1 = customer(firstName: firstNameInput.text, lastName: lastNameInput.text, password: pswdInput.text, city: cityInput.text, state: stateInput.text, country: countryInput.text, age: age, address: AddressInput.text, phoneNumber: phoneNumberInput.text, securityNumber: securityNumberInput.text, gender: genderInput.text, dateOfBirth: dateFormatter.string(from: dateOfBirthInput.date), newsLetter: newsLetter)
        // we need to get all the values here
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(cus1) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: "customer")
        }
        let defaults = UserDefaults.standard
        if let savedCustomer = defaults.object(forKey: "customer") as? Data {
            let decoder = JSONDecoder()
            if let loadedCustomer = try? decoder.decode(customer.self, from: savedCustomer) {
                print(loadedCustomer)
            }
        }
        
    }
    
    @IBAction func switchDidChange(_ sender: UISwitch) {
        newsLetter = sender.isOn
    }
    override func viewDidLoad() {
        firstNameInput.delegate = self
        lastNameInput.delegate = self
        pswdInput.delegate = self
        cityInput.delegate = self
        stateInput.delegate = self
        countryInput.delegate = self
        AddressInput.delegate = self
        phoneNumberInput.delegate = self
        securityNumberInput.delegate = self
        genderInput.delegate = self
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        phoneNumberInput.resignFirstResponder()
        securityNumberInput.resignFirstResponder()
    }


}

extension ViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

