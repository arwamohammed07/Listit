//
//  Logo.swift
//  Testarwa
//
//  Created by Arwa ALghamdi on 12/06/1444 AH.
//

import SwiftUI

struct Logo: View {
    @State var isActive : Bool = false
    @State private var size = 0.5
    @State private var opacity = 0.5
    
    @AppStorage("isUserOnboarded") var isUserOnboarded: Bool = false
    
    var body: some View {
        
        if isActive {
            if !isUserOnboarded {
                OnbordingView()
            } else {
                Homepage()
            }
        } else {
            ZStack {
                Color.white
                    .ignoresSafeArea()
                
                Image("Logo")
                    .resizable()
                    .scaledToFit()
                    .aspectRatio(0.3, contentMode: .fit)
                    .scaleEffect(size)
                    .opacity(opacity)
                    .onAppear {
                        withAnimation(.easeIn(duration: 1.2)) {
                            self.size = 2.00
                            self.opacity = 2.00
                        }
                    }
                
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.7) {
                            withAnimation {
                                self.isActive = true
                            }
                        }
                    }
            }
        }
        
        
    }
}


struct Logo_Previews: PreviewProvider {
    static var previews: some View {
        Logo()
    }
}
