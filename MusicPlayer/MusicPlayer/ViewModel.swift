//
//  ViewModel.swift
//  MusicPlayer
//
//  Created by Tamuna Kakhidze on 11.05.24.
//

import Foundation

protocol ViewModelDelegate: AnyObject {
    func setImage()
    func scaleUp()
    func scaleDown()
    func setProgress(progress: Float, animated: Bool)
}
class ViewModel {
    
    let song1 = Song(name: "Fell On Black Days", artist: "Soundgarden", duration: "3.48")
    var timer: Timer?
    private var timeFromStarting: TimeInterval = 0
    private var totalTime: TimeInterval = 208
    private var playButtonClicked = true
    weak var delegate: ViewModelDelegate?
    
    @objc func updateProgressView() {
        timeFromStarting += 1
        
        let progress = Float(timeFromStarting / totalTime)
        delegate?.setProgress(progress: progress, animated: true)
        
        if timeFromStarting >= totalTime {
            stopMusic()
        }
        
    }
    
    private func stopMusic() {
        timer?.invalidate()
        timer = nil
    }
    
    func startMusicTimer() {
        timer = Timer(timeInterval: 1, target: self, selector: #selector(updateProgressView), userInfo: nil, repeats: true)
        RunLoop.main.add(timer!, forMode: .common)
    }
    
    @objc func playButtonClick(_ sender: Any) {
        
        if playButtonClicked {
            playButtonClicked = false
            delegate?.setImage()
            delegate?.scaleUp()
            startMusicTimer()
        }
        else {
            playButtonClicked = true
            delegate?.setImage()
            delegate?.scaleDown()
            stopMusic()
        }
    }

}
