//
//  ViewController.swift
//  KeychainExample
//
//  Created by Александр Рахимов on 12.05.2024.
//

import UIKit

class ViewController: UIViewController {
    
    var presenter: Presenter?
    
    let nameTextField = UITextField()
    let passwordTextField = UITextField()
    let buttonSave = UIButton()
    let buttonGet = UIButton()
    let buttonUpdate = UIButton()
    let buttonDelete = UIButton()
    let label = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        createNameTextField()
        createPasswordTextField()
        setLabel()
        setButtonSave()
        setButtonGet()
        setButtonUpdate()
        setButtonDelete()
    }


    private func createNameTextField() {
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.delegate = self
        view.addSubview(nameTextField)
        
        NSLayoutConstraint.activate([
            nameTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            nameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            view.trailingAnchor.constraint(equalTo: nameTextField.trailingAnchor, constant: 20),
            nameTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        nameTextField.attributedPlaceholder = NSAttributedString (string: "Enter your name",
                                                                  attributes: [NSAttributedString.Key.foregroundColor: UIColor.black,
                                                                               NSAttributedString.Key.font: UIFont(name: "Courier new", size: 20)!])
        nameTextField.textColor = .black
        nameTextField.font = UIFont(name: "Courier new", size: 20)
        nameTextField.backgroundColor = .clear
        nameTextField.layer.borderWidth = 2
        nameTextField.layer.borderColor = UIColor.black.cgColor
        nameTextField.layer.cornerRadius = 10
        nameTextField.borderStyle = UITextField.BorderStyle.roundedRect
        nameTextField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        nameTextField.textAlignment = .left
    }
    
    private func createPasswordTextField() {
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.delegate = self
        view.addSubview(passwordTextField)
        
        NSLayoutConstraint.activate([
            passwordTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            passwordTextField.topAnchor.constraint(equalTo: nameTextField.safeAreaLayoutGuide.topAnchor, constant: 100),
            view.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor, constant: 20),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        passwordTextField.attributedPlaceholder = NSAttributedString (string: "Enter your password",
                                                                  attributes: [NSAttributedString.Key.foregroundColor: UIColor.black,
                                                                               NSAttributedString.Key.font: UIFont(name: "Courier new", size: 20)!])
        passwordTextField.textColor = .black
        passwordTextField.font = UIFont(name: "Courier new", size: 20)
        passwordTextField.backgroundColor = .clear
        passwordTextField.layer.borderWidth = 2
        passwordTextField.layer.borderColor = UIColor.black.cgColor
        passwordTextField.layer.cornerRadius = 10
        passwordTextField.borderStyle = UITextField.BorderStyle.roundedRect
        passwordTextField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        passwordTextField.textAlignment = .left
    }
    
    private func setLabel() {
        label.frame = CGRect(x: 0, y: 0, width: 300, height: 50)
        label.center = self.view.center
        self.view.addSubview(label)
        label.textAlignment = .center
        label.textColor = .red
        label.text = ""
    }
    
    private func setButtonSave() {
        buttonSave.frame = CGRect(x: 0, y: 0, width: 300, height: 50)
        buttonSave.center.x = self.view.center.x
        buttonSave.center.y = self.view.bounds.maxY - 250
        self.view.addSubview(buttonSave)
        buttonSave.backgroundColor = .green
        buttonSave.setTitle("save", for: .normal)
        buttonSave.setTitleColor(.white, for: .normal)
        
        let action = UIAction { [weak self] _ in
            guard let self else { return }
            guard let name = self.nameTextField.text else { return }
            guard let password = self.passwordTextField.text else { return }
            self.presenter?.save(name: name, password: password)
        }
        buttonSave.addAction(action, for: .touchUpInside)
    }
    
    private func setButtonGet() {
        buttonGet.frame = CGRect(x: 0, y: 0, width: 300, height: 50)
        buttonGet.center.x = self.view.center.x
        buttonGet.center.y = self.view.bounds.maxY - 180
        self.view.addSubview(buttonGet)
        buttonGet.backgroundColor = .blue
        buttonGet.setTitle("get", for: .normal)
        buttonGet.setTitleColor(.white, for: .normal)
        
        let action = UIAction { [weak self] _ in
            guard let self else { return }
            guard let name = self.nameTextField.text else { return }
            self.presenter?.get(name: name)
        }
        buttonGet.addAction(action, for: .touchUpInside)
    }
    
    private func setButtonUpdate() {
        buttonUpdate.frame = CGRect(x: 0, y: 0, width: 300, height: 50)
        buttonUpdate.center.x = self.view.center.x
        buttonUpdate.center.y = self.view.bounds.maxY - 110
        self.view.addSubview(buttonUpdate)
        buttonUpdate.backgroundColor = .black
        buttonUpdate.setTitle("update", for: .normal)
        buttonUpdate.setTitleColor(.white, for: .normal)
        
        let action = UIAction { [weak self] _ in
            guard let self else { return }
            guard let name = self.nameTextField.text else { return }
            guard let password = self.passwordTextField.text else { return }
            self.presenter?.update(name: name, password: password)
        }
        buttonUpdate.addAction(action, for: .touchUpInside)
    }
    
    private func setButtonDelete() {
        buttonDelete.frame = CGRect(x: 0, y: 0, width: 300, height: 50)
        buttonDelete.center.x = self.view.center.x
        buttonDelete.center.y = self.view.bounds.maxY - 40
        self.view.addSubview(buttonDelete)
        buttonDelete.backgroundColor = .gray
        buttonDelete.setTitle("delete", for: .normal)
        buttonDelete.setTitleColor(.white, for: .normal)
        
        let action = UIAction { [weak self] _ in
            guard let self else { return }
            guard let name = self.nameTextField.text else { return }
            self.presenter?.delete(name: name)
        }
        buttonDelete.addAction(action, for: .touchUpInside)
    }
    
    func setLabel(text: String) {
        self.label.text = text
    }
}


// MARK: - Extension UITextFieldDelegate
extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nameTextField {
            self.nameTextField.resignFirstResponder()
        } else {
            self.passwordTextField.resignFirstResponder()
        }
        return true
    }

}
