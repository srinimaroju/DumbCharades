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
    let pauseIcon = "pause.circle.fill"
    let playIcon = "play.circle.fill"
    let stopIcon = "stop.circle.fill"
    let initTimeRemaining = 100

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
                    timeRemaining = initTimeRemaining
                    buttonText = "Next Movie -->"
                    isTimerActive = true
                    
                } label: {
                    Text(buttonText)
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                        .lineLimit(0)
                        .padding(10.0).frame(maxWidth:.infinity)
                        .font(.system(size: 20, weight: .heavy, design: .default))
        
                }
                .contentShape(Rectangle())
                .background(Color.orange)
            
            HStack {
                Button(action: {
                    isTimerActive = !isTimerActive
                }) {
                    Image(systemName: isTimerActive ? pauseIcon : playIcon)
                }
                .frame(minWidth: 60, maxWidth: 60)
                .foregroundColor(Color.white)

                Text("Remaining - \(timeRemaining)")
                    .frame(minWidth: 150, maxWidth: .infinity)
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
                
                Button(action: {
                    isTimerActive = false
                    timeRemaining = initTimeRemaining
                }) {
                    Image(systemName: stopIcon)
                }
                .frame(minWidth: 60, maxWidth: 60)
                .foregroundColor(Color.white)
            }
            .font(.system(size: 20, weight: .medium, design: .default))
            .foregroundColor(Color.orange)
            .padding(.vertical, 5)
            .frame(maxWidth: .infinity)
            .background(
                Capsule()
                    .fill(Color.black)
                    .opacity(0.75)
            )
            
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
