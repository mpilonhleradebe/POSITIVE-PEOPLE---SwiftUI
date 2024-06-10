import SwiftUI
import SDWebImageSwiftUI

func headName() -> String {
    let headers = ["Home", "Positive News", "Gallery"]
    let header = headers[1]
    return header
}

struct ContentView: View {
    // State variables for trending & for you buttons
    @State var isForYou = false
    @State var isTrending = true
    @State var isNew = false
    @State private var pexels: photoAndArtist?
    let getPhoto = API_CALLS()
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("background")
                ScrollView {
                    VStack {
                        ZStack {
                            VStack {
                                Image("Home.img")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 400, height: 301)
                                    .clipShape(RoundedRectangle(cornerRadius: 25))
                                    .opacity(0.9)
                                    .overlay {
                                        HStack {
                                            NavigationLink(destination: HOME(), label: {
                                                Image(systemName: "chevron.backward")
                                                    .resizable()
                                                    .frame(width: 15, height: 25)
                                                    .padding(34)
                                            })
                                            
                                            Spacer()
                                            
                                            Text(headName())
                                                .frame(width: 180)
                                                .font(.custom("CormorantSC-Regular", size: 22))
                                            
                                            Image(systemName: "person.fill")
                                                .resizable()
                                                .frame(width: 25, height: 25)
                                                .padding(.leading, 50)
                                            
                                            Spacer()
                                        }
                                        .foregroundColor(.white)
                                        .padding(.top, -110)
                                    }
                                
                                HStack {
                                    Spacer()
                                    if let photographerUrlString = pexels?.photographer_url,
                                       let photographerUrl = URL(string: photographerUrlString) {
                                        Link(destination: photographerUrl, label: {
                                            Text(pexels?.photographer ?? "Image Artist")
                                                .font(.custom("SquarePeg-Regular", size: 15))
                                                .foregroundStyle(Color("lightORdark"))
                                                .padding()
                                                .padding(.top, -25)
                                        })
                                    }
                                }
                                
                                HStack {
                                    Button(action: {
                                        withAnimation(.default) {
                                            isForYou = false
                                            isTrending = true
                                        }
                                    }, label: {
                                        Text("Trending")
                                    })
                                    .padding()
                                    .font(.custom("HelveticaNeue-Bold", size: 14))
                                    .foregroundColor(.primary)
                                    .opacity(isForYou ? 0.6 : 1)
                                    
                                    Spacer()
                                    
                                    Image(systemName: "moonphase.full.moon.inverse")
                                        .resizable()
                                        .frame(width: 10, height: 10)
                                        .opacity(isForYou ? 0.4 : 1)
                                    Image(systemName: "moonphase.full.moon.inverse")
                                        .resizable()
                                        .frame(width: 10, height: 10)
                                        .opacity(isForYou ? 1 : 0.4)
                                    
                                    Spacer()
                                    
                                    Button(action: {
                                        withAnimation(.default) {
                                            
                                            isForYou = true
                                            isTrending = false
                                            isNew = true
                                            
                                        }
                                    }, label: {
                                        Text("For you.")
                                    })
                                    .padding()
                                    .font(.custom("HelveticaNeue-Bold", size: 14))
                                    .foregroundColor(.primary)
                                    .opacity(isForYou ? 1 : 0.6)
                                }
                                
                                // Trending and For you nav line
                                HStack {
                                    if isForYou {
                                        Spacer()
                                    }
                                    Rectangle()
                                        .frame(width: 45, height: 2)
                                        .padding()
                                        .padding(.top, -35)
                                        .foregroundColor(Color("customGreen"))
                                    if isTrending {
                                        Spacer()
                                    }
                                }
                                Spacer()
                            }
                        }
                        .padding(.bottom, 40) // Add padding to prevent content from being hidden behind the navigator
                    }
                }
                
                LongRectangle(isForYou: isForYou, isTrending: isTrending,isNew: isNew)
                    .padding(.top, 100)
                
                // Bottom navigator
                BottomNav()
            }
            .edgesIgnoringSafeArea(.all)
        }
        .navigationBarBackButtonHidden(true)
        .task {

            do {
                pexels = try await getPhoto.getPhotoAndArtist()
            }
            //handle all declared errors in the enum function
            catch PexelError.InvalidUrl {
                print("Invalid Url")
            }
            catch PexelError.InvalidResponse {
                print("Invalid Response")
            }
            catch PexelError.InvalidData {
                print("Invalid Data")
            }
            catch {
                print("Unexpected error")
            }
        }
    }
}
// Text style function
func textStyle(_ text: Text) -> some View {
    return text
        .font(.custom("HelveticaNeue-Bold", size: 12))
}

#Preview {
    ContentView()
}
