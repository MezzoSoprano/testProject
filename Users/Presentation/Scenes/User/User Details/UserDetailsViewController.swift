//
//  UserDetailsViewController.swift
//  Users
//
//  Created by Svyatoslav Katola on 08.09.2020.
//  Copyright © 2020 Soprano. All rights reserved.
//

import UIKit

final class UserDetailsViewController: UserBaseViewController {
    
    var saveButton: UIButton!
    var lastNameTextField: UITextField!
    var firstNameTextField: UITextField!
    var saveButtonBottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        setupTextFields()
        setupSaveButton()
        
        NotificationCenter.default.addObserver(self, selector: #selector(adjustForKeyboard), name: .keyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(adjustForKeyboard), name: .keyboardWillHide, object: nil)
        
        saveButton.addTarget(self, action: #selector(save), for: .touchUpInside)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(endEditing)))
    }
    
    var output: UserDetailsViewOutput!
}

extension UserDetailsViewController {
    
    private func setupTextFields() {
        lastNameTextField = UITextField()
        firstNameTextField = UITextField()
        
        [lastNameTextField, firstNameTextField].forEach {
            $0?.borderStyle = .roundedRect
            $0?.delegate = self
            $0?.translatesAutoresizingMaskIntoConstraints = false
            $0?.heightAnchor.constraint(equalToConstant: 40).isActive = true
        }
        
        let stackView = UIStackView(arrangedSubviews: [firstNameTextField, lastNameTextField])
        stackView.spacing = 20
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30)
        ])
    }
    
    private func setupSaveButton() {
        saveButton = UIButton()
        saveButton.layer.cornerRadius = 8
        saveButton.setTitle("Save", for: .normal)
        saveButton.backgroundColor = .systemBlue
        view.addSubview(saveButton)
        
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButtonBottomConstraint = saveButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        
        NSLayoutConstraint.activate([
            saveButtonBottomConstraint,
            saveButton.heightAnchor.constraint(equalToConstant: 50),
            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15)
        ])
    }
    
    private func animate(duration: TimeInterval, options: UIView.AnimationOptions) {
        UIView.animate(withDuration: duration,
                       delay: 0, options: options,
                       animations: view.layoutIfNeeded,
                       completion: nil)
    }
}

extension UserDetailsViewController {
    
    @objc func save() {
        guard let firstName = firstNameTextField.text,
            let lastName = lastNameTextField.text else {
                return
        }
        
        endEditing()
        output.save(userDetails: .init(firstName: firstName, lastName: lastName))
    }
    
    @objc func endEditing() {
        view.endEditing(true)
    }
    
    @objc func adjustForKeyboard(notification: Notification) {
        guard let options = Keyboard.Options.init(notification: notification) else { return }
        
        if notification.name == .keyboardWillShow {
            saveButtonBottomConstraint.constant = view.safeAreaInsets.bottom - options.frameEnd.height - 10
        } else {
            saveButtonBottomConstraint.constant = .zero
        }
        
        animate(duration: options.animationDuration, options: options.animationOptions)
    }
}

extension UserDetailsViewController: UserDetailsViewInput {
    
    func configure(with userDetails: User.Details) {
        firstNameTextField.text = userDetails.firstName
        lastNameTextField.text = userDetails.lastName
    }
    
    func configure(withLoading flag: Bool) {
        flag ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
        [firstNameTextField, lastNameTextField, saveButton].forEach { $0?.isUserInteractionEnabled = !flag }
    }
}

extension UserDetailsViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        endEditing()
        return false
    }
}
