//
//  main.swift
//  KakaoPaySukHoYu
//
//  Created by Yu Juno on 2021/06/30.
//

import UIKit

let appDelegateClass: AnyClass = NSClassFromString("TestingAppDelegate") ?? AppDelegate.self

UIApplicationMain(
	CommandLine.argc,
	CommandLine.unsafeArgv, nil,
	NSStringFromClass(appDelegateClass)
)

