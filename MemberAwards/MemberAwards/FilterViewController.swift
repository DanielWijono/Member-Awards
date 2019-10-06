//
//  FilterViewController.swift
//  MemberAwards
//
//  Created by Jac'ks Labs on 04/10/19.
//  Copyright © 2019 testing. All rights reserved.
//

import UIKit

protocol FilterDelegate : AnyObject {
    func filterInformation(awardType : [String], maxValue : Double)
}

class FilterViewController: UIViewController {
    
    @IBOutlet weak var parentView: UIView!
    @IBOutlet weak var exitImageView: UIImageView!
    @IBOutlet weak var pointView: UIView!
    @IBOutlet weak var pointLabel: UILabel!
    @IBOutlet weak var clearPointFilter: UIImageView!
    @IBOutlet weak var typeView: UIView!
    @IBOutlet weak var clearTypeFilter: UIImageView!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var clearFilterView: UIView!
    @IBOutlet weak var minValueLabel: UILabel!
    @IBOutlet weak var maxValueLabel: UILabel!
    @IBOutlet weak var horizontalSlider: UISlider!
    @IBOutlet weak var allTypeButton: UIButton!
    @IBOutlet weak var vouchersButton: UIButton!
    @IBOutlet weak var productsButton: UIButton!
    @IBOutlet weak var othersButton: UIButton!
    @IBOutlet weak var filtersButton: UIButton!
    
    var awardType : [String] = []
    var maxValue = 0.0
    weak var delegate : FilterDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initRecognizer()
        initRangeSlider()
        initButtonTarget()
        initView()
    }
    
    func initButtonTarget() {
        allTypeButton.addTarget(self, action: #selector(allTypeClicked(_:)), for: .touchUpInside)
        vouchersButton.addTarget(self, action: #selector(voucherTypeClicked(_:)), for: .touchUpInside)
        productsButton.addTarget(self, action: #selector(productTypeClicked(_:)), for: .touchUpInside)
        othersButton.addTarget(self, action: #selector(otherTypeClicked(_:)), for: .touchUpInside)
        filtersButton.addTarget(self, action: #selector(filtersButtonClicked), for: .touchUpInside)
    }
    
    @objc func filtersButtonClicked() {
        self.dismiss(animated: true, completion: nil)
        delegate?.filterInformation(awardType: awardType, maxValue: maxValue)
    }
    
    @objc func allTypeClicked(_ sender : UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            allTypeButton.setImage(UIImage(named: "unchecked"), for: .normal)
            vouchersButton.setImage(UIImage(named: "unchecked"), for: .normal)
            productsButton.setImage(UIImage(named: "unchecked"), for: .normal)
            othersButton.setImage(UIImage(named: "unchecked"), for: .normal)
            
            vouchersButton.isSelected = false
            productsButton.isSelected = false
            othersButton.isSelected = false
            
            awardType.removeAll()
            
            if awardType.count > 0 {
                typeView.isHidden = false
                typeLabel.text = "Type \(awardType)"
            } else {
                typeView.isHidden = true
            }
        } else { //false
            sender.isSelected = true
            allTypeButton.setImage(UIImage(named: "checked"), for: .normal)
            vouchersButton.setImage(UIImage(named: "checked"), for: .normal)
            productsButton.setImage(UIImage(named: "checked"), for: .normal)
            othersButton.setImage(UIImage(named: "checked"), for: .normal)
            
            vouchersButton.isSelected = true
            productsButton.isSelected = true
            othersButton.isSelected = true
            
            awardType.removeAll()
            awardType.append("vouchers")
            awardType.append("products")
            awardType.append("giftcards")
            
            typeView.isHidden = false
            typeLabel.text = "Type \(awardType)"
            
            if pointView.isHidden == false && typeView.isHidden == false {
                clearFilterView.isHidden = false
            }
        }
    }
    
    @objc func voucherTypeClicked(_ sender : UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            vouchersButton.setImage(UIImage(named: "unchecked"), for: .normal)
            awardType.removeAll { $0 == "vouchers" }
            
            if awardType.count > 0 {
                typeView.isHidden = false
                typeLabel.text = "Type \(awardType)"
            } else {
                typeView.isHidden = true
            }
        } else { //false
            sender.isSelected = true
            vouchersButton.setImage(UIImage(named: "checked"), for: .normal)
            
            if allTypeButton.isSelected {
                awardType.removeAll()
            }
            awardType.append("vouchers")
            typeView.isHidden = false
            typeLabel.text = "Type \(awardType)"
            
            if pointView.isHidden == false && typeView.isHidden == false {
                clearFilterView.isHidden = false
            }
        }
    }
    
    @objc func productTypeClicked(_ sender : UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            productsButton.setImage(UIImage(named: "unchecked"), for: .normal)
            awardType.removeAll { $0 == "products" }
            
            if awardType.count > 0 {
                typeView.isHidden = false
                typeLabel.text = "Type \(awardType)"
            } else {
                typeView.isHidden = true
            }
        } else { //false
            sender.isSelected = true
            productsButton.setImage(UIImage(named: "checked"), for: .normal)
            
            if allTypeButton.isSelected {
                awardType.removeAll()
            }
            awardType.append("products")
            typeView.isHidden = false
            typeLabel.text = "Type \(awardType)"
            
            if pointView.isHidden == false && typeView.isHidden == false {
                clearFilterView.isHidden = false
            }
        }
    }
    
    @objc func otherTypeClicked(_ sender : UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            othersButton.setImage(UIImage(named: "unchecked"), for: .normal)
            awardType.removeAll { $0 == "giftcards" }
            
            if awardType.count > 0 {
                typeView.isHidden = false
                typeLabel.text = "Type \(awardType)"
            } else {
                typeView.isHidden = true
            }
        } else { //false
            sender.isSelected = true
            othersButton.setImage(UIImage(named: "checked"), for: .normal)
            
            if allTypeButton.isSelected {
                awardType.removeAll()
            }
            awardType.append("giftcards")
            typeView.isHidden = false
            typeLabel.text = "Type \(awardType)"
            
            if pointView.isHidden == false && typeView.isHidden == false {
                clearFilterView.isHidden = false
            }
        }
    }
    
    func initRangeSlider() {
        horizontalSlider.frame = CGRect(x: 0, y: 0, width: 250, height: 35)
        horizontalSlider.center = self.view.center
        horizontalSlider.minimumTrackTintColor = .blue
        horizontalSlider.maximumTrackTintColor = .gray
        horizontalSlider.maximumValue = 500000
        horizontalSlider.minimumValue = 100000
        horizontalSlider.setValue(100000, animated: false)
        horizontalSlider.addTarget(self, action: #selector(changeValue(_:)), for: .valueChanged)
        
        minValueLabel.text = String(horizontalSlider.minimumValue)
        maxValueLabel.text = String(horizontalSlider.value)
    }
    
    @objc func changeValue(_ sender: UISlider) {
        maxValue = Double(sender.value)
        maxValueLabel.text = String(sender.value)
        pointLabel.text = "Poin: \(String(horizontalSlider.minimumValue)) \( "-" ) \(String(sender.value))"
        pointView.isHidden = false
        
        if !pointView.isHidden && !typeView.isHidden {
            clearFilterView.isHidden = false
        }
    }
    
    func initView() {
        pointView.layer.borderWidth = 2
        pointView.layer.cornerRadius = 8
        pointView.layer.borderColor = UIColor.blue.cgColor
        pointView.isHidden = true
        
        typeView.layer.borderWidth = 2
        typeView.layer.cornerRadius = 8
        typeView.layer.borderColor = UIColor.blue.cgColor
        typeView.isHidden = true
        
        clearFilterView.layer.borderWidth = 2
        clearFilterView.layer.cornerRadius = 8
        clearFilterView.layer.borderColor = UIColor.blue.cgColor
        clearFilterView.isHidden = true
    }
    
    func initRecognizer() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(exitImageClicked))
        exitImageView.isUserInteractionEnabled = true
        exitImageView.addGestureRecognizer(tap)
        
        let tapPoint = UITapGestureRecognizer(target: self, action: #selector(pointViewClicked))
        pointView.isUserInteractionEnabled = true
        pointView.addGestureRecognizer(tapPoint)
        
        let tapType = UITapGestureRecognizer(target: self, action: #selector(typeViewClicked))
        typeView.isUserInteractionEnabled = true
        typeView.addGestureRecognizer(tapType)
        
        let tapClear = UITapGestureRecognizer(target: self, action: #selector(clearFilterClicked))
        clearFilterView.isUserInteractionEnabled = true
        clearFilterView.addGestureRecognizer(tapClear)
    }
    
    @objc func exitImageClicked() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func pointViewClicked() {
        pointView.isHidden = true
        horizontalSlider.setValue(100000, animated: true)
    }
    
    @objc func typeViewClicked() {
        awardType.removeAll()
        
        typeView.isHidden = true
        
        allTypeButton.setImage(UIImage(named: "unchecked"), for: .normal)
        vouchersButton.setImage(UIImage(named: "unchecked"), for: .normal)
        productsButton.setImage(UIImage(named: "unchecked"), for: .normal)
        othersButton.setImage(UIImage(named: "unchecked"), for: .normal)
        
        vouchersButton.isSelected = false
        productsButton.isSelected = false
        othersButton.isSelected = false
    }
    
    @objc func clearFilterClicked() {
        pointView.isHidden = true
        typeView.isHidden = true
        clearFilterView.isHidden = true
        
        horizontalSlider.setValue(100000, animated: true)
        maxValueLabel.text = String(100000)
        maxValue = 0.0
        
        awardType.removeAll()
        
        allTypeButton.setImage(UIImage(named: "unchecked"), for: .normal)
        vouchersButton.setImage(UIImage(named: "unchecked"), for: .normal)
        productsButton.setImage(UIImage(named: "unchecked"), for: .normal)
        othersButton.setImage(UIImage(named: "unchecked"), for: .normal)
        
        allTypeButton.isSelected = false
        vouchersButton.isSelected = false
        productsButton.isSelected = false
        othersButton.isSelected = false
    }
}
