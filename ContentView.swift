//
//  ContentView.swift
//  WeSplit
//
//  Created by Zakir Ufuk Sahiner on 31.01.24.
//
// 100 Days of SwiftUI Project 1

import SwiftUI

struct ContentView: View {
    
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 10
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages = [0, 5, 10, 15, 20, 25]
    
    var totalPP: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPP = grandTotal / peopleCount
        
        return amountPP
    }
    
    var body: some View {
        NavigationStack {
            Form {
                basicInfo
                tipAmountPicker
                result
            }
            .navigationTitle("WeSplit")
            .toolbar {
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

extension ContentView {
    var basicInfo: some View {
        Section {
            TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "EUR"))
                .keyboardType(.decimalPad)
                .focused($amountIsFocused)
            
            Picker("Number of people", selection: $numberOfPeople) {
                ForEach(2..<21) {
                    Text("\($0) people")
                }
            }
        }
    }
    
    var tipAmountPicker: some View {
        Section("How much do you want to tip?"){
            Picker("Tip percentage", selection: $tipPercentage) {
                ForEach(tipPercentages, id: \.self) {
                    Text($0, format: .percent)
                }
            }
            .pickerStyle(.segmented)
        }
    }
    // To get the local currency from iPhone settings 
    var result: some View {
        Section("Amount per person") {
            Text(totalPP, format: .currency(code: Locale.current.currency?.identifier ?? "EUR"))
        }
    }
}

#Preview {
    ContentView()
}
