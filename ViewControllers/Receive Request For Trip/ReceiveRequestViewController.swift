//
//  ReceiveRequestViewController.swift
//  TiCKTOC-Driver
//
//  Created by Excellent Webworld on 06/11/17.
//  Copyright © 2017 Excellent Webworld. All rights reserved.
//

import UIKit
import SRCountdownTimer
import NVActivityIndicatorView
import MarqueeLabel

class ReceiveRequestViewController: UIViewController, SRCountdownTimerDelegate {


    //-------------------------------------------------------------
    // MARK: - Outlets
    //-------------------------------------------------------------
    
    @IBOutlet weak var viewRequestReceive: UIView!
    
    @IBOutlet weak var lblReceiveRequest: UILabel!
    
    @IBOutlet weak var lblMessage: UILabel!
    
    @IBOutlet weak var viewLocationDetails: UIView!
    @IBOutlet weak var lblGrandTotal: UILabel!
    @IBOutlet weak var lblPickUpLocationInfo: UILabel!
    @IBOutlet weak var lblPickupLocation: MarqueeLabel!
    @IBOutlet weak var lblDropoffLocationInfo: UILabel!
    @IBOutlet weak var lblDropoffLocation: MarqueeLabel!
    
    @IBOutlet weak var imgToFromAddress: UIImageView!
    @IBOutlet weak var constraintHeightTable: NSLayoutConstraint!
    @IBOutlet weak var lblPaymrntType: UILabel!
    //    @IBOutlet weak var lblFlightNumber: UILabel!
    //    @IBOutlet weak var lblNotes: UILabel!
    
    //    @IBOutlet weak var stackViewFlightNumber: UIStackView!
    
    //    @IBOutlet weak var stackViewNotes: UIStackView!
    
    @IBOutlet weak var btnReject: UIButton!
    @IBOutlet weak var btnAccepted: UIButton!
    
    @IBOutlet weak var viewDetails: UIView!
    
    @IBOutlet weak var imgParcelImage: UIImageView!
    @IBOutlet weak var viewCountdownTimer: SRCountdownTimer!
    //    @IBOutlet var constratintHorizontalSpaceBetweenButtonAndTimer: NSLayoutConstraint!
    
    var isAccept : Bool!
    var delegate: ReceiveRequestDelegate!
    
    var strPickupLocation = String()
    var strDropoffLocation = String()
    var strGrandTotal = String()
    var strEstimateFare = String()
    var strRequestMessage = String()
    var strFlightNumber = String()
    var strNotes = String()
    var parcelData =  [[String:AnyObject]]()
    var arrParcel = [[String:AnyObject]]()
    
    @IBOutlet weak var tblParcelImage: UITableView!

    //-------------------------------------------------------------
    // MARK: - Base Methods
    //-------------------------------------------------------------
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imgParcelImage.isHidden = true
        CountDownView()


        if let arrParcelData = parcelData[0]["ParcelInfo"] as? [[String:AnyObject]]
        {
            arrParcel = arrParcelData
        }

        if let imageUrl = parcelData[0]["ParcelImage"] as? String
        {
//            imgParcelImage.sd_addActivityIndicator()
            imgParcelImage.sd_setShowActivityIndicatorView(true)
            imgParcelImage.sd_setImage(with: URL(string: imageUrl), placeholderImage: nil) { (image, error, cacheType, url) in
                self.imgParcelImage.sd_removeActivityIndicator()
                if image != nil {
                    self.imgParcelImage.isHidden = false
                }
            }
        }

        imgToFromAddress.tintColor = UIColor(hex: "86C834")

        constraintHeightTable.constant = CGFloat(60 * arrParcel.count)
        if(constraintHeightTable.constant > 150)
        {
            constraintHeightTable.constant = 150
        }
        
        btnReject.layer.cornerRadius = 5
        btnReject.layer.masksToBounds = true
        
        btnAccepted.layer.cornerRadius = 5
        btnAccepted.layer.masksToBounds = true
        
        btnAccepted.layer.borderWidth = 1
        btnAccepted.layer.borderColor = ThemeYellowColor.cgColor
        
        boolTimeEnd = false
        isAccept = false

        lblPaymrntType.textColor = ThemeYellowColor

        imgParcelImage.layer.borderWidth = 1.0
        imgParcelImage.layer.borderColor = UIColor.gray.cgColor
        imgParcelImage.layer.cornerRadius = 10
        imgParcelImage.layer.masksToBounds = true

        
//        self.playSound()
        
        fillAllFields()
        
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setLocalization()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        viewLocationDetails.layer.cornerRadius = 8.0
        viewLocationDetails.layer.borderWidth = 1.0
        viewLocationDetails.layer.borderColor = UIColor.clear.cgColor
        viewLocationDetails.layer.masksToBounds = true
        viewLocationDetails.layer.shadowColor = UIColor.black.withAlphaComponent(0.80).cgColor
        viewLocationDetails.layer.shadowOffset = CGSize(width: 1, height: 2.0)
        viewLocationDetails.layer.shadowRadius = 5.0
        viewLocationDetails.layer.shadowOpacity = 0.6
        viewLocationDetails.layer.masksToBounds = false
        viewLocationDetails.layer.shadowPath = UIBezierPath(roundedRect: viewLocationDetails.bounds, cornerRadius: viewLocationDetails.layer.cornerRadius).cgPath

    }
    
    func setLocalization(){
//        lblReceiveRequest.text = "Receive Request".localized
//        lblMessage.text = "New booking request arrived".localized
//        lblGrandTotal.text = "Grand Total is".localized
        lblPickUpLocationInfo.text = "Pick up location".localized
        lblDropoffLocationInfo.text = "Drop off location".localized
        btnReject.setTitle("Reject".localized, for: .normal)
        btnAccepted.setTitle("Accept".localized, for: .normal)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func CountDownView() {
        
        viewCountdownTimer.labelFont = UIFont(name: "HelveticaNeue-Light", size: 15.0)
        //                    self.timerView.timerFinishingText = "End"
        viewCountdownTimer.lineWidth = 4
        viewCountdownTimer.lineColor = UIColor.black
        viewCountdownTimer.trailLineColor = ThemeYellowColor
        viewCountdownTimer.labelTextColor = UIColor.black
        viewCountdownTimer.delegate = self
        viewCountdownTimer.start(beginingValue: 30, interval: 1)
//        lblMessage.text = "New booking request arrived from \(appName.kAPPName)"
        
    }
    
    func fillAllFields() {
        
//        if Singletons.sharedInstance.passengerType == "" {
//
//            viewDetails.isHidden = true
//
//            lblGrandTotal.isHidden = true
////            constratintHorizontalSpaceBetweenButtonAndTimer.priority = 1000
////            stackViewFlightNumber.isHidden = true
////            stackViewNotes.isHidden = true
//        }
//        else {
            viewDetails.isHidden = false
            print(strGrandTotal)
            print(strPickupLocation)
            print(strDropoffLocation)
            print(strFlightNumber)
            print(strNotes)
//            if strGrandTotal != "0" {
//                lblGrandTotal.text = "Grand Total : \(strGrandTotal) \(currency)"
//            } else if strEstimateFare != "0" {
//                lblGrandTotal.text = "\("Estimate Fare".localized) : \(strEstimateFare) \(currency)"
//            }
        
//            lblMessage.text = strRequestMessage
            lblPickupLocation.text = strPickupLocation
            lblDropoffLocation.text = strDropoffLocation
            
//            if strFlightNumber.count == 0 {
//                stackViewFlightNumber.isHidden = true
//            }
//            else {
//                stackViewFlightNumber.isHidden = false
//                lblFlightNumber.text = strFlightNumber
//            }
//
//            if strNotes.count == 0 {
//                stackViewNotes.isHidden = true
//            }
//            else {
//                stackViewNotes.isHidden = false
//                lblNotes.text = strNotes
//            }
//        }
        
    }
    
    func timerDidEnd() {
        
        if (isAccept == false)
        {
            if (boolTimeEnd) {
                self.dismiss(animated: true, completion: nil)
            }
            else {
                print(#function)
                self.delegate.didRejectedRequest()
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    
    //-------------------------------------------------------------
    // MARK: - Sound Implement Methods
    //-------------------------------------------------------------
    
    var audioPlayer:AVAudioPlayer!
    
    func playSound() {
        
//        guard let url = Bundle.main.url(forResource: "\(RingToneSound)", withExtension: "mp3") else { return }
//
//        do {
//            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
//            try AVAudioSession.sharedInstance().setActive(true)
//
//            //            audioPlayer = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
//            audioPlayer = try AVAudioPlayer(contentsOf: url)
//            audioPlayer.numberOfLoops = 4
//            audioPlayer.play()
//        }
//        catch let error {
//            print(error.localizedDescription)
//        }
    }
    
    func stopSound() {
        
//        guard let url = Bundle.main.url(forResource: "\(RingToneSound)", withExtension: "mp3") else { return }
//        
//        do {
//            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
//            try AVAudioSession.sharedInstance().setActive(true)
//            
//            audioPlayer = try AVAudioPlayer(contentsOf: url)
//            audioPlayer.stop()
//        }
//        catch let error {
//            print(error.localizedDescription)
//        }
    }
    

    
    //-------------------------------------------------------------
    // MARK: - Actions
    //-------------------------------------------------------------
    
    var boolTimeEnd = Bool()
    
    @IBAction func btnRejected(_ sender: UIButton) {
        if Connectivity.isConnectedToInternet() == false {
            UtilityClass.showAlert("App Name".localized, message: "Sorry! Not connected to internet".localized, vc: self)
            return
        }
        
         Singletons.sharedInstance.firstRequestIsAccepted = false
        isAccept = false
        boolTimeEnd = true
        delegate.didRejectedRequest()
        self.viewCountdownTimer.end()
//        self.stopSound()
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func btnAcceped(_ sender: UIButton) {
        if Connectivity.isConnectedToInternet() == false {
            UtilityClass.showAlert("App Name".localized, message: "Sorry! Not connected to internet".localized, vc: self)
            return
        }
        
        Singletons.sharedInstance.firstRequestIsAccepted = false
        
        isAccept = true
        boolTimeEnd = true
        delegate.didAcceptedRequest()
        self.viewCountdownTimer.end()
        self.stopSound()
        self.dismiss(animated: true, completion: nil)
    }
    // ------------------------------------------------------------
    

    

}


extension ReceiveRequestViewController : UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrParcel.count
    }   

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ParcelTypeTableViewCell", for: indexPath) as? ParcelTypeTableViewCell

        let dictData = arrParcel[indexPath.row] //as? [String:AnyObject]

        var strParcelWeight : String!
        if let strParcelWeight1 = dictData["ParcelWeight"] as? String
        {
            if(strParcelWeight1.trimmingCharacters(in: .whitespacesAndNewlines).count != 0)
            {
                strParcelWeight = strParcelWeight1
            }
        }

        if(strParcelWeight != nil)
        {
            cell?.lblParcelType.text = "Parcel Type = \(dictData["ParcelType"] as? String ?? "")\n\(dictData["ParcelSize"] as? String ?? "")\n\(strParcelWeight ?? "0") Lbs"

        }
        else
        {
            cell?.lblParcelType.text = "Parcel Type = \(dictData["ParcelType"] as? String ?? "")\n\(dictData["ParcelSize"] as? String ?? "")"
        }



        cell?.lblParcelNumberTitle.text = "Parcel \(indexPath.row)"
        if let price = dictData["ParcelPrice"] as? String
        {
            cell?.lblPrice.text = price
        }
        else if let price = dictData["ParcelPrice"] as? Int
        {
            cell?.lblPrice.text = "\(currency) \(price)"
        }

//        cell?.lblPrice.text = dictData["ParcelPrice"] as? String

        return cell ?? UITableViewCell()

    }

    

}
