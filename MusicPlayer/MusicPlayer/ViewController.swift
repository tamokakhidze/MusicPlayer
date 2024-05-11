//
//  ViewController.swift
//  MusicPlayer
//
//  Created by Tamuna Kakhidze on 10.05.24.
//

import UIKit

class ViewController: UIViewController {
    
    private var imageView = UIImageView()
    private var indicatorImageView = UIImageView()
    private var namesStackView = UIStackView()
    private var progressBarStackView = UIStackView()
    private var progressView = UIProgressView()
    private var timer: Timer?
    private var timeFromStarting: TimeInterval = 0
    private var totalTime: TimeInterval = 208
    private var timesStackView = UIStackView()
    private var playButton = UIButton()
    private var playButtonsStackView = UIStackView()
    private var viewModel = ViewModel()
    private var playButtonClicked = true
    private var playButtonIconView = UIImageView()
    private var tabBar = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        viewModel.delegate = self
    }
    
    private func setup() {
        view.backgroundColor = UIColor(named: "backgroundcolor")
        configureImageView()
        configureIndicatorView()
        configureSongAndArtistName()
        configureProgressBarStackView()
        configurePlayButton()
        configurePlayButtonsStackView()
        configureTabBar()
    }
    
    private func configureImageView() {
        view.addSubview(imageView)
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 110).isActive = true
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 36).isActive = true
        imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -35).isActive = true
        imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -383).isActive = true
        imageView.image = UIImage(named: "soundgarden")
        imageView.contentMode = .scaleAspectFit
        
       
    }
    
    private func configureIndicatorView() {
        view.addSubview(indicatorImageView)
        indicatorImageView.alpha = 0
        indicatorImageView.translatesAutoresizingMaskIntoConstraints = false
        indicatorImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 392).isActive = true
        indicatorImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 156).isActive = true
        indicatorImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -163).isActive = true
        indicatorImageView.image = UIImage(named: "indicator")
    }
    
    
    private func configureSongAndArtistName() {
        view.addSubview(namesStackView)
        namesStackView.axis = .vertical
        namesStackView.alignment = .center
        namesStackView.distribution = .fill
        namesStackView.spacing = 7
        namesStackView.translatesAutoresizingMaskIntoConstraints = false
        namesStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 463).isActive = true
        namesStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 65).isActive = true
        namesStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -65).isActive = true
        
        let songLabel = UILabel()
        songLabel.text = viewModel.song1.name
        songLabel.textColor = .white
        songLabel.font = UIFont(name: "Nunito-Regular", size: 24)
        namesStackView.addArrangedSubview(songLabel)
        
        let artistLabel = UILabel()
        artistLabel.text = viewModel.song1.artist
        artistLabel.font = UIFont(name: "Nunito-Regular", size: 18)
        artistLabel.textColor = .white
        songLabel.font.withSize(18)
        namesStackView.addArrangedSubview(artistLabel)
    }
    
    private func configureProgressBarStackView() {
        view.addSubview(progressBarStackView)
        progressBarStackView.axis = .vertical
        progressBarStackView.alignment = .center
        progressBarStackView.distribution = .fill
        progressBarStackView.spacing = 2
        progressBarStackView.translatesAutoresizingMaskIntoConstraints = false
        progressBarStackView.topAnchor.constraint(equalTo: namesStackView.bottomAnchor, constant: 34).isActive = true
        progressBarStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 21).isActive = true
        progressBarStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -19).isActive = true
        configureProgressView()
        configureTimesStackView()
        
        progressBarStackView.addArrangedSubview(progressView)
        progressBarStackView.addArrangedSubview(timesStackView)
        
    }
    
    private func configureProgressView() {
        view.addSubview(progressView)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.topAnchor.constraint(equalTo: progressBarStackView.topAnchor, constant: 0).isActive = true
        progressView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 22).isActive = true
        progressView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -21).isActive = true
        progressView.heightAnchor.constraint(equalToConstant: 3).isActive = true
        progressView.progressTintColor = .white
        progressView.layer.cornerRadius = 1.5
        
    }
    
    private func configureTimesStackView() {
        view.addSubview(timesStackView)
        timesStackView.axis = .horizontal
        timesStackView.alignment = .center
        timesStackView.distribution = .fill
        timesStackView.spacing = 0
        timesStackView.translatesAutoresizingMaskIntoConstraints = false
        timesStackView.topAnchor.constraint(equalTo: progressView.bottomAnchor, constant: 1).isActive = true
        timesStackView.leadingAnchor.constraint(equalTo: progressBarStackView.leadingAnchor, constant: 0).isActive = true
        timesStackView.trailingAnchor.constraint(equalTo: progressBarStackView.trailingAnchor, constant: 0).isActive = true
        
        let startTimeLabel = UILabel()
        startTimeLabel.text = "1:25"
        startTimeLabel.textColor = .white
        startTimeLabel.font = UIFont(name: "Nunito-Regular", size: 14)
        timesStackView.addArrangedSubview(startTimeLabel)
        
        let fullTimeLabel = UILabel()
        fullTimeLabel.text = viewModel.song1.duration
        fullTimeLabel.font = UIFont(name: "Nunito-Regular", size: 14)
        fullTimeLabel.textColor = .white
        timesStackView.addArrangedSubview(fullTimeLabel)
        
    }
    
    private func configurePlayButton() {
        view.addSubview(playButton)
        playButton.setBackgroundImage(UIImage(named: "circle"), for: .normal)
        playButtonIconView.image = UIImage(named: "pause")
        playButtonIconView.translatesAutoresizingMaskIntoConstraints = false
        playButton.addSubview(playButtonIconView)
        
        playButtonIconView.centerXAnchor.constraint(equalTo: playButton.centerXAnchor).isActive = true
        playButtonIconView.centerYAnchor.constraint(equalTo: playButton.centerYAnchor).isActive = true
        playButtonIconView.widthAnchor.constraint(equalToConstant: 24).isActive = true
        playButtonIconView.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        playButton.addTarget(self, action: #selector(play), for: .touchUpInside)
        
    }
    
    @objc func play() {
        viewModel.playButtonClick(playButton)
    }
    
    private func configurePlayButtonsStackView() {
        view.addSubview(playButtonsStackView)
        playButtonsStackView.axis = .horizontal
        playButtonsStackView.alignment = .center
        playButtonsStackView.distribution = .fill
        playButtonsStackView.spacing = 39.96
        playButtonsStackView.translatesAutoresizingMaskIntoConstraints = false
        playButtonsStackView.topAnchor.constraint(equalTo: progressBarStackView.bottomAnchor, constant: 34).isActive = true
        playButtonsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 21).isActive = true
        playButtonsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
        let skipBack = UIImageView()
        skipBack.image = UIImage(named: "skip-back")
        let shuffle = UIImageView()
        shuffle.image = UIImage(named: "shuffle")
        let skipForward = UIImageView()
        skipForward.image = UIImage(named: "skip-forward")
        let repeatButton = UIImageView()
        repeatButton.image = UIImage(named: "repeat")
        playButtonsStackView.addArrangedSubviews(shuffle, skipBack, playButton, skipForward, repeatButton)
        
        
    }
    
    private func configureTabBar() {
        view.addSubview(tabBar)
        tabBar.axis = .horizontal
        tabBar.alignment = .center
        tabBar.distribution = .fillEqually
        tabBar.spacing = 120
        tabBar.translatesAutoresizingMaskIntoConstraints = false
        tabBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 727).isActive = true
        tabBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        tabBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        tabBar.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        //tabBar.backgroundColor = .white

        // Background Image
        let backgroundImage = UIImage(named: "tabbarphoto")
        let backgroundImageView = UIImageView(image: backgroundImage)
        tabBar.addSubview(backgroundImageView)
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.topAnchor.constraint(equalTo: tabBar.topAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: tabBar.bottomAnchor).isActive = true
        backgroundImageView.widthAnchor.constraint(equalToConstant: 335).isActive = true

        tabBar.sendSubviewToBack(backgroundImageView)

        // Tab Bar Buttons
        let homeButton = UIImageView()
        homeButton.image = UIImage(systemName: "house")
        let musicButton = UIImageView()
        musicButton.image = UIImage(systemName: "music.note")
        let favoriteButton = UIImageView()
        favoriteButton.image = UIImage(systemName: "heart")
        homeButton.translatesAutoresizingMaskIntoConstraints = false
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false

        tabBar.addArrangedSubviews(homeButton, musicButton, favoriteButton)
    }

    
//    private func startMusicTimer() {
//        timer = Timer(timeInterval: 1, target: self, selector: #selector(updateProgressView), userInfo: nil, repeats: true)
//        RunLoop.main.add(timer!, forMode: .common)
//    }
    
//    private func stopMusic() {
//        timer?.invalidate()
//        timer = nil
//    }
    
//    @objc func updateProgressView() {
//        timeFromStarting += 1
//        
//        let progress = Float(timeFromStarting / totalTime)
//        progressView.setProgress(progress, animated: true)
//        
//        if timeFromStarting >= totalTime {
//            stopMusic()
//        }
//        
//    }
    
//    @objc func playButtonClick(_ sender: Any) {
//        
//        if playButtonClicked {
//            playButtonClicked = false
//            playButtonIconView.image = UIImage(named: "pause")
//            scaleUp(for: imageView)
//            viewModel.startMusicTimer(updateProgressView: #selector(updateProgressView))
//        }
//        else {
//            playButtonClicked = true
//            playButtonIconView.image = UIImage(named: "start")
//            scaleDown(for: imageView)
//            stopMusic()
//        }
//    }
    
    func scaleDown(for imageView: UIImageView) {
        
        UIView.animate(withDuration: 1, animations: {
            self.imageView.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        })
        
    }
    
    func scaleUp(for imageView: UIImageView) {
        DispatchQueue.main.asyncAfter(deadline: .now()+0) { [weak self] in
            self!.showIndicator(for: self!.indicatorImageView)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
            UIView.animate(withDuration: 1) {
                imageView.transform = .identity
            }
            self.fadeIndicator(for: self.indicatorImageView)
        }
    }
    
    func showIndicator(for indicator: UIImageView) {
        UIView.animate(withDuration: 0.5, animations: {
            self.indicatorImageView.alpha = 1
        })
    }
    
    func fadeIndicator(for indicator: UIImageView) {
        UIView.animate(withDuration: 0.5) {
            self.indicatorImageView.alpha = 0
        }
    }
    
    
    

    
 
    //box-shadow: 0px -5px 20px 0px #A8BACF1A;

}

extension ViewController: ViewModelDelegate {

    func setImage() {
        playButtonIconView.image = UIImage(named: "pause")
    }
    
    func scaleUp() {
        DispatchQueue.main.asyncAfter(deadline: .now()+0) { [weak self] in
            self!.showIndicator(for: self!.indicatorImageView)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
            UIView.animate(withDuration: 1) { [self] in
                imageView.transform = .identity
            }
            self.fadeIndicator(for: self.indicatorImageView)
        }
    }
    
    func scaleDown() {
        UIView.animate(withDuration: 1, animations: {
            self.imageView.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        })
    }
    
    func setProgress(progress: Float, animated: Bool) {
        progressView.setProgress(progress, animated: true)

    }
    
    
}
