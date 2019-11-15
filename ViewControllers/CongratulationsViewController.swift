//
//  CongratulationsViewController.swift
//  ODDS-Driver
//
//  Created by Apple on 24/06/19.
//  Copyright © 2019 Excellent Webworld. All rights reserved.
//

import UIKit

class CongratulationsViewController: UIViewController {
    var delegate: CompleterTripInfoDelegate!
    @IBOutlet weak var btnOk: UIButton!
    @IBOutlet weak var lblCongratulationDesc: UILabel!
    @IBOutlet weak var vwCongratulations: UIView!
    var strTotalAmount: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        lblCongratulationDesc.text = strTotalAmount
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        btnOk.layer.cornerRadius = 10
//        btnOk.layer.masksToBounds = true
        
        vwCongratulations.layer.cornerRadius = 10
        vwCongratulations.layer.masksToBounds = true
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func btnOK(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        if Singletons.sharedInstance.passengerType == "other" || Singletons.sharedInstance.passengerType == "others" {
            //            self.completeTripInfo()
        }else {
            self.delegate.didRatingCompleted()
        }
        Singletons.sharedInstance.passengerType = ""
    }
}
