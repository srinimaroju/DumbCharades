//
//  ContentView.swift
//  DumbCharades
//
//  Created by Pavan on 7/23/21.
//

import SwiftUI
import Combine

struct ContentView: View {
    @ObservedObject var viewModel: MovieViewModel
    @State private var buttonText: String = "Start Playing..!"
    @State var currentDate = Date()
    @State private var timeRemaining = 100
    @State private var isTimerActive = false

    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()


    init() {
        viewModel = MovieViewModel()
    }
     var body: some View {
        HStack {
           VStack(alignment: .leading) {
              AsyncImageView(
                url: $viewModel.movie.imageUrl,
                placeholder: { Text(viewModel.movie.title!) }
                ).aspectRatio(contentMode: .fit)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            

                Text(viewModel.movie.title!)
                    .font(.headline)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth:.infinity)
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)

                Button {
                    print("Tapped")
                    viewModel.getMovies()
                    timeRemaining = 100
                    buttonText = "Next Movie -->"
                    isTimerActive = true
                    
                } label: {
                    Text(buttonText)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .foregroundColor(Color.white)
                        .lineLimit(0)
                        .padding(10.0).frame(maxWidth:.infinity)
                        .font(.system(size: 20, weight: .heavy, design: .default))
        
                }
                .contentShape(Rectangle())
                .background(Color.orange)
                
                Text("Remaining - \(timeRemaining)")
                    .font(.system(size: 20, weight: .medium, design: .default))
                    .foregroundColor(Color.orange)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 5)
                    .frame(maxWidth: .infinity)
                    .background(
                        Capsule()
                            .fill(Color.black)
                            .opacity(0.75)
                    )
                    .onReceive(timer) { time in
                        guard isTimerActive else { return }
                        if self.timeRemaining > 0 {
                            self.timeRemaining -= 1
                        }
                    }.onAppear {
                        isTimerActive = true
                    }.onDisappear {
                        isTimerActive = false
                    }
            
           }.frame(maxHeight: .infinity)
           .padding(10.0)
        }.frame(maxWidth:.infinity)
     }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

