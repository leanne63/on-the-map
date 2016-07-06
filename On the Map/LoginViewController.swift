//
//  LoginViewController.swift
//  On the Map
//
//  Created by leanne on 4/20/16.
//  Copyright © 2016 leanne63. All rights reserved.
//

// TODO: Add keyboard toolbar for <> and Done
// TODO: Put constant strings into plist for localization

import UIKit

class LoginViewController: UIViewController {
	
	// MARK: - Constants
	let loginFailedTitle = "Login failed!"
	let unableToRetrieveUserDataMessage = "Unable to retrieve user data."
	let returnActionTitle = "Return"
	let loginViewToTabViewSegue = "loginViewToTabViewSegue"
	
	// MARK: - Properties (Non-Outlets)
	
	lazy var loginModel = UdacityLogin()
	lazy var userModel = User()
	
	
	// MARK: - Properties (Outlets)
	
	@IBOutlet weak var emailField: UITextField!
	@IBOutlet weak var passwordField: UITextField!
	@IBOutlet weak var loginButton: UIButton!
	
	
	// MARK: - Overrides
	
	override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
		
		subscribeToNotifications()
    }
	
	override func viewWillDisappear(animated: Bool) {
		super.viewWillDisappear(animated)
		
		// remove ourself from all notifications
		NSNotificationCenter.defaultCenter().removeObserver(self)
	}

	override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
		
		// locking this login view to portrait since subviews won't all fit on smaller devices in landscape
		return .Portrait
	}
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		guard let segueId = segue.identifier else {
			return
		}
		
		if segueId == loginViewToTabViewSegue {
			
			let navController = segue.destinationViewController as! UINavigationController
			let tabBarController = navController.childViewControllers[0] as! TabBarController
			
			tabBarController.userModel = userModel

//			let mapController = tabBarController.childViewControllers[0] as! MapViewController
//			mapController.userModel = userModel
//			
//			let tableController = tabBarController.childViewControllers[1] as! UITableViewController
//			tableController.userModel = userModel
		}
	}
	
	
	// MARK: - Actions
	
	@IBAction func loginClicked(sender: UIButton) {
		
		loginModel.loginToUdacity(emailField.text, password: passwordField.text)
	}
	
	
	// MARK: - Notification Handlers
	
	/// Subscribes to any needed notifications.
	private func subscribeToNotifications() {
		
		NSNotificationCenter.defaultCenter().addObserver(self,
		                                                 selector: #selector(loginDidComplete(_:)),
		                                                 name: loginModel.loginDidCompleteNotification,
		                                                 object: nil)
		
		NSNotificationCenter.defaultCenter().addObserver(self,
		                                                 selector: #selector(loginDidFail(_:)),
		                                                 name: loginModel.loginDidFailNotification,
		                                                 object: nil)
	
		NSNotificationCenter.defaultCenter().addObserver(self,
		                                                 selector: #selector(userDataRequestDidComplete(_:)),
		                                                 name: userModel.userDataRequestDidCompleteNotification,
		                                                 object: nil)

		NSNotificationCenter.defaultCenter().addObserver(self,
		                                                 selector: #selector(userDataRequestDidFail(_:)),
		                                                 name: userModel.userDataRequestDidFailNotification,
		                                                 object: nil)
	}
	
	
	/**
	Handles actions needed when login completes successfully.
	
	- parameter: notification object
	
	 */
	func loginDidComplete(notification: NSNotification) {
		
		let accountKey = notification.userInfo![loginModel.accountKey] as! String
		
		userModel.getUserInfo(accountKey)
	}
	
	
	/**
	Handles actions related to a failed login attempt.
	
	- parameter: notification object
	
	*/
	func loginDidFail(notification: NSNotification) {
		
		let alertViewMessage = notification.userInfo![loginModel.messageKey] as! String
		let alertActionTitle = returnActionTitle

		presentAlert(loginFailedTitle, message: alertViewMessage, actionTitle: alertActionTitle)
	}
	
	
	/**
	Handles actions related to completion of a user data request.
	
	- parameter: notification object
	
	*/
	func userDataRequestDidComplete(notification: NSNotification) {
		
		performSegueWithIdentifier(loginViewToTabViewSegue, sender: self)
	}
	
	/**
	Handles actions related to failure of a user data request.
	
	- parameter: notification object
	
	*/
	func userDataRequestDidFail(notification: NSNotification) {
		
		let alertViewMessage = notification.userInfo![loginModel.messageKey] as! String
		let alertActionTitle = returnActionTitle

		presentAlert(unableToRetrieveUserDataMessage, message: alertViewMessage, actionTitle: alertActionTitle)
	}
	
}
