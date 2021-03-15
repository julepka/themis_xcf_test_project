//
//  ViewController.swift
//  SPM_4
//
//  Created by Julia Potapenko on 11.03.2021.
//

import UIKit
import themis

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        print("Hello, World!")

        let keypair = TSKeyGen(algorithm: .EC)!
        let privateKey = keypair.privateKey
        let publicKey = keypair.publicKey

        let secureMessageA =
            TSMessage(inSignVerifyModeWithPrivateKey: privateKey as Data,
                                       peerPublicKey: nil)!

        let message: Data = "Tra-ta-ta".data(using: .utf8)!

        let signedMessage: Data = try! secureMessageA.wrap(message)

        let secureMessageB =
            TSMessage(inSignVerifyModeWithPrivateKey: nil,
                                       peerPublicKey: publicKey as Data)!

        let verifiedMessage = try! secureMessageB.unwrapData(signedMessage)
        print(String(data: verifiedMessage, encoding: .utf8)!)
    }


}

