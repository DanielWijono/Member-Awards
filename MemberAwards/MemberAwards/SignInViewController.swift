//
//  SignInViewController.swift
//  MemberAwards
//
//  Created by Jac'ks Labs on 02/10/19.
//  Copyright © 2019 testing. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class SignInViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var emailTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var backgroundView: UIView!
    
    var emailList = ["aaa@yahoo.com","bbb@yahoo.com","ccc@yahoo.com"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTextField()
        initTapRecognizer()
        registerKeyboardNotifications()
        signInButton.layer.cornerRadius = 8
    }
    
    private func registerKeyboardNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(notification:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide(notification:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    @objc
    private func keyboardWillShow(notification: NSNotification) {
        let userInfo: NSDictionary = notification.userInfo! as NSDictionary
        let keyboardInfo = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        let keyboardSize = keyboardInfo.cgRectValue.size
        var contentInsets = scrollView.contentInset
        contentInsets.bottom = keyboardSize.height
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    
    @objc
    private func keyboardWillHide(notification: NSNotification) {
        var contentInsets = scrollView.contentInset
        contentInsets.bottom = 0
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }

    @IBAction func signInClicked(_ sender: UIButton) {
        validateEmail()
    }
    
    func initTapRecognizer() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(backgroundTapped))
        tap.cancelsTouchesInView = false
        backgroundView.addGestureRecognizer(tap)
    }
    
    @objc func backgroundTapped() {
        self.view.endEditing(true)
    }
    
    func validateEmail() {
        for email in emailList {
            if email == emailTextField!.text {
                print("equal")
                emailTextField.errorMessage = ""
                let vc = AwardsViewController(nibName: "AwardsViewController", bundle: nil)
                self.navigationController?.pushViewController(vc, animated: true)
                break
            } else {
                print("not equal")
                emailTextField.errorColor = .red
                emailTextField.errorMessage = "Email Address is not exists"
            }
        }
    }
}

extension SignInViewController : UITextFieldDelegate {
    @objc func emailChanged() {
        if emailTextField.text == "" {
            emailTextField.errorMessage = ""
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            textField.resignFirstResponder()
        }
        return false
    }
    
    func initTextField() {
        emailTextField.delegate = self
        emailTextField.addTarget(self, action: #selector(emailChanged), for: .editingChanged)
    }
}
