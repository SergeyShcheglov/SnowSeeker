//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Sergey Shcheglov on 13.03.2022.
//

import SwiftUI

extension View {
    @ViewBuilder func phoneOnlyNavigationView() -> some View {
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.navigationViewStyle(.stack)
        } else {
            self
        }
    }
}

struct ContentView: View {
    let resorts: [Resort] = Bundle.main.decode("resorts.json")
    
    @StateObject var favorites = Favorites()
    @State private var searchText = ""
    
    @State private var byDefault = true
    @State private var byCountry = false
    @State private var byAlphabet = false
    
    var body: some View {
        NavigationView {
            List(sortedResorts) { resort in
                NavigationLink {
                    ResortView(resort: resort)
                } label: {
                    HStack {
                        Image(resort.country)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 25)
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                            .overlay {
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(.black, lineWidth: 1)
                            }
                        VStack(alignment: .leading) {
                            Text(resort.name)
                                .font(.headline)
                            Text("\(resort.runs) runs")
                                .foregroundColor(.secondary)
                        }
                        
                        if favorites.contains(resort) {
                            Spacer()
                            Image(systemName: "heart.fill")
                                .accessibilityLabel("This is a favorite place")
                                .foregroundColor(.red)
                        }
                    }
                }
            }
            .navigationTitle("Resorts")
            .searchable(text: $searchText, prompt: "Search for a resort")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Menu {
                        Button {
                            byDefault = true
                            byCountry = false
                            byAlphabet = false
                        } label: {
                            Label("by Default", systemImage: (byDefault ? "checkmark" : ""))
                        }
                        Button {
                            byAlphabet = true
                            byCountry = false
                            byDefault = false
                        } label: {
                            Label("by Alphabet", systemImage: (byAlphabet ? "checkmark" : ""))
                        }
                        Button {
                            byCountry = true
                            byAlphabet = false
                            byDefault = false
                        } label: {
                            Label("by Country", systemImage: (byCountry ? "checkmark" : ""))
                        }
                    } label: {
                        Label("sort", systemImage: "arrow.up.arrow.down")
                            .labelStyle(.titleAndIcon)
                    }
                }
            }
            
            WelcomeView()
        }
        //        .phoneOnlyNavigationView()
        .environmentObject(favorites)
    }
    var filteredResorts: [Resort] {
        if searchText.isEmpty {
            return resorts
        } else {
            return resorts.filter { $0.name.localizedCaseInsensitiveContains(searchText)}
        }
    }
    
    var sortedResorts: [Resort] {
        if byCountry {
            return filteredResorts.sorted { $0.country.caseInsensitiveCompare($1.country) == .orderedAscending }
        } else if byAlphabet {
            return filteredResorts.sorted { $0.name.caseInsensitiveCompare($1.name) == .orderedAscending }
        } else {
            return filteredResorts
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
