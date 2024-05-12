//
//  KeychainManager.swift
//  KeychainExample
//
//  Created by Александр Рахимов on 13.05.2024.
//

import Foundation

enum KeychainErrors: Error {
    case duplicateItems
    case notSucces(status: OSStatus)
}

final class KeychainManager {
    
    
    func addElement(name: String, password: Data) throws -> String {
        let keychainItemQuery: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecValueData: password,
            kSecAttrAccount: name
        ]
        
        let status = SecItemAdd(keychainItemQuery as CFDictionary, nil)
        guard status != errSecDuplicateItem else { throw KeychainErrors.duplicateItems }
        guard status == errSecSuccess else { throw KeychainErrors.notSucces(status: status) }
        
        print("Operation finished with status: \(status)")
        return "Saved"
    }
    
    func getElement(for attribute: String) throws -> Data? {
        let keychainItemQuery: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: attribute,
            kSecReturnData: kCFBooleanTrue as Any
        ]
        
        var dataResult: AnyObject?
        
        let status = SecItemCopyMatching(keychainItemQuery as CFDictionary, &dataResult)
        guard status == errSecSuccess else { throw KeychainErrors.notSucces(status: status) }
        print("Operation finished with status: \(status)")
        return dataResult as? Data
    }
    
    func updateElement(name: String, password: Data) throws -> String {
        let keychainItemQuery: [CFString: Any] = [
             kSecClass: kSecClassGenericPassword,
             kSecValueData: password,
             kSecAttrAccount: name
        ]

        let updateFields = [
             kSecValueData: password
        ] as CFDictionary

        let status = SecItemUpdate(keychainItemQuery as CFDictionary, updateFields)
        guard status == errSecSuccess else { throw KeychainErrors.notSucces(status: status) }
        print("Operation finished with status: \(status)")
        return "Updated for \(name)"
    }
    
    func deleteElement(for attribute: String) throws -> String {
        let keychainItemQuery: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: attribute,
            kSecReturnData: kCFBooleanTrue as Any
        ]

        let status = SecItemDelete(keychainItemQuery as CFDictionary)
        guard status == errSecSuccess else { throw KeychainErrors.notSucces(status: status) }
        print("Operation finished with status: \(status)")
        return "Deleted for \(attribute)"
    }
}
