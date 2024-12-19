//
//  DetailView.swift
//  Awsome App
//
//  Created by Darrin Jones on 12/19/24.
//

import SwiftUI

struct DetailView: View {
    let creature: Creature
    @State private var creatureDetail = CreatureDetail()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            Text(creature.name.capitalized)
                .font(Font.largeTitle)
                .bold()
                
                .lineLimit(1)
            
            Rectangle()
                .frame(height:1)
                .foregroundStyle(.gray)
                .padding(.bottom)
            
            HStack {
            
                AsyncImage(url: URL(string: creatureDetail.imageURL)) { image in
                        image
                        .resizable()
                        .scaledToFit()
                        .background(.white)
                        .frame(width: 96, height: 96)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .shadow(radius: 8,x:5, y:5)
                        .overlay{
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(.gray.opacity(0.5), lineWidth: 1)
                        }
                    
                } placeholder: {
                    
                   RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(.clear)
//                   Image(systemName: "questionmark.square.dashed")
//                        .resizable()
//                        .scaledToFit()
                }
                .frame(width: 96, height: 96)
                .padding(.trailing)
                
                VStack (alignment: .leading){
                    HStack(alignment: .top) {
                        Text("Height")
                            .font(.title2)
                            .bold()
                            .foregroundStyle(.red)
                        
                        Text(String(format: "%.1f", creatureDetail.height))
                            .font(.largeTitle)
                            .bold()
                    }
                    HStack(alignment: .top) {
                        Text("Weight")
                            .font(.title2)
                            .bold()
                            .foregroundStyle(.red)
                        
                        Text(String(format: "%.1f", creatureDetail.weight))
                            .font(.largeTitle)
                            .bold()
                    }
                }
            }
            Spacer()
            
        }
        .padding()
        .task {
            creatureDetail.urlString = creature.url // use URL passed over in getDetail for CreatureDetail
            await creatureDetail.getData()
        }
    }
}

#Preview {
  DetailView(creature: Creature(
    name: "bulbasure",
    url: "https://pokeapi.co/api/v2/pokemon/1/1"))
}
