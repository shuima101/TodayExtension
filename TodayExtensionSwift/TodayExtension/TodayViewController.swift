//
//  TodayViewController.swift
//  TodayExtension
//
//  Created by 冯广勇 on 2017/7/17.
//  Copyright © 2017年 FengGY. All rights reserved.
//

import UIKit
import NotificationCenter


class TodayViewController: UIViewController, NCWidgetProviding {
    
    lazy var groupDefaults: UserDefaults? = {
        return UserDefaults(suiteName: kGroupName)
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 起始的高度 (iOS 10以后最小高度为110)
        if #available(iOSApplicationExtension 10.0, *) {
            // 展开状态
            extensionContext?.widgetLargestAvailableDisplayMode = .expanded
        }else {//width是不起作用的
            self.preferredContentSize = CGSize(width: 0, height: 150)
        }
    }
    // 点击"折叠"-"展开"按钮/或修改 widgetLargestAvailableDisplayMode 之后会被调用
    @available(iOSApplicationExtension 10.0, *)
    func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize) {
        if activeDisplayMode == .expanded {//展开之后的size
            preferredContentSize = CGSize(width: maxSize.width, height: 220)
        }else {
            preferredContentSize = maxSize;
        }
    }
    
    override func viewDidLayoutSubviews() {
        //切底部圆角，防止10.0系统widget刚出现时底部无圆角的问题
        if #available(iOS 10.0, *) {
            let maskPath = UIBezierPath(roundedRect: self.view.bounds, byRoundingCorners: [.bottomLeft, .bottomRight], cornerRadii: CGSize(width: 15.0, height: 15.0))
            let maskLayer = CAShapeLayer()
            maskLayer.frame = self.view.bounds
            maskLayer.path = maskPath.cgPath
            self.view.layer.mask = maskLayer
        }
    }
    
    //iOS 10 以前, 设置一下边界会好看一点
    func widgetMarginInsets(forProposedMarginInsets defaultMarginInsets: UIEdgeInsets) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        completionHandler(NCUpdateResult.newData)
    }
    
}
