//
//  AppStoreReviewManager.swift
//  TrekPack
//
//  Created by Toby moktar on 2021-01-01.
//  Copyright © 2021 Moktar. All rights reserved.
//

import StoreKit

enum AppStoreReviewManager {
  static func requestReviewIfAppropriate() {
    SKStoreReviewController.requestReview()
  }
}
