//
//  ViewController.swift
//  ReceiptValidator2
//
//  Created by David Mar on 10/22/17.
//  Copyright © 2017 Piso13. All rights reserved.
//

import UIKit
import StoreKit

public class ViewController: UIViewController, SKRequestDelegate {
    
    let receiptValidator = ReceiptValidator()
    let receiptRequest = SKReceiptRefreshRequest()
    
    // MARK: View Controller Life Cycle Methods
    override public func viewDidLoad() {
        super.viewDidLoad()
        receiptRequest.delegate = self
        
        let validationResult = receiptValidator.validateReceipt()
        
        switch validationResult {
        case .success:
            print(validationResult)
        // Enable app features
        case .error(let error):
            print(error)
            receiptRequest.start()
        }
    }
    
    public func requestDidFinish(_ request: SKRequest) {
        do {
            try receiptValidator.validateReceipt()
        } catch {
            // Log unsuccessful attempt and optionally begin grace period
            // before disabling app functionality, or simply disable features
        }
    }
    
    public func request(_ request: SKRequest, didFailWithError error: Error) {
        // debug error condition
        print(error.localizedDescription)
        
        // Log unsuccessful attempt and optionally begin grace period
        // before disabling app functionality, or simply disable features
    }
}

