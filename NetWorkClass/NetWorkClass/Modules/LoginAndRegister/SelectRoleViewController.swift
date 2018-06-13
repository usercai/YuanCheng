//
//  SelectRoleViewController.swift
//  NetWorkClass
//
//  Created by mac on 2017/11/18.
//  Copyright © 2017年 thc. All rights reserved.
//

import UIKit

class SelectRoleViewController: UIViewController {
    @IBOutlet weak var student: UIButton!
    @IBOutlet weak var teacher: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if KUserInfo.UserRole == .Teacher {
            self.teacher.isSelected = true
            self.student.isSelected = false
        }else{
            self.student.isSelected = false
            self.teacher.isSelected = true
        }
    }
    
    @IBAction func teacher(_ sender: UIButton) {
        
        self.teacher.isSelected = true
        self.student.isSelected = false
        KUserInfo.UserRole = .Teacher
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func student(_ sender: UIButton) {
        self.student.isSelected = true
        self.teacher.isSelected = false
        KUserInfo.UserRole = .Student
        self.dismiss(animated: true, completion: nil)
    }
    
}
