//
//  File.swift
//  
//
//  Created by David House on 2/28/21.
//

import Foundation

struct ImageDiff: Codable {
    let new: [TestAttachment]
    let removed: [TestAttachment]
    let changed: [ChangedTestAttachment]
}

struct ChangedTestAttachment: Codable {
    let base: TestAttachment
    let target: TestAttachment
}
