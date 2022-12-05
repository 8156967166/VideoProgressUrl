//
//  ViewController.swift
//  VideoPlayFromUrl
//
//  Created by Bimal@AppStation on 02/11/22.
//
import AVKit
import AVFoundation
import UIKit

class VideoViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var isSelectCell = Bool()
    var videoArray = [VideoTableViewCellModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.handleScroll()
        videoArray.append(contentsOf: [
            
            VideoTableViewCellModel(url: URL(string:"https://github.com/ravanar-sk/Test_Assets/blob/main/v1.mp4?raw=true")! , celltype: .videoCell),
            VideoTableViewCellModel(url: URL(string: "https://github.com/ravanar-sk/Test_Assets/blob/main/v2.mp4?raw=true")!, celltype: .videoCell),
            VideoTableViewCellModel(url: URL(string: "https://github.com/ravanar-sk/Test_Assets/blob/main/v3.mp4?raw=true")!, celltype: .videoCell),
            VideoTableViewCellModel(url: URL(string: "https://github.com/ravanar-sk/Test_Assets/blob/main/v4.mp4?raw=true")!, celltype: .videoCell),
            VideoTableViewCellModel(url: URL(string: "https://github.com/ravanar-sk/Test_Assets/blob/main/v5.mp4?raw=true")!, celltype: .videoCell),
            VideoTableViewCellModel(url: URL(string: "https://github.com/ravanar-sk/Test_Assets/blob/main/v6.mp4?raw=true")!, celltype: .videoCell),
            VideoTableViewCellModel(url: URL(string: "https://github.com/ravanar-sk/Test_Assets/blob/main/v7.mp4?raw=true")!, celltype: .videoCell),
            VideoTableViewCellModel(url: URL(string: "https://github.com/ravanar-sk/Test_Assets/blob/main/v8.mp4?raw=true")!, celltype: .videoCell),
            VideoTableViewCellModel(url: URL(string: "https://github.com/ravanar-sk/Test_Assets/blob/main/v9.mp4?raw=true")!, celltype: .videoCell),
            VideoTableViewCellModel(url: URL(string: "https://github.com/ravanar-sk/Test_Assets/blob/main/v10.mp4?raw=true")!, celltype: .videoCell),
            VideoTableViewCellModel(url: URL(string: "https://github.com/ravanar-sk/Test_Assets/blob/main/v11.mp4?raw=true")!, celltype: .videoCell),
            VideoTableViewCellModel(url: URL(string: "https://github.com/ravanar-sk/Test_Assets/blob/main/v12.mp4?raw=true")!, celltype: .videoCell),
            VideoTableViewCellModel(url: URL(string: "https://github.com/ravanar-sk/Test_Assets/blob/main/v13.mp4?raw=true")!, celltype: .videoCell),

        ])
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.handleScroll()
    }
    

}

extension VideoViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videoArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellModel = videoArray[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellModel.identifier, for: indexPath) as! VideoTableViewCell
        // convert

        cell.cellModel = cellModel
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as? VideoTableViewCell
        let cellModel = videoArray[indexPath.row]
        guard let player = cell?.player else { return }
        
        if !player.isPlaying {
            cell?.player?.seek(to: cellModel.currentTimeSet)
            cell?.player?.play()
        } else {
            cell?.player?.pause()
        }
        
        if cellModel.autoPlay == false {
            cellModel.autoPlay = true
        }
        else {
            cellModel.autoPlay = false
        }
        
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.handleScroll()
    }
    
    func handleScroll() {
        
        if let indexPathsForVisibleRows = tableView.indexPathsForVisibleRows, indexPathsForVisibleRows.count > 0 {
            var focusCell: VideoTableViewCell?
            
            for indexPath in indexPathsForVisibleRows {
                let cellModel = videoArray[indexPath.row]
                if let cell = tableView.cellForRow(at: indexPath) as? VideoTableViewCell {
                    if focusCell == nil {
                        let rect = tableView.rectForRow(at: indexPath)
                        if tableView.bounds.contains(rect) {
                            if cellModel.autoPlay == false {
                                cell.player?.pause()
                            }
                            else {
                                cell.player?.play()
                                
                            }
                            
                            focusCell = cell
                        } else {
                        
                            cell.player?.pause()
                        }
                    } else {
               
                        cell.player?.pause()
                    }
                }
            }
        }
       
    }
    
}


extension AVPlayer {
    var isPlaying: Bool {
        return rate != 0 && error == nil
    }
}
