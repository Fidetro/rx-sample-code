//
//  ViewController.swift
//  rx-sample-code
//
//  Created by Fidetro on 2018/5/6.
//  Copyright © 2018年 Fidetro. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
class ViewController: UIViewController {
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    let disposeBag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let viewModel = LoginViewModel.init(input: (username: usernameTextField.rx.text.orEmpty.asObservable(),
                                                    password: passwordTextField.rx.text.orEmpty.asObservable(),
                                                    touchUp: loginButton.rx.controlEvent(.touchUpInside)))
        
        viewModel.loginResult.subscribe(onNext: { (result) in
            if result == true {
                print("登录成功")
            }else{
                print("登录失败")
            }
        }).disposed(by: disposeBag)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

