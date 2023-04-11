//
//  HomeView.swift
//  AnimationUI
//
//  Created by Надежда Левицкая on 4/11/23.
//

import SwiftUI

struct Home: View {
    
    @State private var activeSection: Section = .explore
    
    var body: some View {
        
        VStack(spacing: 0) {
            Spacer()
            
            CustomSection(selectedSection: $activeSection)
        }
        .ignoresSafeArea(.all, edges: .bottom)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            Rectangle()
                .fill(Color("BackgroundColor"))
                .ignoresSafeArea()
        }
        .persistentSystemOverlays(.hidden)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
