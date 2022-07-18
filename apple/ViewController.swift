//
//  ViewController.swift
//  apple
//
//  Created by Ammad on 18/07/2022.
//

import UIKit
import AuthenticationServices

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureLoginButton()
        // Do any additional setup after loading the view.
    }
    func configureLoginButton() {
        let button = ASAuthorizationAppleIDButton()
        button.center = view.center
        button.addTarget(self, action: #selector(tapLoginButton), for: .touchUpInside)
        self.view.addSubview(button)
    }
    @objc func tapLoginButton() {
            let appleIDDetails = ASAuthorizationAppleIDProvider()
            let request = appleIDDetails.createRequest()
            request.requestedScopes = [.email, .fullName]
            let controller = ASAuthorizationController(authorizationRequests: [request])
            controller.delegate = self
            controller.performRequests()
        }

}

extension ViewController : ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let details = authorization.credential as? ASAuthorizationAppleIDCredential {
            print("USER ID - \(details.user)")
            print("SELECTED USER NAME - \(details.fullName!)")
            print("USER EMAIL -\(details.email!)")
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print(error.localizedDescription)
    }
}

