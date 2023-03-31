//
//  Event_detail.swift
//  Event Tracking
//
//  Created by Austin on 3/30/23.
//

import SwiftUI

struct EventDetailView: View {
    @State var event: Event
    
    var body: some View {
        VStack {
            if let unwrappedEventBlocks = event.eventBlocks {
                List(unwrappedEventBlocks, id: \.name) { eventBlock in
                    NavigationLink {
                        EventBlockView(eventId: event.id, eventBlock: eventBlock, eventBlockName: eventBlock.name, eventBlockStartDate: eventBlock.startTime, eventBlockEndDate: eventBlock.endTime)
                    } label: {
                        VStack(alignment: .leading) {
                            Text(eventBlock.name)
                                .font(.headline)
                            Text("Start Time: \(eventBlock.startTime.formatted(date: .abbreviated, time: .shortened))")
                                .font(.subheadline)
                                .fontWeight(.thin)
                            Text("End Time: \(eventBlock.endTime.formatted(date: .abbreviated, time: .shortened))")
                                .font(.subheadline)
                                .fontWeight(.thin)
                        }
                    }
                }
            } else {
                Text("Click that plus button to create this event's first event block!")
            }
        }
        .navigationTitle(event.name)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    
                    NavigationLink {
                        NewEventBlockView(parentEventId: event.id)
                    } label: {
                        Image(systemName: "plus.circle")
                    }
                        
                }
            }
            
            .onAppear(perform: {
                Events.loadEvents()
                for index in Events.storedEvents.indices {
                    if event.id == Events.storedEvents[index].id {
                        event = Events.storedEvents[index]
                        break
                    }
                }
                
            })
        }

}

struct EventDetailView_Previews: PreviewProvider {
    static var previews: some View {
        EventDetailView(event: Events.storedEvents[0])
    }
}
