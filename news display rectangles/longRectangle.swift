import SwiftUI
import SDWebImageSwiftUI

struct LongRectangle: View {
    var isForYou: Bool
    var isTrending: Bool
    var isNew : Bool
    
    @State private var fullyLoaded = false

    var body: some View {
        ZStack {
            if isTrending {
                Rectangle()
                    .frame(width: 380, height: 145)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .foregroundStyle(Color(fullyLoaded ? "customGreen" : "white"))
                    .foregroundStyle(Color(isNew  ? "customYellow" : "white"))
            }
            
            if isForYou {
                Rectangle()
                    .frame(width: 380, height: 150)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .foregroundStyle(Color(fullyLoaded ? "customYellow" : "white"))
            }
            HStack {
                if isForYou {
                    Spacer()
                }
                let imageUrl = isTrending ? "https://images.pexels.com/photos/12375238/pexels-photo-12375238.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2" : "https://images.pexels.com/photos/18983112/pexels-photo-18983112/free-photo-of-table-after-breakfast-full-of-fruits.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2"
                
                AsyncImage(url: URL(string: imageUrl))
                { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 180, height: 122, alignment: .center)
                        .clipped()
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .onAppear {
                            withAnimation(.default) {
                                fullyLoaded.toggle()
                            }
                        }
                } placeholder: {
                    if isForYou && fullyLoaded {
                        Spacer()
                    }

                    HStack {
                        AnimatedImage(name: "rhombus-loader.gif")
                            .resizable()
                            .frame(width: 20, height: 20)
                        Text("Loading...")
                            .font(.footnote)
                            .foregroundStyle(Color(.black))
                            .opacity(0.4)
                    }
                }

                if !isForYou  && fullyLoaded {
                   Spacer()
                }
                
                if fullyLoaded {
                    VStack{
                        Text("Mountains Yield Bumper Crops: Sustainable Farming Practices Thrive at High Altitudes")
                            .font(.custom("HelveticaNeue-Bold", size: 13))
                            .foregroundStyle(Color("title color"))
                            .padding(.top, 40)
                        
                        HStack{Text(isTrending ? "By Emily Carter": "By Daniel Hartman")
                                .frame(alignment: .trailing)
                                .font(.custom("Helvetica-Light-Oblique", size: 10))
                                .foregroundStyle(Color(isTrending ? "title color": "dark text"))
                                .opacity(0.6)
                                .padding(5)
                            Spacer()
                        }
                        
                    }
                    .onAppear{
                        withAnimation(.easeIn(duration: 2)){}
                    }
                    Spacer()
                }
                
                
                //end of horizontal stack
            }
            .padding(20)

        }
        .onAppear {
            withAnimation(.default) {
                
            }
        }
    }
}

#Preview {
   ContentView()
}
