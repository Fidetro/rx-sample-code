//
//  LoginViewModel.swift
//  rx-sample-code
//
//  Created by Fidetro on 2018/5/6.
//  Copyright © 2018年 Fidetro. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
class LoginViewModel: NSObject {
    let loginResult: Observable<Bool>
    init(input: (username: Observable<String>, password: Observable<String>, touchUp: ControlEvent<()>)) {
        
        let usernameAndPassword = Observable.combineLatest(input.username, input.password) {
            ($0, $1)
        }
        
        loginResult = input.touchUp.withLatestFrom(usernameAndPassword).flatMap { (username,password) -> Observable<Bool> in
            
            guard  username.count > 6 else{
                return Observable.just(false)
            }
            guard  password.count > 6 else{
                return Observable.just(false)
            }
            return Observable.create { (observer) -> Disposable in
                //延时1s模拟异步请求登录成功
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1, execute: {
                    observer.onNext(true)
                })
                return Disposables.create {}
            }
        }
        
    }
}
