//
//  Constants.swift
//  SmartReceipts
//
//  Created by Jaanus Siim on 16/05/16.
//  Copyright © 2016 Will Baumann. All rights reserved.
//

import Foundation
import QuartzCore

func onMainThread(closure: () -> ()) {
    dispatch_async(dispatch_get_main_queue(), closure)
}

func timeMeasured(desc: String = "", closure: () -> ()) {
    let start = CACurrentMediaTime()
    closure()
    Log.debug(String(format: "%@ - time: %f", desc, CACurrentMediaTime() - start))
}