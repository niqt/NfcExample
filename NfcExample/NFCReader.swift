//
//  NFCReader.swift
//  NfcExample
//
//  Created by Nicola De Filippo on 27/04/24.
//

import Foundation
import CoreNFC

@Observable
public class NFCReader: NSObject, NFCNDEFReaderSessionDelegate {
    public var startAlert = "Hold your iPhone near the tag."
    public var raw = "Raw Data will be available after scan."
    public var session: NFCNDEFReaderSession?
    
    public func read() {
        guard NFCNDEFReaderSession.readingAvailable else {
            print("Error")
            return
        }
        session = NFCNDEFReaderSession(delegate: self, queue: nil, invalidateAfterFirstRead: true)
        session?.alertMessage = self.startAlert
        session?.begin()
    }
    
    public func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        DispatchQueue.main.async {
            if messages.count > 0, let dataMessage = String(data: messages[0].records[0].payload, encoding:.utf8) {
                self.raw = dataMessage
            }
            //session.invalidate()
        }
    }
    
    public func readerSessionDidBecomeActive(_ session: NFCNDEFReaderSession) {
    }
    
    public func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
        print("Session did invalidate with error: \(error)")
        self.session = nil
    }
}

