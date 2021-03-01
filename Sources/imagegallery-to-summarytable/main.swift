import Foundation
import ArgumentParser

struct XcodeBuildToSummaryTable: ParsableCommand {
    @Option(name: .shortAndLong, help: "The images capture json file")
    var images: String

    @Option(name: .shortAndLong, help: "The images diff json file")
    var diff: String

    @Option(name: .shortAndLong, help: "An existing summary file to append to")
    var existing: String?
    
    @Option(name: .shortAndLong, help: "Set to the output path to write the results to")
    var outputPath: String
    
    @Option(name: .shortAndLong, help: "Provide a link for the entire summary table")
    var link: String?
    
    mutating func run() throws {
        
        var items = [SummaryTableItem]()
        
        if let existing = existing {
            do {
                let decoder = JSONDecoder()
                let existingData = try Data(contentsOf: URL(fileURLWithPath: existing))
                let existingSummary = try decoder.decode([SummaryTableItem].self, from: existingData)
                items = existingSummary
            } catch {
                throw error
            }
        }
                
        do {
            let decoder = JSONDecoder()
            let imagesData = try Data(contentsOf: URL(fileURLWithPath: images))
            let capturedImages = try decoder.decode(AttachmentList.self, from: imagesData)
            
            var imageBadges = [SummaryTableBadge]()
            imageBadges.append(SummaryTableBadge(shield: "Images%20Captured-\(capturedImages.images.count)-informational", alt: "Images Captured \(capturedImages.images.count)", logo: nil, style: nil))
            items.append(SummaryTableItem(title: "Image Captures", link: link, valueString: nil, valueBadges: imageBadges))
        } catch {
            throw error
        }
        
        do {
            let decoder = JSONDecoder()
            let diffData = try Data(contentsOf: URL(fileURLWithPath: diff))
            let capturedDiff = try decoder.decode(ImageDiff.self, from: diffData)
            
            var diffBadges = [SummaryTableBadge]()
            diffBadges.append(SummaryTableBadge(shield: "Changed%20Images-\(capturedDiff.changed.count)-informational", alt: "\(capturedDiff.changed.count) changed images", logo: nil, style: nil))
            diffBadges.append(SummaryTableBadge(shield: "New%20Images-\(capturedDiff.new.count)-informational", alt: "\(capturedDiff.new.count) new images", logo: nil, style: nil))
            diffBadges.append(SummaryTableBadge(shield: "Removed%20Images-\(capturedDiff.removed.count)-informational", alt: "\(capturedDiff.removed.count) removed images", logo: nil, style: nil))
            items.append(SummaryTableItem(title: "Image Diff", link: link, valueString: nil, valueBadges: diffBadges))
        } catch {
            throw error
        }
        
        do {
            let encoder = JSONEncoder()
            let encodedData = try encoder.encode(items)
            try encodedData.write(to: URL(fileURLWithPath: outputPath))
        } catch {
            throw error
        }
    }
}

XcodeBuildToSummaryTable.main()
