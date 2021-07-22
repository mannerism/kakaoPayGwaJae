//
//  TestingAppDelegate.swift
//  APIUnitTest
//
//  Created by Yu Juno on 2021/06/30.
//
import UIKit

@objc(TestingAppDelegate)
final class TestingAppDelegate: UIResponder, UIApplicationDelegate {
	
	func application(
		_ application: UIApplication,
		didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
	) -> Bool {
		for sceneSession in application.openSessions {
				application.perform(
					Selector(("_removeSessionFromSessionSet:") ),
					with: sceneSession)
		}
		return true
	}
	
	// MARK: UISceneSession Lifecycle
	func application(
		_ application: UIApplication,
		configurationForConnecting connectingSceneSession: UISceneSession,
		options: UIScene.ConnectionOptions
	) -> UISceneConfiguration {
		let sceneConfiguration = UISceneConfiguration(
			name: nil,
			sessionRole: connectingSceneSession.role)
		sceneConfiguration.delegateClass = TestingSceneDelegate.self
		sceneConfiguration.storyboard = nil
		
		return sceneConfiguration
	}
}
