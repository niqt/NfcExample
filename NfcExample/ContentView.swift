//
//  ContentView.swift
//  NfcExample
//
//  Created by Nicola De Filippo on 21/04/24.
//

import SwiftUI
import CoreNFC

struct ContentView: View {
    @State var NFCR = NFCReader()
    
    var body: some View {
        VStack(spacing: 10) {
            Text("NFC data: \(NFCR.raw)")
            Button("Read NFC") {
                NFCR.read()
            }
        }
    }
}

#Preview {
    ContentView()
}
