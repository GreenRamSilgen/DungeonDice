//
//  ContentView.swift
//  DungeonDice
//
//  Created by Kiran Shrestha on 1/17/26.
//

import SwiftUI

struct ContentView: View {
    enum Dice : Int, CaseIterable, Identifiable {
        case four = 4
        case six = 6
        case eight = 8
        case ten = 10
        case twelve = 12
        case twenty = 20
        case hundred = 100
        
        var id: Int { rawValue }
        var description : String { "\(rawValue)-sided" }
        
        func roll() -> Int {
            Int.random(in: 1...self.rawValue)
        }
    }
    
    @State private var resultMessage = ""
    @State private var animationTrigger = false
    @State private var isDoneAnimating = true
    
    var body: some View {
        VStack {
            Text("Dungeon Dice")
                .font(.largeTitle)
                .fontWeight(.black)
                .foregroundStyle(.red)
            
            Spacer()
            
            Text(resultMessage)
                .font(.largeTitle)
                .fontWeight(.medium)
                .multilineTextAlignment(.center)
//                .scaleEffect(isDoneAnimating ? 1.0 : 0.6)
//                .opacity(isDoneAnimating ? 1.0 : 0.2)
                .frame(height: 150)
                .rotation3DEffect(isDoneAnimating ? .degrees(720) : .degrees(0), axis: (x: 0, y: 1, z: 1))
                .onChange(of: animationTrigger) {
                    isDoneAnimating = false
                    
                    withAnimation(.interpolatingSpring(duration: 0.6, bounce: 0.4)) {
                        isDoneAnimating = true
                    }
                }
            
            Spacer()
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 102))]) {
                ForEach(Dice.allCases) { dice in
                    Button(dice.description) {
                        resultMessage = "You rolled a \(dice.roll()) on a \(dice.rawValue)-sided dice"
                        animationTrigger.toggle()
                    }
                }
            }
            .buttonStyle(.borderedProminent)
            .tint(.red)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
