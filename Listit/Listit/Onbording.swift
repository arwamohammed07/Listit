//
//  Onbording.swift
//  Testarwa
//
//  Created by Arwa ALghamdi on 13/06/1444 AH.
//

import SwiftUI


enum OnbordingType: CaseIterable {
    case Add
    case VoiceCommand
    case Remind
    
    // MARK: -
    var image: String {
        switch self {
        case .Add:
            return "Add"
        case .Remind:
            return "remind"
        case .VoiceCommand:
            return "Voice Command"
       
        }
    }
    // MARK: -
    var title: String {
        switch self {
        case .Add:
            return "Add"
        case .Remind:
            return "Remind"
        case .VoiceCommand:
            return "Accessibility"
        
       
        }
    }
    // MARK: -
    var description: String {
        switch self {
        case .Add:
            return "Add your task details."
        case .Remind:
            return "Enable notification to get reminder of your tasks."
        case .VoiceCommand:
            return "Supports Arabic and English languages, and voice over."

        }
    }

    
}

// MARK: -

struct OnbordingView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @AppStorage("isUserOnboarded") var isUserOnboarded: Bool = false
    @State var selectedOnbordingType: OnbordingType = .Add
    
    var body: some View {
        ZStack{
            
            TabView(selection: $selectedOnbordingType) {
                
                ForEach(OnbordingType.allCases, id: \.title) { onbording in
                    SingleOnbordingView(onbordingType: onbording)
                        .tag(onbording)
                        .onChange(of: selectedOnbordingType, perform: { newValue in
                            selectedOnbordingType = newValue
                        })
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .always))
            .indexViewStyle(.page(backgroundDisplayMode: .always))
            
            if selectedOnbordingType != .Remind {
                skipButton
            }
        }
        .onAppear {
            setupAppearance()
        
        }
    }
}


struct OnbordingView_Previews: PreviewProvider {
    static var previews: some View {
        OnbordingView()
    }
}
// MARK: -
extension OnbordingView {
    var skipButton: some View {
        Button {
            withAnimation(.spring()) {
                isUserOnboarded = true
            }
        } label: {
            Text("skip")
                .padding(10)
        }
        .padding(.top, 1)
        .padding(.trailing)
        .frame(maxWidth: .infinity, alignment: .trailing)
        .frame(maxHeight: .infinity, alignment: .top)
        .foregroundColor(.secondary)
    }
}
// MARK: -

extension OnbordingView {
    func setupAppearance() {
        UIPageControl.appearance().currentPageIndicatorTintColor =
        colorScheme == .dark ? .white : .black
        UIPageControl.appearance().pageIndicatorTintColor = colorScheme == .dark ? UIColor.white.withAlphaComponent(0.2) : UIColor.black.withAlphaComponent(0.2)
    }
}

