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
    }
    
    @IBAction private func didTapMinutesUpButton(_ sender: Any) {
        updateDuration(measure: .minutes(.up(value: 1)))
    }
    @IBAction private func didTapMinutesDownButton(_ sender: Any) {
        updateDuration(measure: .minutes(.down(value: 1)))
    }
    
    @IBAction private func didTapSecondsUpButton(_ sender: Any) {
        updateDuration(measure: .seconds(.up(value: 1)))
    }
    @IBAction private func didTapSecondsDownButton(_ sender: Any) {
        updateDuration(measure: .seconds(.down(value: 1)))
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
    }
    
    @IBAction private func didTapStartPauseButton(_ sender: Any) {
        
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
                self?.updateDuration(measure: .seconds(.down(value: 1)))
            }
        }
    }
    
    private func updateDuration(measure: DurationMeasure) {
        switch measure {
        case .minutes(let direction):
            switch direction {
            case .up(let value):
                minutes += value
            case .down(let value):
                minutes = max(0, minutes - value)
            }
        case .seconds(let direction):
            switch direction {
            case .up(let value):
                if seconds + value == 60 {
                    updateDuration(measure: .minutes(.up(value: 1)))
                    seconds = 0
                    return
                }
                seconds += value
            case .down(let value):
                if seconds - value == -1 {
                    guard minutes > 0 else { return }
                    updateDuration(measure: .minutes(.down(value: 1)))
                    seconds = 59
                    return
                }
                seconds -= value
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

private enum DurationMeasure {
    case minutes(_ direction: Direction)
    case seconds(_ direction: Direction)
}

private enum Direction {
    case up(value: Int)
    case down(value: Int)
}
