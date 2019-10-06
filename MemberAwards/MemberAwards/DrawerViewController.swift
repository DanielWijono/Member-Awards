//
//  DrawerViewController.swift
//  MemberAwards
//
//  Created by Jac'ks Labs on 05/10/19.
//  Copyright © 2019 testing. All rights reserved.
//

import UIKit

protocol DrawerDelegate : AnyObject {
    func logoutDrawer()
}

class DrawerViewController: UIViewController {

    @IBOutlet weak var homeLabel: UILabel!
    @IBOutlet weak var logoutLabel: UILabel!
    @IBOutlet weak var blackOverlayView: UIView!
    
    weak var delegate : DrawerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initRecognizer()
    }

    func initRecognizer() {
        let homeTap = UITapGestureRecognizer(target: self, action: #selector(homeTapped))
        homeLabel.isUserInteractionEnabled = true
        homeLabel.addGestureRecognizer(homeTap)
        
        let logoutTap = UITapGestureRecognizer(target: self, action: #selector(logoutTapped))
        logoutLabel.isUserInteractionEnabled = true
        logoutLabel.addGestureRecognizer(logoutTap)
        
        let overlayTap = UITapGestureRecognizer(target: self, action: #selector(overlayTapped))
        blackOverlayView.isUserInteractionEnabled = true
        blackOverlayView.addGestureRecognizer(overlayTap)
    }
    
    @objc func homeTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func logoutTapped() {
        self.dismiss(animated: true, completion: nil)
        delegate?.logoutDrawer()
    }
    
    @objc func overlayTapped() {
        self.dismiss(animated: true, completion: nil)
    }

}
