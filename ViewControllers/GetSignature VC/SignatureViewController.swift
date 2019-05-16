//
//  SignatureViewController.swift
//  ODDS-Driver
//
//  Created by EWW-iMac Old on 26/04/19.
//  Copyright © 2019 Excellent Webworld. All rights reserved.
//

import UIKit

class SignatureViewController: UIViewController, YPSignatureDelegate {

    @IBOutlet weak var signatureView: YPDrawSignatureView!
    var onDismiss : (() -> ())?
    var parcelSignatureImage = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        signatureView.delegate = self
    }
    
    func didStart(_ view: YPDrawSignatureView) {
        
    }
    func didFinish(_ view: YPDrawSignatureView) {
        
    }
    @IBAction func clearSignature(_ sender: UIButton) {
        self.signatureView.clear()
    
    }
    @IBAction func saveSignature(_ sender: UIButton) {
        if let signatureImage = self.signatureView.getSignature(scale: 10) {
            
            UIImageWriteToSavedPhotosAlbum(signatureImage, nil, nil, nil)
            parcelSignatureImage = signatureImage
            self.signatureView.clear()
            if let onDismiss = onDismiss{
                onDismiss()
            }
        }
        else{
            UtilityClass.showAlert("", message: "Signatures are required", vc: self)
        }
    }
}
