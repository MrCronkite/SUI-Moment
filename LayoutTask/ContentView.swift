

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color.green.ignoresSafeArea()
            
            VStack {
                Text("Congratulation!")
                    .font(.system(size: 32))
                    .fontWeight(.bold)
                    .padding(.top, 32)
                    .padding(.horizontal, 10)
                
                Text("В тихой долине раскинулись зеленые луга, утопающие в цветах разноцветных. Легкий ветерок играет с листьями деревьев, создавая нежный шепот природы.")
                    .multilineTextAlignment(.center)
                    .padding([.top, .horizontal], 16)
                
                Button {
                    print("hello world")
                } label: {
                    Text("Click me!")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                }
                .frame(maxWidth: .infinity, maxHeight: 51)
                .background(.green, in:
                                RoundedRectangle(cornerRadius: 26)
                )
                .padding(.top, 45)
                
                Button(action: {
                    print("hello world")
                }, label: {
                    Text("Secondary Action")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(.green)
                        .padding(.top, 18)
                        .padding(.bottom, 32)
                })
            }
            .padding(.horizontal, 32)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .foregroundColor(.white)
                    .padding(.horizontal, 16)
            )
        }
    }
}

#Preview {
    ContentView()
}
