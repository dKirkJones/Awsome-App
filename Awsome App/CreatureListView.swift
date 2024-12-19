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
            List(0..<creatures.creaturesArray.count, id: \.self) { index in
                NavigationLink {
                   DetailView(creature: creatures.creaturesArray[index])
                } label: {
                    Text("\(index + 1)")
                    Text(creatures.creaturesArray[index].name.capitalized)
                        .font(.title2)
                }
            }
            .listStyle(.plain)
            .navigationTitle("Pokemon")
            .toolbar {
                ToolbarItem(placement: .status) {
                    Text("Creature Count \(creatures.creaturesArray.count) of \(creatures.count)")
               }
            }
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
