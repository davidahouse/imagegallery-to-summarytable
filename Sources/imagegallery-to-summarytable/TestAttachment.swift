//
//  File.swift
//  
//
//  Created by David House on 2/28/21.
//

import Foundation

struct AttachmentList: Codable {
    let summary: AttachmentListSummary
    let images: [TestAttachment]
}

struct AttachmentListSummary: Codable {
    let count: Int
}

struct TestAttachment: Codable {
    let title: String
    let fileName: String
    let url: String
}
