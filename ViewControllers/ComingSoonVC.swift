//
//  ComingSoonVC.swift
//   TenTaxi-Driver//
//  Created by Excellent Webworld on 14/11/17.
//  Copyright © 2017 Excellent Webworld. All rights reserved.
//

import UIKit

class ComingSoonVC: UIViewController {

    @IBOutlet weak var lblUpComing: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
//        lblUpComing.text = "".localized
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func btnBack(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    

}






