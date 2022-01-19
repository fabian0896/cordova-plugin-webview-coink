//
//  ViewController.swift
//  WKWebView
//
//  Created by MACUSER on 17/01/22.
//

import UIKit
import WebKit


struct SuccessCallback: Codable {
    var code: Int
    var message: String
}

struct ErrorCallback: Codable {
    var code: Int
    var message: String
}


class WebviewViewController: UIViewController, WKNavigationDelegate, WKScriptMessageHandler {
    
   
    
   var commandDelegate: CDVCommandDelegate?
    var callbackId: String?
    var webView: WKWebView!
    var configWebView: WKWebViewConfiguration!
    var toolbar: UIToolbar!
    var url: String?
    var disabledButtons: Bool?
    
    
    var colorToolbar: UIColor = UIColor(red: 56/256, green: 55/256, blue: 59/256, alpha: 1)
    
    
    lazy var containerTop: UIView = {
        let view = UIView()
        view.backgroundColor = colorToolbar
        return view
    }()
    
    lazy var containerOptionsWebView: UIView = {
        let view = UIView()
        view.backgroundColor = colorToolbar
        return view.containerWebView(view: view, backButton: backButton, nextButton: nextButton, closeButton: closeButton, label: label)
    }()
    
    lazy var backButton: UIButton = {
        let bt = UIButton(type: .custom)
        return bt
    }()
    
    lazy var nextButton: UIButton = {
        let bt = UIButton(type: .custom)
        return bt
    }()
    
    lazy var closeButton: UIButton = {
        let bt = UIButton(type: .custom)
        return bt
    }()
    
    
    lazy var containerWebView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()
    
    lazy var progressView: UIProgressView = {
        let bar = UIProgressView(progressViewStyle: .default)
        return bar
    }()
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "Cargando..."
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewComponents(url: url ?? "")
//      webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if message.name == "webview" {
            
        }
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        guard let title = webView.title else { return }
        label.text = title.isEmpty ? "Website": title
        validateButtons()
    }
 
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(self.webView.estimatedProgress)
            
            if (progressView.progress == 1.0) {
                UIView.animate(withDuration: 0.7) {
                    self.progressView.alpha = 0
                }
            } else {
                self.progressView.alpha = 1
            }
        }

    }
    
//    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
//        let url = navigationAction.request.url
//
//        if let host = url?.host {
//            if host == "www.coink.com" || host == "coink.com" {
//                decisionHandler(.allow)
//            } else {
//                decisionHandler(.cancel)
//            }
//        }
//    }
    
    func configureWebViewDelegate() {
        configWebView = WKWebViewConfiguration()
        configWebView?.allowsInlineMediaPlayback = true
        configWebView?.userContentController.add(self, name: "webview")
        webView = WKWebView(frame: CGRect(), configuration: configWebView!)
        webView.navigationDelegate = self
        containerWebView = webView
    }
    
    func addSubviews() {
        view.addSubview(containerTop)
        view.addSubview(containerWebView)
        view.addSubview(containerOptionsWebView)
        view.addSubview(progressView)
    }
    
    func configureStateButtons() {
        guard let disabled =  disabledButtons else { return }
        if disabled {
            backButton.isEnabled = false
            nextButton.isEnabled = false
        }
    }
    
    func configureViewComponents(url: String) {
        
        configureWebViewDelegate()
        addSubviews()
        configureStateButtons()
        
        containerOptionsWebView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRigth: 0, width: 0, height: 50)
        containerWebView.anchor(top: containerOptionsWebView.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRigth: 0, width: 0, height: 0)
        containerTop.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: containerOptionsWebView.topAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRigth: 0, width: 0, height: 0)
        progressView.anchor(top: nil, left: containerOptionsWebView.leftAnchor, bottom: containerOptionsWebView.bottomAnchor, right: containerOptionsWebView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRigth: 0, width: 0, height: 2)
        backButton.addTarget(self, action: #selector(handleBack), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(handleForward), for: .touchUpInside)
        closeButton.addTarget(self, action: #selector(handleClose), for: .touchUpInside)

        
        
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        
        let url = URL(string: url)
        if let _url = url {
            webView.load(URLRequest(url: _url))
            webView.allowsBackForwardNavigationGestures = true
        } else {
            label.text = "URL invalida..."
            let error: ErrorCallback = ErrorCallback(code: 0, message: "Error")
            callbackError(error: error)
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func callbackSuccess(success: SuccessCallback) {
        let encoder = try? JSONEncoder().encode(success)
        let stringSuccess = String(data: encoder!, encoding: .utf8)
        let success = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: stringSuccess!);
        self.commandDelegate!.send(success!, callbackId: self.callbackId);
    }
    
    func callbackError(error: ErrorCallback) {
        let encoder = try? JSONEncoder().encode(error)
        let stringError = String(data: encoder!, encoding: .utf8)
        let error = CDVPluginResult(status: CDVCommandStatus_ERROR, messageAs: stringError!);
        self.commandDelegate!.send(error!, callbackId: self.callbackId);
    }
    
    func validateButtons() {
         if let disabled = disabledButtons {
            if !disabled {
                let countBackList = webView.backForwardList.backList.count
                let countforwardList = webView.backForwardList.forwardList.count
                backButton.isEnabled = countBackList > 0
                nextButton.isEnabled = countforwardList > 0
            }
        }
    }
    
    @objc func handleBack() {
        webView.goBack()
    }
    
    @objc func handleForward() {
        webView.goForward()
    }
    
    @objc func handleClose() {
        let success: SuccessCallback = SuccessCallback(code: 1, message: "Close webview")
        callbackSuccess(success: success)
        self.dismiss(animated: true, completion: nil)
    }



}

