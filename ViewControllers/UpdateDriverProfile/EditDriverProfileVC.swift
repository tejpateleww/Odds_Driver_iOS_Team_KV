//
//  EditDriverProfileVC.swift
//  TiCKTOC-Driver
//
//  Created by Excellent Webworld on 25/10/17.
//  Copyright © 2017 Excellent Webworld. All rights reserved.
//

import UIKit

class EditDriverProfileVC: BaseViewController
{

     var crnRadios = CGFloat()
    @IBOutlet weak var lblEditProfile: UILabel!
    
    @IBOutlet weak var btnAccount: UIButton!
    @IBOutlet weak var btnEditProfile: UIButton!
    @IBOutlet weak var btnVehicleOption: UIButton!
    @IBOutlet weak var btnDocument: UIButton!
    @IBOutlet weak var lblDocument: UILabel!
    @IBOutlet weak var lblAccount: UILabel!
    @IBOutlet weak var lblVehicleOption: UILabel!
    
    
    @IBOutlet weak var iconProfile: UIImageView!
    @IBOutlet weak var iconVehicle: UIImageView!
    @IBOutlet weak var iconAccountInfo: UIImageView!
    @IBOutlet weak var iconDocumentlUser: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        btnAccount.layer.cornerRadius = btnAccount.frame.width - 10
//        btnAccount.layer.masksToBounds = true
//        btnAccount.layer.borderColor = ThemeYellowColor.cgColor
//        btnDocument.layer.cornerRadius = btnDocument.frame.width - 10
//        btnDocument.layer.masksToBounds = true
//        btnDocument.layer.borderColor = ThemeYellowColor.cgColor
//        btnVehicleOption.layer.cornerRadius = btnVehicleOption.frame.width - 10
//        btnVehicleOption.layer.masksToBounds = true
//        btnVehicleOption.layer.borderColor = ThemeYellowColor.cgColor
//        btnEditProfile.layer.cornerRadius = btnEditProfile.frame.width - 10
//        btnEditProfile.layer.masksToBounds = true
//        btnEditProfile.layer.borderColor = ThemeYellowColor.cgColor

        crnRadios = 5
        self.giveCornorRadiosToView(view: viewEditProfile)
        self.giveCornorRadiosToView(view: viewAccount)
        self.giveCornorRadiosToView(view: viewVehicleOption)
        self.giveCornorRadiosToView(view: viewDocument)
//        self.giveCornorRadiosToView(view: viewLogout)
        // Do any additional setup after loading the view.
        
        
        self.iconProfile.image = UIImage.init(named: "iconEditProfile")?.withRenderingMode(.alwaysTemplate)
        self.iconProfile.tintColor = ThemeYellowColor
        self.iconVehicle.image = UIImage.init(named: "iocnVehicleOptions")?.withRenderingMode(.alwaysTemplate)
        self.iconVehicle.tintColor = ThemeYellowColor
        self.iconAccountInfo.image = UIImage.init(named: "iconAccount")?.withRenderingMode(.alwaysTemplate)
        self.iconAccountInfo.tintColor = ThemeYellowColor
        self.iconDocumentlUser.image = UIImage.init(named: "iconDocument")?.withRenderingMode(.alwaysTemplate)
        self.iconDocumentlUser.tintColor = ThemeYellowColor
        
    }
//    @IBOutlet weak var lblLogout: UILabel!
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(true)
        setLocalizable()
//        self.setNavBarWithBack(Title: "Profile Update".localized, IsNeedRightButton: false)
//        self.title = "Profile Update".localized
       
            self.setNavBarWithMenuORBack(Title: "Profile Update".localized, LetfBtn: kIconBack, IsNeedRightButton: false, isTranslucent: false)

    }
    func setLocalizable()
    {
//        self.headerView?.lblTitle.text =   "Profile Update".localized

        

      
        lblEditProfile.text = "Edit Profile".localized
        lblAccount.text = "Account".localized
        lblVehicleOption.text = "Vehicle Option".localized
        lblDocument.text = "Documents".localized
//        lblLogout.text = "Logout".localized
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func UnWinddBackToProfileVC(segue: UIStoryboardSegue)
    {
        
    }
    
    //-------------------------------------------------------------
    // MARK: - Outlets
    //-------------------------------------------------------------
    
    @IBOutlet var viewEditProfile: UIView!
    @IBOutlet var viewVehicleOption: UIView!
    @IBOutlet var viewAccount: UIView!
    @IBOutlet var viewDocument: UIView!
    
//    @IBOutlet var viewLogout: UIView!

    
    //-------------------------------------------------------------
    // MARK: - Custom Methods
    //-------------------------------------------------------------
    
    func giveCornorRadiosToView(view : UIView)
    {
        
        view.layer.cornerRadius = 10
//        view.clipsToBounds = true
        view.layer.shadowColor = UIColor.lightGray.cgColor
        view.layer.shadowOffset = CGSize(width: 3, height: 3)
        view.layer.shadowOpacity = 0.7
        view.layer.shadowRadius = 4.0
        
//        viewEditProfile.dropShadow()
//        viewVehicleOption.dropShadow()
//        viewAccount.dropShadow()
//        viewDocument.dropShadow()
        //binal temparary bcz color resolution is not proper.
        
        
//        viewEditProfile.layer.cornerRadius = crnRadios
//        viewVehicleOption.layer.cornerRadius = crnRadios
//        viewAccount.layer.cornerRadius = crnRadios
//        viewDocument.layer.cornerRadius = crnRadios

//        viewEditProfile.layer.masksToBounds = true
//        viewVehicleOption.layer.masksToBounds = true
//        viewAccount.layer.masksToBounds = true
//        viewDocument.layer.masksToBounds = true
        
    }
    @IBAction func btnEditProfile(_ sender: UIButton) {
        
//        let next = self.storyboard?.instantiateViewController(withIdentifier: "UpdateProfilePersonelDetailsVC") as! UpdateProfilePersonelDetailsVC
//
//        self.navigationController?.pushViewController(next, animated: true)

        
    }
    @IBAction func btnVehicle(_ sender: UIButton) {
        
        let next = self.storyboard?.instantiateViewController(withIdentifier: "updateDriverSelectVehicleTypesViewControllerViewController") as! updateDriverSelectVehicleTypesViewControllerViewController
        self.navigationController?.pushViewController(next, animated: true)
        
    }
    @IBAction func btnAccount(_ sender: UIButton) {
        
        let next = self.storyboard?.instantiateViewController(withIdentifier: "UpdateProfileAccountVC") as! UpdateProfileAccountVC

        self.navigationController?.pushViewController(next, animated: true)
        
    }
    @IBAction func btnDocument(_ sender: UIButton) {
        
        let next = self.storyboard?.instantiateViewController(withIdentifier: "updateCertificatesViewController") as! updateCertificatesViewController
        
        self.navigationController?.pushViewController(next, animated: true)
//        let alert = UIAlertController(title: nil, message: "Comming Soon", preferredStyle: .alert)
//        
//        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
//        
//        alert.addAction(ok)
//        
//        self.present(alert, animated: true, completion: nil)
        
//        let alert = UIAlertController(title: nil, message: "Up Comming", preferredStyle: .alert)
//
//        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
//
//        alert.addAction(ok)
//
//        self.present(alert, animated: true, completion: nil)
        
    }

    @IBAction func btnLogout(_ sender: Any)
    {
        let LogoutConfirmation = UIAlertController(title: "App Name".localized, message: "Are you sure you want to logout?".localized, preferredStyle: .alert)
        LogoutConfirmation.addAction(UIAlertAction(title: "Logout".localized, style: .destructive, handler: { (UIAlertAction) in
            self.webserviceOFSignOut()
        }))
        LogoutConfirmation.addAction(UIAlertAction(title: "Cancel".localized, style: .cancel, handler: nil))
        self.present(LogoutConfirmation, animated: true, completion: nil)
    
    }
    
    func webserviceOFSignOut()
    {
        let srtDriverID = Singletons.sharedInstance.strDriverID
        
        let param = srtDriverID + "/" + Singletons.sharedInstance.deviceToken
        
        webserviceForSignOut(param as AnyObject) { (result, status) in
            
            if (status) {
                print(result)
                
                let socket = (UIApplication.shared.delegate as! AppDelegate).SocketManager
                
                socket.off(socketApiKeys.kReceiveBookingRequest)
                socket.off(socketApiKeys.kBookLaterDriverNotify)
                
                socket.off(socketApiKeys.kGetBookingDetailsAfterBookingRequestAccepted)
                socket.off(socketApiKeys.kAdvancedBookingInfo)
                
                socket.off(socketApiKeys.kReceiveMoneyNotify)
                socket.off(socketApiKeys.kAriveAdvancedBookingRequest)
                
                socket.off(socketApiKeys.kDriverCancelTripNotification)
                socket.off(socketApiKeys.kAdvancedBookingDriverCancelTripNotification)
                Singletons.sharedInstance.setPasscode = ""
                Singletons.sharedInstance.isPasscodeON = false
                socket.disconnect()
                
                for (key, value) in UserDefaults.standard.dictionaryRepresentation() {
                    print("\(key) = \(value) \n")
                    
                    if(key != "Token" && key != "i18n_language") {
                        UserDefaults.standard.removeObject(forKey: key)
                    }
                }
                UserDefaults.standard.set(false, forKey: "isTripDestinationShow")
                UserDefaults.standard.set(false, forKey: kIsSocketEmited)
                //  UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
                Singletons.sharedInstance.isDriverLoggedIN = false
                self.performSegue(withIdentifier: "SignOutFromSideMenu", sender: (Any).self)
                
            }
            else {
                print(result)
                if let res = result as? String {
                    UtilityClass.showAlert("App Name".localized, message: res, vc: self)
                }
                else if let resDict = result as? NSDictionary {
                    UtilityClass.showAlert("App Name".localized, message: resDict.object(forKey: GetResponseMessageKey()) as! String, vc: self)
                }
                else if let resAry = result as? NSArray {
                    UtilityClass.showAlert("App Name".localized, message: (resAry.object(at: 0) as! NSDictionary).object(forKey: GetResponseMessageKey()) as! String, vc: self)
                }
            }
        }
    }
    
}

extension UIView {
    
    // OUTPUT 1
    func dropShadow()
    {
        self.layer.cornerRadius = 5
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: -1, height: 1)
        self.layer.shadowRadius = 1
        self.layer.masksToBounds = true
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
//        self.layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
   
}

