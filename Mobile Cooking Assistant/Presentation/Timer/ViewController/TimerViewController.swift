//
//  TimerViewController.swift
//  Mobile Cooking Assistant
//
//  Created by Parshakov Alexander on 10/12/21.
//

import UIKit
                        
final class TimerViewController: UIViewController {
    
    @IBOutlet private var minutesBackgroundView: UIView!
    @IBOutlet private var secondsBackgroundView: UIView!
    @IBOutlet private var minutesLabel: UILabel!
    @IBOutlet private var secondsLabel: UILabel!
    
    @IBOutlet private var minutesUpButton: UIButton!
    @IBOutlet private var minutesDownButton: UIButton!
    @IBOutlet private var secondsUpButton: UIButton!
    @IBOutlet private var secondsDownButton: UIButton!
    
    @IBOutlet private var recentCollectionView: UICollectionView!
    @IBOutlet private var timeLeftLabel: UILabel!
    @IBOutlet private var stopButton: UIButton!
    @IBOutlet private var startPauseButton: UIButton!
    
    private var recentTimerValues: [TimerValue] = [] {
        didSet {
            UIView.animate(withDuration: 0.4) {
                if self.recentTimerValues.count > 6 {
                    self.recentTimerValues.removeFirst()
                }
                DispatchQueue.main.async {
                    self.recentCollectionView.insertItems(at: [.init(item: 0, section: 0)])
                }
            }
        }
    }
    private var timerValue: TimerValue = .init(minutes: 1, seconds: 10)
    private var timer: Timer?
    
    private var minutes: Int = 1 {
        didSet {
            minutesLabel.text = String(minutes)
            if minutesLabel.text?.count == 1 {
                minutesLabel.text = "0" + (minutesLabel.text ?? "")
            }
            timeLeftLabel.text = minutesLabel.text! + ":" + secondsLabel.text! + " left"
        }
    }
    private var seconds: Int = 10 {
        didSet {
            secondsLabel.text = String(seconds)
            if secondsLabel.text?.count == 1 {
                secondsLabel.text = "0" + (secondsLabel.text ?? "")
            }
            timeLeftLabel.text = minutesLabel.text! + ":" + secondsLabel.text! + " left"
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        stopButton.setTitle("Stop", for: .normal)
        startPauseButton.setTitle("Start", for: .normal)
        timeLeftLabel.text = minutesLabel.text! + ":" + secondsLabel.text! + " left"
        
        recentCollectionView.register(UINib(nibName: DurationCell.identifier, bundle: nil), forCellWithReuseIdentifier: DurationCell.identifier)
        
        minutes = 1
        seconds = 10
    }
    
    @IBAction private func didTapMinutesUpButton(_ sender: Any) {
        timerValue.updateDuration(measure: .minutes(.up(value: 1)))
        minutes = timerValue.minutes
    }
    @IBAction private func didTapMinutesDownButton(_ sender: Any) {
        timerValue.updateDuration(measure: .minutes(.down(value: 1)))
        minutes = timerValue.minutes
    }
    
    @IBAction private func didTapSecondsUpButton(_ sender: Any) {
        timerValue.updateDuration(measure: .seconds(.up(value: 1)))
        seconds = timerValue.seconds
    }
    @IBAction private func didTapSecondsDownButton(_ sender: Any) {
        timerValue.updateDuration(measure: .seconds(.down(value: 1)))
        seconds = timerValue.seconds
    }
    
    @IBAction private func didTapTimerStopButton(_ sender: Any) {
        stopButton.isEnabled = false
        minutesUpButton.isEnabled = true
        minutesDownButton.isEnabled = true
        secondsUpButton.isEnabled = true
        secondsDownButton.isEnabled = true
        
        startPauseButton.setTitle("Start", for: .normal)
        startPauseButton.backgroundColor = .green
        timer?.invalidate()
        
        recentCollectionView.isUserInteractionEnabled = true
    }
    
    @IBAction private func didTapStartPauseButton(_ sender: Any) {
        recentCollectionView.isUserInteractionEnabled = false
        
        if startPauseButton.currentTitle == "Start" && !recentTimerValues.contains(where: { timerValue in
            timerValue.minutes == minutes && timerValue.seconds == seconds
        }) {
            recentTimerValues.append(.init(minutes: minutes, seconds: seconds))
        }
        
        DispatchQueue.main.async { [weak self] in
            if self?.timer?.isValid == true {
                self?.timer?.invalidate()
                self?.startPauseButton.setTitle("Resume", for: .normal)
                self?.startPauseButton.backgroundColor = .green
                return
            }
            self?.startPauseButton.setTitle("Pause", for: .normal)
            self?.startPauseButton.backgroundColor = .orange
            self?.stopButton.isEnabled = true
            self?.minutesUpButton.isEnabled = false
            self?.minutesDownButton.isEnabled = false
            self?.secondsUpButton.isEnabled = false
            self?.secondsDownButton.isEnabled = false
            
            self?.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                if self?.minutes == 0 && self?.seconds == 0 {
                    self?.timer?.invalidate()
                    return
                }
                self?.timerValue.updateDuration(measure: .seconds(.down(value: 1)))
                
                if let seconds = self?.timerValue.seconds {
                    self?.seconds = seconds
                }
            }
        }
    }
    
    private func setupViews() {
        minutesBackgroundView.makeRound(.specific(radius: 15))
        secondsBackgroundView.makeRound(.specific(radius: 15))
        
        stopButton.makeRound(.specific(radius: 15))
        startPauseButton.makeRound(.specific(radius: 15))
    }
}

extension TimerViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        recentTimerValues.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let currentRecentValue = recentTimerValues.reversed()[indexPath.item]
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DurationCell.identifier, for: indexPath) as? DurationCell {
                
                cell.configure(duration: currentRecentValue)
                return cell
            }
            return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? DurationCell {
            cell.showAnimatedPress { [weak self] in
                self?.timerValue = cell.duration
                self?.minutes = cell.duration.minutes
                self?.seconds = cell.duration.seconds
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = collectionView.frame.width * 0.2
        return CGSize(width: 100, height: 35)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}
