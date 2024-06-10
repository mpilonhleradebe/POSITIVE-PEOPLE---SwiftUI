import SwiftUI

struct HOME: View {
    
    private var currentTime: String = ""
    @State private var pexels : photoAndArtist?
    let getPhoto = API_CALLS()
    //let errors =
    
    var body: some View {
        GeometryReader { geometry in
            NavigationView{
                ZStack {
                    Color(.black)
                    /*AsyncImage(url: URL(string: pexels?.src.original ?? "")) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: geometry.size.width, height: geometry.size.height)
                            .edgesIgnoringSafeArea(.all)
                            //.clipped() // Ensures the image fits within the frame
                            .opacity(0.8)
                    } placeholder: {
                        Rectangle()
                            .foregroundStyle(Color("customGreen"))
                            
                    }*/
                    Image("Home.img")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .edgesIgnoringSafeArea(.all)
                        //.clipped() // Ensures the image fits within the frame
                        .opacity(0.8)
                    VStack {
                        HStack{
                            /*circles(Circle())
                                .overlay {
                                    shapeIcons(Image(systemName: "arrow.backward"))
                                        .padding(.top, 70)
                                }
                                .padding()*/
                            
                            Spacer()
                            
                            //right side icons
                            circles(Circle())
                                .overlay {
                                    rightshapes(Image(systemName: "bell"))
                                        .padding(.top, 70)}
                                .padding()
                        }
                        //right side icons
                        HStack{
                            Spacer()
                            circles(Circle())
                                .overlay {
                                    rightshapes(Image(systemName: "person"))
                                        .padding(.top, 70)
                                }
                                .padding()
                        }
                        .padding(.top, -100)
                        HStack{
                            Spacer()
                            circles(Circle())
                                .overlay {
                                    Image(systemName: "gearshape")
                                        .resizable()
                                        .foregroundStyle(Color(.white))
                                        .frame(width: 25, height: 25)
                                        .padding(.top, 70)
                                }
                                .padding()
                        }
                        .padding(.top, -100)
                
                        Spacer()
                        
                        HStack{
                            Text("\(greeting()), mpilo")
                                        .foregroundStyle(Color("title color"))
                                        .font(.custom("HelveticaNeue-Bold", size: 40))
                                        .padding(.bottom, 200)
                                        .padding(.trailing, 50)
                                        .padding(5)
                                        .fixedSize()
                        }
                        .onAppear()
                        
                        HStack {
                            NavigationLink(destination: ContentView(), label: {
                                longRectangle(Rectangle())
                                    .foregroundStyle(Color("customGreen"))
                                    .overlay {
                                        textRectangle(Text("Positive News."))
                                    }
                            })
                            
                            
                            NavigationLink(destination: ContentView(), label: {
                                smallRectangle(Rectangle())
                                    .foregroundStyle(Color("customOrange"))
                                    .overlay {
                                        textRectangle(Text("Glimpses"))
                                    }
                            })

                        }
                        .padding(.top,-200)
                        .padding(.trailing, 30)
                        
                        HStack {
                            NavigationLink(destination: ContentView(), label: {
                                smallRectangle(Rectangle())
                                    .foregroundStyle(Color(.gray))
                                    .overlay {
                                        Image(systemName: "plus")
                                            .resizable()
                                            .frame(width: 30, height: 30)
                                            .foregroundStyle(Color(.white))
                                    }
                            })
                            
                            
                            NavigationLink(destination: Gallery(), label: {
                                longRectangle(Rectangle())
                                    .foregroundStyle(Color("customYellow"))
                                    .overlay {
                                        textRectangle(Text("Gallery"))
                                    }
                            })
                        }
                        .padding(.top,-70)
                        .padding(.trailing, 30)
                        
                        
                        
                        Spacer()
                        // END OF VSTACK
                        
                        //LEARN
                        if let photographerURLString = pexels?.photographer_url,
                           let photographerURL = URL(string: photographerURLString) {
                            Link(destination: photographerURL, label: {
                                Text(pexels?.photographer ?? "Image Artist")
                                    .foregroundStyle(Color("title color"))
                                    .font(.custom("SquarePeg-Regular", size: 15))
                                    .padding()
                                    .padding(.top, -25)
                            })
                        }
                            
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height)
                }
                .edgesIgnoringSafeArea(.all)
            }
        }
        .edgesIgnoringSafeArea(.all)
        .navigationBarBackButtonHidden(true)
        .onAppear()
        .task {
            do {
                pexels = try await getPhoto.getPhotoAndArtist()
            }
            
            //handle all declared erros in the enum function
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

    
    
    
    //functions
    
    //function for circle attributes
    func  circles(_ circle: Circle) -> some View {
        return circle
            .frame(width: 54)
            .foregroundColor(.gray)
            .padding(.top, 70)
            .opacity(0.7)
        
    }
    
    //inside shape icon(arrow
    func shapeIcons(_ icon: Image) -> some View {
        return icon
            .resizable()
            .foregroundStyle(Color(.white))
            .frame(width: 20, height: 14)
            
    }
    
    //inside shapes (right)
    func rightshapes(_ shape: Image) -> some View {
        return shape
            .resizable()
            .foregroundStyle(Color(.white))
            .frame(width: 22, height: 25)
    }
    
    
    
    //check time
    func greeting() -> String {
        let currentHour = Calendar.current.component(.hour, from: Date())
        var greeting : String
        switch currentHour {
                case 6..<12:
                    greeting = "morning"
                case 12..<17:
                    greeting = "afternoon"
                case 17..<21:
                    greeting = "evening"
                default:
                    greeting = "night"
                }
        return greeting
    }
    
    
    //rectangle shape
    func longRectangle(_ rectangle: Rectangle) -> some View {
        return rectangle
            .frame(width: 227, height: 124)
            .clipShape(RoundedRectangle(cornerRadius: 25))
            .opacity(0.6)
    }
    
    //smaller rectangle
    func smallRectangle(_ rectangle: Rectangle) -> some View {
        return rectangle
            .frame(width: 110, height: 120)
            .clipShape(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/))
            .opacity(0.6)
    }
    
    // text inside rectangles
    func textRectangle(_ text: Text) -> some View {
        return text
            .foregroundStyle(Color(.white))
            .font(.custom("CormorantSC-Regular", size: 25))
    }
    
}


//error handling
enum PexelError: Error {
    case InvalidUrl
    case InvalidResponse
    case InvalidData
}
#Preview {
    HOME()
}
