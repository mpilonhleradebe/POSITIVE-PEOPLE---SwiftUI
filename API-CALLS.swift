import SwiftUI

struct API_CALLS: View {
    var body: some View {
        Text("Hello, World!")
            .onAppear {
                Task {
                    do {
                        let result = try await getPhotoAndArtist()
                        print(result)
                    } catch {
                        print("Error: \(error)")
                    }
                }
            }
    }
    
    // Defining API key
    let apiKey = "sghIkaphUkhxDHt2XA27iWROPIdtOzhID160do6HyUEd8HzTzN5ImNjz"
    
    // Function to get info from API
    func getPhotoAndArtist() async throws -> photoAndArtist {
        let endpoint = "https://api.pexels.com/v1/photos/4322027"
        
        guard let url = URL(string: endpoint) else {
            throw PexelError.InvalidUrl
        }
        
        // API authorization
        var urlRequest = URLRequest(url: url)
        urlRequest.setValue(apiKey, forHTTPHeaderField: "Authorization")
        
        // Network request (GET)
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        // Handle response from network request
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            //print(response)
            throw PexelError.InvalidResponse
        }
        
        // Work with data to convert JSON into the photoAndArtist object we created and also decode it
        do {
            // Decoding
            let decoder = JSONDecoder()
            // Add data from the JSON to the photoAndArtist object we created and return it
            return try decoder.decode(photoAndArtist.self, from: data)
        } catch {
            throw PexelError.InvalidData
        }
    }
}

// Object for the JSON data
struct photoAndArtist: Codable {
    let url: String
    let photographer: String
    let photographer_url: String
    let src: Src
}
struct Src: Codable {
       let original: String
   }

/*enum PexelError: Error {
    case InvalidUrl
    case InvalidResponse
    case InvalidData
}*/

#Preview {
    HOME()
}
