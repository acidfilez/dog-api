//
//  UIViewController+extensions.swift
//  dog-api
//
//  Created by Magno C. Heck on 1/19/18.
//  Copyright © 2018 none. All rights reserved.
//

import UIKit
import PKHUD

extension UIViewController {
    func showError(_ error: Error) {
        let alert = UIAlertController(
            title: "Error",
            message: error.localizedDescription,
            preferredStyle: UIAlertControllerStyle.alert
        )
        let cancelAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }

    func startLoading() {
        HUD.show(.labeledProgress(title: "Loading...", subtitle: ""))
    }

    func stopLoading() {
        HUD.hide()
    }
}
