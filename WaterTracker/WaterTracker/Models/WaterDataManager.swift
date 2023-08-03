//
//  WaterManager.swift
//  WaterTracker
//
//  Created by 김건우 on 8/1/23.
//

import Foundation

final class WaterDataManager {
    
    // MARK: - PROPERTIES
    
    // UserDefaults 시스템 선언
    // 목표 물의 양, 오늘 마신 물의 양, 최근 업데이트 날짜를 저장
    let userDefaults = UserDefaults.standard
    
    private var waterIntakeGoalPerDay: Int
    
    // 오늘 날짜(일)를 반환하는 계산 프로퍼티
    var today: Int {
        let today = Date()
        let calendar = Calendar.current
        let day = calendar.component(.day, from: today)
        return day
    }
    
    // MARK: - INIALIZER
    
    init() {
        // UserDefaults에서 해당 키에 데이터가 존재하면
        if let goal = userDefaults.object(forKey: "waterIntakeGoalPerDay") as? Int {
            waterIntakeGoalPerDay = goal
        // 데이터가 존재하지 않으면
        } else {
            // 초기 데이터 설정하기
            waterIntakeGoalPerDay = 2_000
            userDefaults.set(waterIntakeGoalPerDay, forKey: "waterIntakeGoalPerDay")
        }
        
        // 날짜가 바뀌면 (최근 업데이트 날짜와 오늘 날짜가 같지 않다면)
        let lastUpdateDate = getLastUpdateDate()
        // 오늘 하루 물 섭취량을 0으로 초기화하기
        if lastUpdateDate != today {
            userDefaults.setValue(0, forKey: "todayWaterIntakeAmount")
            userDefaults.synchronize()
        }
    }
    
    /// 가장 최근에 마신 물의 양을 업데이트한 날짜(일)를 반환합니다.
    /// - Returns: 가장 최근에 업데이트한 날짜(일)
    func getLastUpdateDate() -> Int {
        let lastUpdateDate = userDefaults.integer(forKey: "lastUpdateDate")
        return lastUpdateDate
    }
    
    /// 오늘 하루 마신 총 물의 양을 반환합니다.
    /// - Returns: 오늘 하루 마신 총 물의 양(ml)
    func getTodayWaterIntake() -> Int {
        let todayWaterIntakeAmount = userDefaults.integer(forKey: "todayWaterIntakeAmount")
        return todayWaterIntakeAmount
    }
    
    /// 일일 목표 마실 물의 양을 반환합니다.
    /// - Returns: 일일 목표 마실 물의 양(ml)
    func getWaterIntakeGoalPerDay() -> Int {
        return waterIntakeGoalPerDay
    }
    
    /// 일일 목표 마실 물의 양을 업데이트합니다.
    /// - Parameter goal: 일일 목표 마실 물의 양(ml)
    /// - Returns: 업데이트 성공 여부
    func setWaterIntakeGoalPerDay(_ goal: Int) -> Bool {
        let minimumWaterIntakeTarget = AppSetting.minimumWaterIntakeTarget
        let maximumWaterInatkeTarget = AppSetting.maximumWaterIntakeTarger
        
        // 일일 목표 마실 물의 양이 (min)~(max) ml가 아니라면
        guard (goal >= minimumWaterIntakeTarget && goal <= maximumWaterInatkeTarget) else {
            // 목표 설정 실패
            return false
        }
        // UserDefaults에 값 저장하기
        userDefaults.setValue(goal, forKey: "waterIntakeGoalPerDay")
        userDefaults.synchronize()
        // 목표 설정 성공
        return true
    }
    
    /// 마신 물의 양을 업데이트합니다.
    /// - Parameter amount: 마신 물의 양(ml)
    func setTodayWaterIntake(_ intakeAmount: Int) {
        // 지금까지 마신 총 물의 양 가져오고
        let currentWaterIntakeAmount = userDefaults.integer(forKey: "todayWaterIntakeAmount")
        // 총 물의 양과 지금 마신 물의 양을 합친 새로운 값을
        let newWaterIntakeAmount = currentWaterIntakeAmount + intakeAmount
        // UserDefaults에 값 저장하기
        userDefaults.setValue(newWaterIntakeAmount, forKey: "todayWaterIntakeAmount")
        userDefaults.setValue(today, forKey: "lastUpdateDate")
        userDefaults.synchronize()
    }
    
    func reset() {
        userDefaults.setValue(0, forKey: "todayWaterIntakeAmount")
        userDefaults.synchronize()
    }
    
}
