//
//  ContentView.swift
//  MotionBearBell
//
//  Created by r.nakamura on 2022/11/23.
//

import SwiftUI
import CoreMotion

struct ContentView: View {

    @ObservedObject var sensor = MotionSensor()

    var body: some View {
        VStack {
            Text(String(sensor.count))
            Text(String(sensor.updateCount))
            Button(action: {
                self.sensor.isStared ? self.sensor.stop() : self.sensor.start()
            }) {
                self.sensor.isStared ? Text("STOP") : Text("START")
            }
            .padding(.top, 50)
        }
    }
}

class MotionSensor: NSObject, ObservableObject {
    
    
    let soundPlayer = SoundPlayer()
    
    @Published var isStared = false
    
    @Published var count: Int = 0
    @Published var updateCount: Int = 0

    @Published var x: Double = 0.0
    @Published var y: Double = 0.0
    @Published var z: Double = 0.0

    let motionManager = CMMotionManager()
    
    func start() {
        if motionManager.isDeviceMotionAvailable {
            motionManager.deviceMotionUpdateInterval = 0.5
            motionManager.startDeviceMotionUpdates(to: OperationQueue.current!, withHandler: {(motion:CMDeviceMotion?, error:Error?) in
                self.updateMotionData(deviceMotion: motion!)
            })
        }
        
        isStared = true
    }
    
    func stop() {
        isStared = false
        motionManager.stopDeviceMotionUpdates()
    }

    private func updateMotionData(deviceMotion: CMDeviceMotion) {
        
        let nowX = deviceMotion.userAcceleration.x
        let nowY = deviceMotion.userAcceleration.y
        let nowZ = deviceMotion.userAcceleration.z
        
        if abs(nowX - x) > 0.2 {
            x = nowX
            count += 1
            soundPlayer.bellPlay()
        }
        if abs(nowY - y) > 0.2 {
            y = nowY
            count += 1
            soundPlayer.bellPlay()
        }
        if abs(nowZ - z) > 0.2 {
            z = nowZ
            count += 1
            soundPlayer.bellPlay()
        }
        
        updateCount += 1
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
