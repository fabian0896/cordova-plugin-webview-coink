//
//  CoinkWebview.swift
//  WKWebView
//
//  Created by Hector D. Forero on 18/01/22.
//

import Foundation

@objc(CoinkWebview) class CoinkWebview: CDVPlugin {

    @objc(openWebview:)
       func openWebview(command: CDVInvokedUrlCommand) {
            let url = command.arguments[0] as? String ?? ""
            let disabledButtons = command.arguments[1] as? Bool ?? false
            let viewController = WebviewViewController()
            viewController.url = url
            viewController.commandDelegate = self.commandDelegate
            viewController.callbackId = command.callbackId
            viewController.disabledButtons = disabledButtons
            viewController.modalPresentationStyle = .overFullScreen
            self.viewController.present(viewController, animated: true)
       }

}
