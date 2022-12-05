//
//  VideoTableViewCell.swift
//  VideoPlayFromUrl
//
//  Created by Bimal@AppStation on 02/11/22.
//

import AVKit
import AVFoundation
import UIKit


class VideoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var playerView: UIView!
    @IBOutlet weak var progressSlider: UISlider!
    @IBOutlet weak var timeRemainingLabel: UILabel!
    
    var timer: Timer?
    var timeObserver: Any?
    var player : AVPlayer?
    var playerViewController = AVPlayerViewController()
    var cellModel: VideoTableViewCellModel! {
        didSet {
            
            let asset = AVURLAsset(url: cellModel.url)
            let durationInSeconds = asset.duration.seconds
            let totalTimeInSeconds = durationInSeconds
            
            let min = totalTimeInSeconds / 60
            let sec = totalTimeInSeconds.truncatingRemainder(dividingBy: 60)
            let timeformatter = NumberFormatter()
            timeformatter.minimumIntegerDigits = 2
            timeformatter.minimumFractionDigits = 0
            timeformatter.roundingMode = .down
            let minsStrs = timeformatter.string(from: NSNumber(value: min))
            let secsStrs = timeformatter.string(from: NSNumber(value: sec))
            timeRemainingLabel.text = "\(minsStrs!):\(secsStrs!)"
            
            playerView.layer.sublayers?.forEach{$0.removeFromSuperlayer() }
            debugPrint("==>> \(playerView.layer.sublayers?.count ?? 0)")
            
            player = AVPlayer(url: cellModel.url)
            let playerLayer = AVPlayerLayer(player: player)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                // your code here

                let width = self.playerView.frame.size.width
                let height = self.playerView.frame.size.height
                playerLayer.frame = CGRect (x:0, y:0, width:width, height:height)
              

            }


            playerLayer.videoGravity = AVLayerVideoGravity.resize
            playerView.layer.addSublayer(playerLayer)
            
            let interval = CMTime(seconds: 0.01, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
            timeObserver = player?.addPeriodicTimeObserver(forInterval: interval, queue: DispatchQueue.main, using: { elapsedTime in
                let currentTimeInSeconds = Float(CMTimeGetSeconds(self.player!.currentTime()))
               print("currentTime --- \(self.player!.currentTime())")
                
                self.progressSlider.value = Float(currentTimeInSeconds)
                if let currentItem = self.player?.currentItem {
                    print("current Item ------ \(currentItem)")
                    let duration = currentItem.duration
                    if (CMTIME_IS_INVALID(duration)) {
                        return;
                    }
                    let currentTime = currentItem.currentTime()
                    self.progressSlider.value = Float(CMTimeGetSeconds(currentTime) / CMTimeGetSeconds(duration))
                    
                    // Update time remaining label
                    let totalTimeInSeconds = CMTimeGetSeconds(duration)
                    let remainingTimeInSeconds = Float(totalTimeInSeconds) - Float(currentTimeInSeconds)

                    let mins = remainingTimeInSeconds / 60
                    let secs = remainingTimeInSeconds.truncatingRemainder(dividingBy: 60)
                    let timeformatter = NumberFormatter()
                    timeformatter.minimumIntegerDigits = 2
                    timeformatter.minimumFractionDigits = 0
                    timeformatter.roundingMode = .down
                    guard let minsStr = timeformatter.string(from: NSNumber(value: mins)), let secsStr = timeformatter.string(from: NSNumber(value: secs)) else {
                        return
                    }
              
                    self.timeRemainingLabel.text = "\(minsStr):\(secsStr)"
                
                    print("timeRemainingLabel =====> \(String(describing: self.timeRemainingLabel.text!))")
                    self.cellModel.currentTimeSet = self.player!.currentTime()
                    
                }
                
            })
    
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func playbackSliderValueChanged(_ sender:UISlider)
    {
        guard let duration = player?.currentItem?.duration else { return }
        let value = Float64(progressSlider.value) * CMTimeGetSeconds(duration)
        let seekTime = CMTime(value: CMTimeValue(value), timescale: 1)
        player?.seek(to: seekTime )
    }

}
