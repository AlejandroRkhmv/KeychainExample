//
//  Builder.swift
//  KeychainExample
//
//  Created by Александр Рахимов on 13.05.2024.
//

import Foundation
import UIKit

final class Builder {
    static func createViewController() -> UIViewController {
        let viewController = ViewController()
        let presenter = Presenter(viewController: viewController)
        viewController.presenter = presenter
        return viewController
    }
}
