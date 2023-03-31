//
//  NewEventBlockView.swift
//  Event Tracking
//
//  Created by Austin on 3/31/23.
//

import SwiftUI

struct NewEventBlockView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var parentEventId: Int
    
    @State var localEventBlock = EventBlock(id: Int(Date().timeIntervalSince1970), name: "", startTime: Date(), endTime: Date())
    
    func saveEventBlock() {
        for index in Events.storedEvents.indices {
            if Events.storedEvents[index].id == parentEventId {
                if Events.storedEvents[index].eventBlocks == nil {
                    Events.storedEvents[index].eventBlocks = [localEventBlock]
                } else {
                    Events.storedEvents[index].eventBlocks?.append(localEventBlock)
                   
                }
                Events.saveEvents()
                dismiss()
            }
        }
    }
    
    var body: some View {
        VStack {
            TextField("Event Block Name", text: $localEventBlock.name)
            DatePicker(selection: $localEventBlock.startTime, label: { Text("Start Date:") })
                .font(.subheadline)
                .fontWeight(.thin)
            DatePicker(selection: $localEventBlock.endTime, label: { Text("End Date:") })
                .font(.subheadline)
                .fontWeight(.thin)
            Spacer()
                .frame(height: 30.0)
            Button {
                saveEventBlock()
                dismiss()
            } label: {
                Text("Save Event")
            }
        }
        .padding(.horizontal)
        .navigationTitle("Create New Event: \(localEventBlock.name)")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct NewEventBlockView_Previews: PreviewProvider {
    static var previews: some View {
        NewEventBlockView( parentEventId: 0)
    }
}
