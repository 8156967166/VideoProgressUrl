//
//  VideoTableViewCellModel.swift
//  VideoPlayFromUrl
//
//  Created by Bimal@AppStation on 02/11/22.
//

import Foundation
import CoreMedia

enum VideoCelltype {
    case videoCell
   
}

class VideoTableViewCellModel {
    
    var identifier: String = "video.cell"
    var cellType: VideoCelltype = .videoCell
    var currentTimeSecond: Float!
    var url: URL
//    var isSelected: Bool = false
    var autoPlay: Bool = true
    var currentTimeSet: CMTime!
  
    
    init(url: URL, celltype: VideoCelltype) {
        self.cellType = celltype
        self.url = url
        switch celltype {
        case .videoCell:
            identifier = "video.cell"
        }
    }
    
    
}
