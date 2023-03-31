//
//  EventBlockView.swift
//  Event Tracking
//
//  Created by Austin on 3/30/23.
//

import SwiftUI

struct EventBlockView: View {
    
    var eventId: Int
    var eventBlock: EventBlock
    
    @State var eventBlockName: String
    @State var eventBlockStartDate: Date
    @State var eventBlockEndDate: Date
    
    func saveEventBlock() {
        var localEventBlock = eventBlock
        localEventBlock.name = eventBlockName
        localEventBlock.startTime = eventBlockStartDate
        localEventBlock.endTime = eventBlockEndDate
        
        print("localEventBlock: \(localEventBlock)")
        
        for index in Events.storedEvents.indices {
            if Events.storedEvents[index].id == eventId {
                
                // safely unwrap eventBlocks
                if let loopingIndexBlocks = Events.storedEvents[index].eventBlocks {
                    for indexTwo in loopingIndexBlocks.indices {
                        if loopingIndexBlocks[indexTwo].id == eventBlock.id {
                            Events.storedEvents[index].eventBlocks![indexTwo] = localEventBlock
                            Events.saveEvents()
                            break
                        }
                    }
                }
                break
            }
        }
                
    }
    
    var body: some View {
        VStack {
            VStack(alignment: .center, spacing: 0.0) {
                TextField(eventBlock.name, text: $eventBlockName)
                    .font(.title)
                Spacer()
                    .frame(height: 30.0)
            }
            VStack {
                DatePicker(selection: $eventBlockStartDate, label: { Text("Start Date:") })
                    .font(.subheadline)
                    .fontWeight(.thin)
                DatePicker(selection: $eventBlockEndDate, label: { Text("End Date:") })
                    .font(.subheadline)
                    .fontWeight(.thin)
                Spacer()
                    .frame(height: 30.0)
                Button {
                    saveEventBlock()
                } label: {
                    Text("Save Event Block")
                        .font(.callout)
                }
                .backgroundStyle(.green)

            }
            .navigationTitle(eventBlockName)
            .navigationBarTitleDisplayMode(.inline)
        }
        .padding(.horizontal)
    }
}

struct EventBlockView_Previews: PreviewProvider {
    static var previews: some View {
        EventBlockView(eventId: Events.storedEvents[0].id, eventBlock: Events.storedEvents[0].eventBlocks![0], eventBlockName: Events.storedEvents[0].eventBlocks![0].name, eventBlockStartDate: Events.storedEvents[0].eventBlocks![0].startTime, eventBlockEndDate: Events.storedEvents[0].eventBlocks![0].endTime)
    }
}
