//
//  AlertUtils.swift
//  warmingUpProject_3
//
//  Created by 이규현 on 2020/09/08.
//  Copyright © 2020 team3. All rights reserved.
//

import UIKit

class AlertUtils {
    
    public enum PermissionType: Int {
        case CAMERA = 10,
        PHOTO_ALBUM
    }
    
    static func showPermissionAlarmAlert(_ viewController: UIViewController, completion: (() -> Void)? = nil) {
        
        let message = "\n\n중복된 닉네임입니다.\n\n"
        let dialog = UIAlertController(title: "북쪽으로📚", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "확 인", style: UIAlertAction.Style.default)
        
        dialog.addAction(action)
        viewController.present(dialog, animated: true, completion: completion)
    }
}
