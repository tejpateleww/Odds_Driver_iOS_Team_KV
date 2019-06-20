//
//  DriverEmailViewController.swift
//  TiCKTOC-Driver
//
//  Created by Excellent Webworld on 11/10/17.
//  Copyright © 2017 Excellent Webworld. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
//import ACFloatingTextfield_Swift

class DriverEmailViewController: UIViewController, UIScrollViewDelegate, NVActivityIndicatorViewable 
{
    
    var userDefault = UserDefaults.standard
    var otpCode = Int()

    @IBOutlet var btnNext: UIButton!
    @IBOutlet var constrainViewOTPLeadingPosition: NSLayoutConstraint!
    
    @IBOutlet var viewOTP: UIView!
    @IBOutlet var lblHaveAccount: UILabel!
    
    @IBOutlet var txtOTP: UITextField!
    @IBOutlet var txtPassword: UITextField!
    
    @IBOutlet var txtEmail: ThemeTextField!
    @IBOutlet var txtConPassword: UITextField!
    @IBOutlet var txtMobile: UITextField!
    @IBOutlet var viewEmailData: UIView!
    @IBOutlet var btnLogin: UIButton!
    
    @IBOutlet weak var constraintHeightOfLogo: NSLayoutConstraint! // 80
    @IBOutlet weak var constraintHeightOfAllTextFields: NSLayoutConstraint! // 48
    
    
    var isOTPSent:Bool = false
    
    //-------------------------------------------------------------
    // MARK: - Base Methods
    //-------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewEmailData.isHidden = false
        constrainViewOTPLeadingPosition.constant = 0//self.view.frame.size.width
//        self.btnNext.setTitle("Send OTP".localized, for: .normal)
        self.lblHaveAccount.isHidden = false
        self.btnLogin.isHidden = false
        txtOTP.isEnabled = false
        
        if DeviceType.IS_IPHONE_4_OR_LESS || DeviceType.IS_IPAD {
            constraintHeightOfLogo.constant = 50
            constraintHeightOfAllTextFields.constant = 30
        }
        
        txtOTP.keyboardType = .numberPad
//        txtMobile.text = "5500990033"
//        txtEmail.text = "djhfs@sjhdf.com"
//        txtPassword.text = "12345678"
//        txtConPassword.text = "12345678"
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        btnNext.layer.cornerRadius = btnNext.frame.size.height/2
        btnNext.clipsToBounds = true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    @IBOutlet weak var txtEmailId: UITextField!
    
    @IBAction func btnResendOTPClicked(_ sender: Any)
    {
         webserviceForGetOTPCode()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setLocalization()
      
        self.title = "App Name".localized

    }
    
    func setLocalization()
    {
        txtMobile.placeholder = "Mobile Number".localized
        txtEmail.placeholder = "Email".localized
        txtPassword.placeholder = "Password".localized
        txtConPassword.placeholder = "Confirm Password".localized
        btnNext.setTitle("Send OTP".localized, for: .normal)
        txtOTP.placeholder = "Enter Verification Code".localized
        //lblPleaseCheckYourEmail.text = "".localized
//        lblPleaseCheckYourEmail.text = "Resend OTP".localized
        btnResentOtp.setTitle("Resend OTP".localized, for: .normal)
//        lblHaveAccount.text = "".localized
//        btnLogin.setTitle("".localized, for: normal)
    }
    @IBOutlet weak var lblPleaseCheckYourEmail: UILabel!
    @IBOutlet weak var btnResentOtp: UIButton!
    
    @IBAction func btnNext(_ sender: Any)
    {
        
//        performSegue(withIdentifier: "SegueToDriverPErsonelnfo", sender: self)
        
        if self.isOTPSent == true
        {
            if CompareOTP()
            {
                UIView.animate(withDuration: 0.8, delay: 0.0, options: .curveEaseOut, animations:
                    {
                        
                }) { (done) in
                    
                    self.constrainViewOTPLeadingPosition.constant = 0//self.view.frame.size.width
                    self.btnNext.setTitle("Send OTP".localized, for: .normal)
                    self.lblHaveAccount.isHidden = false
                    self.btnLogin.isHidden = false
                    self.txtOTP.isEnabled = false
                    self.viewEmailData.isHidden = false
                    self.view.layoutIfNeeded()
                    
                }
                let driverVC = self.navigationController?.viewControllers.last as! DriverRegistrationViewController
                driverVC.viewDidLayoutSubviews()
            }
        }
        else
        {
            let Validator = self.checkValidation()
            if Validator.0
            {
                webserviceForGetOTPCode()
            } else {
                UtilityClass.showAlert("App Name".localized, message: Validator.1, vc: self)
            }
        }
    }
    
    @IBAction func btnLogin(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        let NavController = UINavigationController(rootViewController: vc)
        (UIApplication.shared.delegate as? AppDelegate)?.window?.rootViewController = NavController
//        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView)
    {
        //        let pageNo = CGFloat(scrollView.contentOffset.x / scrollView.frame.size.width)
        //        segmentController.selectItemAt(index: Int(pageNo), animated: true)
    }
    
    func checkValidation() -> (Bool, String) {
        var ValidationMessage:String = ""
        var IsValid:Bool = true
        
        let isEmailAddressValid = isValidEmailAddress(emailID: txtEmail.text!)
        if txtEmail.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).count == 0
        {
            IsValid = false
            ValidationMessage = "Please enter email".localized
            
//            UtilityClass.showAlert("App Name".localized, message: "Please enter email".localized, vc: self)
//            return false
        }
        else if (!isEmailAddressValid)
        {
            IsValid = false
            ValidationMessage = "Please enter a valid email".localized
//            UtilityClass.showAlert("App Name".localized, message: "Please enter a valid email".localized, vc: self)
//            return false
        } else if txtMobile.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).count == 0
        {
            IsValid = false
            ValidationMessage = "Please enter mobile number".localized
//            UtilityClass.showAlert("App Name".localized, message: "Please enter mobile number".localized, vc: self)
//            return false
        }
        else if (txtMobile.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).count)! < 10
        {
            IsValid = false
            ValidationMessage = "Please enter valid mobile number".localized
//            UtilityClass.showAlert("App Name".localized, message: "Please enter valid mobile number".localized, vc: self)
//            return false
        }
        else if txtPassword.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).count == 0
        {
            IsValid = false
            ValidationMessage = "Please enter password".localized
//            UtilityClass.showAlert("App Name".localized, message: "Please enter password".localized, vc: self)
//            return false
        } else if (txtPassword.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).count)! < 8
        {
            IsValid = false
            ValidationMessage = "Password must contain at least 8 characters.".localized
//            UtilityClass.showAlert("App Name".localized, message: "Password must contain at least 8 characters.".localized, vc: self)
//            return false
        }
        else if txtConPassword.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).count == 0
        {
            IsValid = false
            ValidationMessage = "Please enter confirm password".localized
//            UtilityClass.showAlert("App Name".localized, message: "Please enter confirm password".localized, vc: self)
//            return false
        }
        else if txtConPassword.text! != txtPassword.text
        {
            IsValid = false
            ValidationMessage = "Password and confirm password must be same".localized
//            UtilityClass.showAlert("App Name".localized, message: "Password and confirm password must be same".localized, vc: self)
//            return false
        }
        
        return (IsValid,ValidationMessage)
    }
    
    func isValidEmailAddress(emailID: String) -> Bool
    {
        var returnValue = true
        let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z)-9.-]+\\.[A-Za-z]{2,3}"
        
        do{
            let regex = try NSRegularExpression(pattern: emailRegEx)
            let nsString = emailID as NSString
            let results = regex.matches(in: emailID, range: NSRange(location: 0, length: nsString.length))
            
            if results.count == 0
            {
                returnValue = false
            }
        }
        catch _ as NSError
        {
            returnValue = false
        }
        
        return returnValue
    }
    
    //-------------------------------------------------------------
    // MARK: - Webservice For Get OTP Code
    //-------------------------------------------------------------
    
    var aryOfCompany = [[String:AnyObject]]()
    
    func webserviceForGetOTPCode()
    {
        var dictData = [String:AnyObject]()
        dictData["Email"] = txtEmail.text as AnyObject
        dictData[RegistrationFinalKeys.kMobileNo] = txtMobile.text as AnyObject
        
        webserviceForOTPDriverRegister(dictData as AnyObject) { (result, status) in
            
            if (status)
            {
                print(result)
                
                let otp = result.object(forKey: "otp") as! Int
                self.aryOfCompany = result.object(forKey: "company") as! [[String : AnyObject]]
                self.isOTPSent = true
                self.userDefault.set(otp, forKey: OTPCodeStruct.kOTPCode)
                self.userDefault.set(self.aryOfCompany, forKey: OTPCodeStruct.kCompanyList)
                
                let alert = UIAlertController(title: "App Name".localized, message: result.object(forKey: GetResponseMessageKey()) as? String, preferredStyle: .alert)
                
                let ok = UIAlertAction(title: "Dismiss".localized, style: .default, handler: { ACTION in
                    //
                    let driverVC = self.navigationController?.viewControllers.last as! DriverRegistrationViewController
//                    driverVC.viewDidLayoutSubviews()
                    //
                    driverVC.setData(companyData: self.aryOfCompany)
                    //
                    self.constrainViewOTPLeadingPosition.constant = -self.view.frame.size.width
                    self.viewEmailData.isHidden = true
                    self.lblHaveAccount.isHidden = true
                    self.btnLogin.isHidden = true
                    UIView.animate(withDuration: 0.8, delay: 0.0, options: .curveEaseOut, animations:
                        {
                            self.txtOTP.isEnabled = true
                            self.view.layoutIfNeeded()
                            
                            self.btnNext.setTitle("Submit".localized, for: .normal)
                    })
                    { (done) in
                        
                    }
//                    self.userDefault.set(self.txtEmail.text, forKey: savedDataForRegistration.kKeyEmail)
                    self.userDefault.set(self.txtEmail.text, forKey: RegistrationFinalKeys.kEmail)
                    self.userDefault.set(self.txtPassword.text, forKey: RegistrationFinalKeys.kPassword)
                    self.userDefault.set(self.txtMobile.text, forKey: RegistrationFinalKeys.kMobileNo)
//                    self.userDefault.set(1, forKey: savedDataForRegistration.kPageNumber)
                    
                })
                
                
                alert.addAction(ok)
                self.present(alert, animated: true, completion: nil)
            }
            else
            {
                print(result)
                let alert = UIAlertController(title: "App Name".localized, message: result.object(forKey: GetResponseMessageKey()) as? String, preferredStyle: .alert)
                let ok = UIAlertAction(title: "Dismiss".localized, style: .default, handler: nil)
                alert.addAction(ok)
                self.present(alert, animated: true, completion: nil)
            }
            //
            //            NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
            //
        }
    }
    
    func CompareOTP() -> Bool
    {
        
        if Utilities.isEmpty(str: txtOTP.text)
        {
            Utilities.showAlert("App Name".localized, message: "Please enter OTP".localized, vc: (UIApplication.shared.keyWindow?.rootViewController)!)
            return false
        }
        else
        {
            if userDefault.object(forKey: OTPCodeStruct.kOTPCode) == nil {
                otpCode = 0
            }
            else {
                otpCode = userDefault.object(forKey: OTPCodeStruct.kOTPCode) as! Int
            }
            
            if txtOTP.text == String(otpCode)
            {
                let driverVC = self.navigationController?.viewControllers.last as! DriverRegistrationViewController
                
                //            let personalDetailsVC = driverVC.childViewControllers[2] as! DriverPersonelDetailsViewController
                
                let x = self.view.frame.size.width
                driverVC.scrollObj.setContentOffset(CGPoint(x:x, y:0), animated: true)
                driverVC.viewTwo.backgroundColor = ThemeYellowColor
                //            driverVC.imgDriver.image = UIImage.init(named: iconDriverSelect)
                
                //            personalDetailsVC.setDataForProfile()
                self.userDefault.set(self.txtOTP.text, forKey: savedDataForRegistration.kKeyOTP)
                self.userDefault.set(1, forKey: savedDataForRegistration.kPageNumber)
                return true
            }
            else
            {
                let alert = UIAlertController(title: "App Name".localized, message: "Please enter correct OTP".localized, preferredStyle: .alert)
                
                let ok = UIAlertAction(title: "Dismiss".localized, style: .default, handler: nil)
                
                alert.addAction(ok)
                
                self.present(alert, animated: true, completion: nil)
                return false
            }
        }
    }
    
}
