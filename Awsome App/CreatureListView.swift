//
//  ContentView.swift
//  Awsome App
//
//  Created by Darrin Jones on 12/18/24.
//

import SwiftUI
import SwiftData

struct CreatureListView: View {
    @State var creatures = Creatures()

    var body: some View {
        NavigationStack {
            List(creatures.creaturesArray, id: \.self) { creature in
                NavigationLink {
                   DetailView(creature: creature)
                } label: {
                    Text(creature.name.capitalized)
                        .font(.title2)
                }
                
            }
            .listStyle(.plain)
            .navigationTitle("Pokemon")
        }
        .task {
            await creatures.getData()
        }
    }
}

#Preview {
    CreatureListView()
        .modelContainer(for: Item.self, inMemory: true)
}
