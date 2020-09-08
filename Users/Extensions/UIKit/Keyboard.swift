//
//  Keyboard.swift
//  Users
//
//  Created by Svyatoslav Katola on 08.09.2020.
//  Copyright © 2020 Soprano. All rights reserved.
//

import UIKit

enum Keyboard {
    
    struct Options {
        let frameEnd: CGRect
        let animationDuration: TimeInterval
        let animationCurve: UIView.AnimationCurve
    }
}

extension Keyboard.Options {
    
    init?(notification: Notification) {
        guard let userInfo = notification.userInfo,
            let frameEndValue = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
            let curveNumber = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber,
            let durationNumber = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber else {
                return nil
        }
        
        frameEnd = frameEndValue.cgRectValue
        animationDuration = durationNumber.doubleValue
        animationCurve = UIView.AnimationCurve(rawValue: curveNumber.intValue) ?? .linear
    }
    
    var animationOptions: UIView.AnimationOptions {
        return .init(rawValue: .init(animationCurve.rawValue))
    }
}

extension Notification.Name {
    
    static let keyboardWillHide = UIResponder.keyboardWillHideNotification
    static let keyboardWillShow = UIResponder.keyboardWillShowNotification
}
