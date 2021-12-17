//
//  CookingService.swift
//  Mobile Cooking Assistant
//
//  Created by Parshakov Alexander on 12/7/21.
//

import Foundation

final class CookingService {
    private var timer: Timer?
    private var lastTime: TimerValue?
    
    private(set) var state: CookingState?
    
    private(set) var currentRecipe: Recipe?
    
    func startTimer(duration: TimerValue) {
        let interval = 1
        var timePassed = 0
        timer = Timer.scheduledTimer(withTimeInterval: TimeInterval(interval), repeats: true, block: { timer in
            guard timePassed < duration.totalSeconds else {
                timer.invalidate()
                return
            }
            duration.updateDuration(measure: .seconds(.down(value: interval)))
            self.lastTime = duration
            timePassed += interval
        })
    }
    
    func pauseTimer() {
        timer?.invalidate()
    }
    
    func saveLastState(_ state: CookingState?, recipe: Recipe?) {
        currentRecipe = recipe
        self.state = state
    }
}

final class CookingState {
    private(set) var lastStep: Step?
    private(set) var lastPortions: Int?
    
    init(lastStep: Step, lastPortions: Int) {
        self.lastStep = lastStep
        self.lastPortions = lastPortions
    }
}
