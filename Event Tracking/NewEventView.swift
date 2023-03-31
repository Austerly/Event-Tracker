//
//  NewEventView.swift
//  Event Tracking
//
//  Created by Austin on 3/30/23.
//

import SwiftUI

struct NewEventView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State var eventTitle: String = ""
    @State var eventDescription: String = ""
    
    
    func saveEvent() {
        let localEvent = Event(id: Int(Date().timeIntervalSince1970), name: eventTitle, description: eventDescription)
        
        Events.storedEvents.append(localEvent)
        Events.saveEvents()
    }
    
    var body: some View {
        VStack {
            TextField("Event Name", text: $eventTitle)
            TextField("Event Description", text: $eventDescription)
            Button {
                saveEvent()
                dismiss()
            } label: {
                Text("Save Event")
            }
        }
        .padding(.horizontal)
        .navigationTitle("Create New Event")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct NewEventView_Previews: PreviewProvider {
    static var previews: some View {
        NewEventView()
    }
}
