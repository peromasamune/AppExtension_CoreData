//
//  ShareViewController.swift
//  ACShareExtension
//
//  Created by Taku Inoue on 2015/12/09.
//  Copyright (c) 2015年 Taku Inoue. All rights reserved.
//

import UIKit
import Social
import MobileCoreServices
import ACFramework

class ShareViewController: SLComposeServiceViewController {

    override func isContentValid() -> Bool {
        // Do validation of contentText and/or NSExtensionContext attachments here
        return true
    }

    override func didSelectPost() {
        // This is called after the user selects Post. Do the upload of contentText and/or NSExtensionContext attachments.
    
        // Inform the host that we're done, so it un-blocks its UI. Note: Alternatively you could call super's -didSelectPost, which will similarly complete the extension context.
        
        let inputItem : NSExtensionItem = self.extensionContext!.inputItems.first as! NSExtensionItem
        let itemProvider : NSItemProvider = inputItem.attachments?.first as! NSItemProvider
        let contentType = kUTTypeURL as String
        
        if itemProvider.hasItemConformingToTypeIdentifier(contentType) {
            itemProvider.loadItemForTypeIdentifier(contentType, options: nil, completionHandler: { (item, error) -> Void in
                if let urlItem = item as? NSURL {
                    println("url : \(urlItem.absoluteString) title : \(self.contentText)")
                    
                    ACDataManager.createMemo(self.contentText, block: { (completed) -> Void in
                        let outputItem : NSExtensionItem = inputItem.copy() as! NSExtensionItem
                        outputItem.attributedContentText = NSAttributedString(string: self.contentText, attributes: nil)
                        let outputItems = [outputItem]
                        self.extensionContext?.completeRequestReturningItems(outputItems, completionHandler: { (completed) -> Void in
                            
                        })
                    })
                }
            })
        }
    }

    override func configurationItems() -> [AnyObject]! {
        // To add configuration options via table cells at the bottom of the sheet, return an array of SLComposeSheetConfigurationItem here.
        return []
    }

}
