//
//  TimerValue.swift
//  Mobile Cooking Assistant
//
//  Created by Parshakov Alexander on 12/6/21.
//

import Foundation

final class TimerValue {
    var minutes: Int = 0
    var seconds: Int = 0
    
    var totalSeconds: Int {
        minutes * 60 + seconds
    }
    
    init(minutes: Int, seconds: Int) {
        self.minutes = minutes
        self.seconds = seconds
    }
    
    func updateDuration(measure: DurationMeasure) {
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
}

enum DurationMeasure {
    case minutes(_ direction: Direction)
    case seconds(_ direction: Direction)
}

enum Direction {
    case up(value: Int)
    case down(value: Int)
}

