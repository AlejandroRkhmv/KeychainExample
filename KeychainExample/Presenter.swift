//
//  Presenter.swift
//  KeychainExample
//
//  Created by Александр Рахимов on 13.05.2024.
//

import Foundation

final class Presenter {
    weak var viewController: ViewController?
    let keychainManager = KeychainManager()
    
    init(viewController: ViewController) {
        self.viewController = viewController
    }
    
    func save(name: String, password: String) {
        do {
            let result = try keychainManager.addElement(name: name, password: password.data(using: .utf8) ?? Data())
            print(result)
        } catch KeychainErrors.duplicateItems {
            print("duplicate")
        } catch KeychainErrors.notSucces(status: let status) {
            print("***\(status)")
        } catch {
            print("unknown error")
        }
    }
    
    func get(name: String) {
        do {
            let result = try keychainManager.getElement(for: name)
            let text = String(decoding: result ?? Data(), as: UTF8.self)
            DispatchQueue.main.async {
                self.viewController?.setLabel(text: text)
            }
        } catch KeychainErrors.notSucces(status: let status) {
            print("***\(status)")
        } catch {
            print("unknown error")
        }
    }
    
    func update(name: String, password: String) {
        do {
            let result = try keychainManager.updateElement(name: name, password: password.data(using: .utf8) ?? Data())
            print(result)
        } catch KeychainErrors.duplicateItems {
            print("duplicate")
        } catch KeychainErrors.notSucces(status: let status) {
            print("***\(status)")
        } catch {
            print("unknown error")
        }
    }
    
    func delete(name: String) {
        do {
            let result = try keychainManager.deleteElement(for: name)
            print(result)
            DispatchQueue.main.async {
                self.viewController?.setLabel(text: result)
            }
        } catch KeychainErrors.notSucces(status: let status) {
            print("***\(status)")
        } catch {
            print("unknown error")
        }
    }
}
