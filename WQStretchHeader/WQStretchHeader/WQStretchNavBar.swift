//
//  WQStretchNavBar.swift
//  WQStretchHeader
//
//  Created by 王伟奇 on 2019/3/16.
//  Copyright © 2019 王伟奇. All rights reserved.
//

import UIKit

class WQStretchNavBar: UIView {
    
    var titleColor: UIColor? {
        didSet {
            titleLb.textColor = titleColor
        }
    }
    
    private var titleLb: UILabel = {
        let lb = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 30))
        lb.text = "WQ-Swift"
        lb.textColor = .white
        lb.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        lb.textAlignment = .center
        
        return lb
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        var tCenter = center
        tCenter.y += 10
        titleLb.center = tCenter
        addSubview(titleLb)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension UIScreen {
    static var navHeight: CGFloat = {
        return UIScreen.isHairScreen ? 84 : 64
    }()
    static var isHairScreen: Bool {
        if #available(iOS 11, *) {
            guard let w = UIApplication.shared.delegate?.window, let unwrapedWindow = w else {
                return true
            }
            
            if unwrapedWindow.safeAreaInsets.left > 0 || unwrapedWindow.safeAreaInsets.bottom > 0 {
                return true
            }
        }
        return false
    }
}



