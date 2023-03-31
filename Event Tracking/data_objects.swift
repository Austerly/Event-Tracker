//
//  data_objects.swift
//  Event Tracking
//
//  Created by Austin on 3/30/23.
//

import Foundation

struct Event: Encodable, Decodable {
    var id: Int
    var name: String
    var description: String
    var eventBlocks: [EventBlock]?
}

struct EventBlock: Encodable, Decodable {
    var id: Int
    var name: String
    var startTime: Date
    var endTime: Date
}

struct Events: Equatable, Encodable {
    
    static var storedEvents: [Event] = []
    
    static func saveEvents() {
                
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let archiveURL = documentsDirectory.appendingPathComponent("events").appendingPathExtension("plist")
        
        let propertyListEncoder = PropertyListEncoder()
        
        let encodedEvents = try? propertyListEncoder.encode(Events.storedEvents)
        
        try? encodedEvents?.write(to: archiveURL, options: .noFileProtection)
    }
    
    static func loadEvents() {
        let propertyListDecoder = PropertyListDecoder()
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let archiveURL = documentsDirectory.appendingPathComponent("events").appendingPathExtension("plist")

        if let retrievedEventsData = try? Data(contentsOf: archiveURL),
        let decodedEvents = try?
        propertyListDecoder.decode(Array<Event>.self, from: retrievedEventsData) {
            Events.storedEvents = decodedEvents
        }
    }
}
