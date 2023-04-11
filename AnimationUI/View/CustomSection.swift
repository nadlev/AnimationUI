//
//  CustomSection.swift
//  AnimationUI
//
//  Created by Надежда Левицкая on 4/11/23.
//

import SwiftUI

struct CustomSection: View {
    @Binding var selectedSection: Section
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                ForEach(Section.allCases, id: \.rawValue) { tab in
                    Image(tab.rawValue)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30, height: 30)
                        .offset(y: offset(tab))
                        .contentShape(Rectangle())
                        .onTapGesture {
                            withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.6)) {
                                selectedSection = tab
                            }
                        }
                        .frame(maxWidth: .infinity)
                }
            }
            .padding(.top, 12)
            .padding(.bottom, 20)
        }
        .padding(.bottom, safeArea.bottom == 0 ? 30 : safeArea.bottom)
        .background(content: {
            ZStack {
                BarCurve()
                    .stroke(.white, lineWidth: 0.5)
                    .blur(radius: 0.6)
                    .padding(.horizontal, -10)
                
                BarCurve()
                    .fill(Color("BackgroundColor").opacity(0.5).gradient)
                    
            }
        })
        .overlay {
            GeometryReader { proxy in
                let rect = proxy.frame(in: .global)
                let width = rect.width
                let maxWidth = width * 5
                let height = rect.height
                
                Circle()
                    .fill(.clear)
                    .frame(width: maxWidth, height: maxWidth)
                    .background(alignment: .top) {
                        Rectangle()
                            .fill(.linearGradient(
                                colors: [Color("TabBarBackgroundColor"), Color("BackgroundColor"), Color("BackgroundColor")],
                                startPoint: .top,
                                endPoint: .bottom))
                            .frame(width: width, height: height)
                            .mask(alignment: .top) {
                                Circle()
                                    .frame(width: maxWidth, height: maxWidth, alignment: .top)
                            }
                    }
                    .overlay(content: {
                        Circle()
                            .stroke(.white, lineWidth: 0.3)
                            .blur(radius: 0.6)
                    })
                    .frame(width: width)
                    .background(content: {
                        Rectangle()
                            .fill(.white)
                            .frame(width: 45, height: 4)
                        
                            .glow(.white.opacity(0.5), radius: 50)
                            .glow(Color("Black").opacity(0.7), radius: 30)
                            .offset(y: -1.5)
                            .offset(y: -maxWidth / 2)
                            .rotationEffect(.init(degrees: calculateRotation(maxWidth: maxWidth / 2, actualWidth: width, true)))
                            .rotationEffect(.init(degrees: calculateRotation(maxWidth: maxWidth / 2, actualWidth: width)))
                    })
                    .offset(y: height / 2.1)
            }
            .overlay(alignment: .bottom) {
                Text(selectedSection.rawValue)
                    .font(.system(size: 14))
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .offset(y: safeArea.bottom == 0 ? -15 : -safeArea.bottom + 12)
            }
        }
        .preferredColorScheme(.dark)
    }
    
    func calculateRotation(maxWidth y: CGFloat, actualWidth: CGFloat, _ isInitial: Bool = false) -> CGFloat {
        let sectionWidth = actualWidth / Section.count
        let firstSectionPositionX: CGFloat = -(actualWidth - sectionWidth) / 2
        let tan = y / firstSectionPositionX
        let radians = atan(tan)
        let degree = radians * 180 / .pi
        
        if isInitial {
            return -(degree + 90)
        }
        
        let x = sectionWidth * selectedSection.index
        let tan2 = y / x
        let radians2 = atan(tan2)
        let degree2 = radians2 * 180 / .pi
        
        return -(degree2 - 90)
    }
    
    func offset(_ section: Section) -> CGFloat {
        let totalIndices = Section.count
        let currentSection = section.index
        let progress = currentSection / totalIndices
        
        return progress < 0.5 ? (currentSection * -10) : ((totalIndices - currentSection - 1) * -10)
    }
}

struct CustomSection_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct BarCurve: Shape {
    func path(in rect: CGRect) -> Path {
        return Path { path in
            let height = rect.height
            let width = rect.width
            let midWidth = rect.width / 2
        
            path.move(to: .init(x: 0, y: 5))
            path.addCurve(to: .init(x: midWidth, y: -20),
                          control1: .init(x: midWidth / 2, y: -20),
                          control2: .init(x: midWidth, y: -20))
            path.addCurve(to: .init(x: width, y: 5),
                          control1: .init(x: (midWidth + (midWidth / 2)), y: -20),
                          control2: .init(x: width, y: 5))
            
            path.addLine(to: .init(x: width, y: height))
            path.addLine(to: .init(x: 0, y: height))
            
            path.closeSubpath()
        }
    }
}
