//
//  BottomNav.swift
//  POSITIVE PEOPLE
//
//  Created by Mpilonhle on 2024/06/03.
//

import SwiftUI

struct BottomNav: View {
    
    @State var isPositive = true
    @State var isHome = false
    @State var isgallery = false
    
    var body: some View {
        VStack {
            Spacer()
            Rectangle()
                .frame(width: 240, height: 40)
                .clipShape(RoundedRectangle(cornerRadius: 50))
                .foregroundColor(Color("customGreen"))
                .overlay {
                    HStack {
                        NavigationLink(destination: HOME(), label: {
                            textStyle(Text("home"))
                                .foregroundStyle(Color(.white))
                                .fixedSize()
                                .opacity(isHome ? 1: 0.6)
                                //.padding(.bottom,isHome ? 10: 0)
                            
                                .padding()
                        })
                        

                        Button(action: {
                            withAnimation(.bouncy(duration: 0.4)){
                                isPositive = true
                                isHome = false
                                isgallery = false
                            }
                        }) {
                            textStyle(Text("positive news."))
                                .foregroundStyle(Color(.white))
                                .fixedSize()
                                .opacity(isPositive ? 1: 0.6)
                                //.padding(.bottom,isPositive ? 10: 0)
                        }
                        .padding(-5)

                        Button(action: {
                            withAnimation(.bouncy(duration: 0.4)){
                                isgallery = true
                                isHome = false
                                isPositive = false
                            }
                        }) {
                            textStyle(Text("gallery"))
                                .foregroundStyle(Color(.white))
                                .fixedSize()
                                .opacity(isgallery ? 1: 0.6)
                                //.padding(.bottom,isgallery ? 10: 0)
                        }
                        .padding()
                    }
                }
                .padding(.bottom, 15)
        }
        
        
        //functions
    }
}
                                       

#Preview {
    ContentView()
}
