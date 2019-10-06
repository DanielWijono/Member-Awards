//
//  AwardsViewController.swift
//  MemberAwards
//
//  Created by Jac'ks Labs on 02/10/19.
//  Copyright © 2019 testing. All rights reserved.
//

import UIKit

struct Awards {
    var type: String
    var point: Int
    var name: String
    var image: String

    init(type:String, point:Int, name:String, image:String) {
        self.type = type
        self.point = point
        self.name = name
        self.image = image
    }
}

class AwardsViewController: UIViewController {
    
    @IBOutlet weak var awardsTableView: UITableView!
    
    let identifierXib = "awardsCell"
    var arrayAwards = [Awards]()
    var filteredArrayAwards = [Awards]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTableView()
        initLeftBar()
        initRightBar()
        setNavigationTitle(titleLabel: "Awards")
        
        arrayAwards.append(Awards.init(type: "vouchers", point: 100000, name: "Gift Card IDR 1.000.000", image: ""))
        arrayAwards.append(Awards.init(type: "vouchers", point: 150000, name: "Gift Card IDR 1.500.000", image: ""))
        arrayAwards.append(Awards.init(type: "products", point: 200000, name: "Gift Card IDR 2.000.000", image: ""))
        arrayAwards.append(Awards.init(type: "giftcards", point: 300000, name: "Gift Card IDR 3.000.000", image: ""))
    }
    
    func setNavigationTitle(titleLabel : String) {
        let labelView = UILabel()
        labelView.text = titleLabel
        labelView.frame = CGRect(x: 0, y: 0, width: labelView.intrinsicContentSize.width, height: labelView.intrinsicContentSize.height)
        labelView.font = UIFont(name: "AvenirNext-DemiBold", size: 16)
        labelView.textColor = .black
        self.navigationItem.titleView = labelView
    }
    
    func initLeftBar() {
        let button = UIButton.init(type: .custom)
        button.setImage(UIImage.init(named: "menudrawer"), for: .normal)
        button.addTarget(self, action:#selector(leftPressed), for:.touchUpInside)
        button.frame = CGRect.init(x: 0, y: 0, width: 30, height: 30)
        let barButton = UIBarButtonItem.init(customView: button)
        self.navigationItem.leftBarButtonItem = barButton
    }
    
    func initRightBar() {
        let button = UIButton.init(type: .custom)
        button.setImage(UIImage.init(named: "filter"), for: .normal)
        button.addTarget(self, action:#selector(rightPressed), for:.touchUpInside)
        button.frame = CGRect.init(x: 0, y: 0, width: 30, height: 30)
        let barButton = UIBarButtonItem.init(customView: button)
        self.navigationItem.rightBarButtonItem = barButton
    }
    
    @objc func rightPressed() {
        print("rightPressed")
        let vc = FilterViewController(nibName: "FilterViewController", bundle: nil)
        vc.delegate = self
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc func leftPressed() {
        print("left pressed")
        let vc = DrawerViewController(nibName: "DrawerViewController", bundle: nil)
        vc.delegate = self
        vc.modalPresentationStyle = .custom
        self.present(vc, animated: true, completion: nil)
    }
}

extension AwardsViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if filteredArrayAwards.count > 0 {
            return filteredArrayAwards.count
        } else {
            return arrayAwards.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifierXib, for: indexPath) as! AwardsTableViewCell
        
        cell.parentView.layer.cornerRadius = 8
        
        if filteredArrayAwards.count > 0 {
            cell.awardsNameLabel.text = filteredArrayAwards[indexPath.row].name
            cell.awardsTypeLabel.text = filteredArrayAwards[indexPath.row].type
            cell.awardsPointLabel.text = String(filteredArrayAwards[indexPath.row].point) + " point"
        } else {
            cell.awardsNameLabel.text = arrayAwards[indexPath.row].name
            cell.awardsTypeLabel.text = arrayAwards[indexPath.row].type
            cell.awardsPointLabel.text = String(arrayAwards[indexPath.row].point) + " point"
        }
        
        if cell.awardsTypeLabel.text == "vouchers" {
            cell.awardsTypeLabel.layer.backgroundColor = UIColor.red.cgColor
            cell.awardsTypeLabel.layer.cornerRadius = 8
        } else if cell.awardsTypeLabel.text == "products" {
            cell.awardsTypeLabel.layer.backgroundColor = UIColor.green.cgColor
            cell.awardsTypeLabel.layer.cornerRadius = 8
        } else if cell.awardsTypeLabel.text == "giftcards" {
            cell.awardsTypeLabel.layer.backgroundColor = UIColor.blue.cgColor
            cell.awardsTypeLabel.layer.cornerRadius = 8
        }
        
        return cell
    }
    
    func initTableView() {
        awardsTableView.dataSource = self
        awardsTableView.delegate = self
        awardsTableView.register(UINib(nibName: "AwardsTableViewCell", bundle: nil), forCellReuseIdentifier: identifierXib)
    }
}

extension AwardsViewController : FilterDelegate {
    func filterInformation(awardType: [String], maxValue: Double) {
        //https://stackoverflow.com/questions/48467867/adding-a-filter-to-an-array-in-swift-4
        //https://stackoverflow.com/questions/52471274/how-do-i-filter-on-an-array-of-objects-in-swift
        //https://stackoverflow.com/questions/47157725/swift-array-filtering-values-in-between-two-numbers
        //https://stackoverflow.com/questions/49842765/swift-how-do-i-filter-array-based-on-another-array
        
        filteredArrayAwards.removeAll()
        
        if awardType.count > 0 && maxValue == 0.0 {
            let filteredArray = arrayAwards.filter {
                awardType.contains($0.type)
            }
            filteredArray.forEach {
                print("filtered array award : \($0)")
                filteredArrayAwards.append($0)
                awardsTableView.reloadData()
            }
        } else if awardType.count == 0 && maxValue != 0.0 {
            let filteredArray = arrayAwards.filter {
                $0.point >= 100000 && $0.point <= Int(maxValue)
            }
            filteredArray.forEach {
                print("filtered array max value : \($0)")
                filteredArrayAwards.append($0)
                awardsTableView.reloadData()
            }
        } else if awardType.count > 0 && maxValue != 0.0 {
            let filteredArray = arrayAwards.filter {
                awardType.contains($0.type) && $0.point >= 100000 && $0.point <= Int(maxValue)
            }
            filteredArray.forEach {
                print("filtered array award max value : \($0)")
                filteredArrayAwards.append($0)
                awardsTableView.reloadData()
            }
        }
    }
}

extension AwardsViewController : DrawerDelegate {
    func logoutDrawer() {
        self.navigationController?.popToRootViewController(animated: true)
    }
}
