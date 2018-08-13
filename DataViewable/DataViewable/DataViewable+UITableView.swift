//
//  DataViewable+UITableView.swift
//  DataViewable
//
//  Created by Ian MacCallum on 7/31/18.
//  Copyright © 2018 Ian MacCallum. All rights reserved.
//

import UIKit

private var kShouldDisplayOverHeader = "shouldDisplayOverHeader"

public extension DataViewable where Self: UITableView {

    public var shouldDisplayDataViewableOverHeader: Bool {
        get {
            return objc_getAssociatedObject(self, &kShouldDisplayOverHeader) as? Bool ?? true
        }
        set {
            if shouldDisplayDataViewableOverHeader != newValue {
                objc_setAssociatedObject(self, &kShouldDisplayOverHeader, newValue, .OBJC_ASSOCIATION_RETAIN)
                reloadEmptyDataSet()
            }
        }
    }

    public var hasData: Bool {

        // Custom user defined hasData parameter
        if let hasData = emptyDataSetSource?.hasDataForDataView(self) {
            return hasData
        }

        // Get the item count
        let itemCount = (0..<numberOfSections).reduce(0) {
            $0 + numberOfRows(inSection: $1)
        }
        
        return itemCount > 0
    }

    public func addContentView(_ contentView: UIView, to containerView: UIView) {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false

        if contentView.superview == nil {
            containerView.addSubview(contentView)
        } else {
            contentView.removeConstraints(contentView.constraints)
        }

        let topConstraint: NSLayoutConstraint

        if let headerView = tableHeaderView, !shouldDisplayDataViewableOverHeader {
            topConstraint = headerView.bottomAnchor.constraint(equalTo: contentView.topAnchor)
        } else {
            topConstraint = frameLayoutGuide.topAnchor.constraint(equalTo: contentView.topAnchor)
        }

        let viewSideConstraints = [
            topConstraint,
            frameLayoutGuide.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            frameLayoutGuide.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            frameLayoutGuide.rightAnchor.constraint(equalTo: contentView.rightAnchor)
        ]

        containerView.addConstraints(viewSideConstraints)
        containerView.layoutIfNeeded()
    }
}