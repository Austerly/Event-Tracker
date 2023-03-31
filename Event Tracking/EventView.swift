//
//  EventView.swift
//  Event Tracking
//
//  Created by Austin on 3/30/23.
//

import SwiftUI

struct EventView: View {
    @State private var addMode = false
    @State private var events = Events.storedEvents
    
    var body: some View {
        List(events, id: \.name) { event in
            
                NavigationLink {
                    EventDetailView(event: event)
                } label: {
                    VStack(alignment: .leading) {
                        Text(event.name)
                            .font(.headline)
                            .multilineTextAlignment(.leading)
                        
                        Text(event.description)
                            .font(.subheadline)
                            .fontWeight(.thin)
                        
                }
               
            }
            
        }
        .navigationTitle("Events")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                
                NavigationLink {
                    NewEventView()
                } label: {
                    Image(systemName: "plus.circle")
                }
                    
            }
        }
        .onAppear(perform: {
            Events.loadEvents()
            events = Events.storedEvents
        })
    }
    
}

struct EventView_Previews: PreviewProvider {
    static var previews: some View {
        EventView()
    }
}
