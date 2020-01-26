//
//  ContentView.swift
//  Swift_pagination_01
//
//  Created by cf on 2020/1/26.
//  Copyright © 2020 cf. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var items: [DemoItem] = Array(0...24).map { DemoItem(sIndex: $0,page:0) }
    @State private var isLoading: Bool = false
    @State private var page: Int = 0
    private let pageSize: Int = 25
    
    var body: some View {
        NavigationView {
            List(items) { item in
                VStack {
                    Text("page:\(item.page) item:\(item.sIndex)")
                  
                    if self.isLoading && self.items.isLastItem(item) {
                        Divider()
                        Text("Loading ...")
                            .padding(.vertical)

                    }
  
                }.onAppear {
                    self.listItemAppears(item)
                }
            }
            .navigationBarTitle("List of items")
            .navigationBarItems(trailing: Text("Page index: \(page)"))
        }
    }
    
    
}

extension ContentView {
    private func listItemAppears<Item: Identifiable>(_ item: Item) {
        if items.isLastItem(item) {
            isLoading = true
            
            /*
                Simulated async behaviour:
                Creates items for the next page and
                appends them to the list after a short delay
             */
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                self.page += 1
                let moreItems = self.getMoreItems(forPage: self.page, pageSize: self.pageSize)
                self.items.append(contentsOf: moreItems)
                
                self.isLoading = false
            }
        }
    }
    func getMoreItems(forPage: Int, pageSize: Int) -> [DemoItem]{
        let sitems: [DemoItem] = Array(0...24).map { DemoItem(sIndex: $0,page:forPage) }
        return sitems
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

