import UIKit

var greeting = "Hello, playground"


//https://uyhlxbgjwqazkhajcecy.supabase.co
//eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InV5aGx4Ymdqd3FhemtoYWpjZWN5Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2ODMzMzAwODAsImV4cCI6MTk5ODkwNjA4MH0.ZRIjFNvN-p9L-TEHNCBBZhZ8D3c-I1nDd54PmKEAsNA


enum PlaygroundError: Error {
    case anyError
}


guard let url = URL(string: "https://uyhlxbgjwqazkhajcecy.supabase.co/rest/v1/familyMembers") else {
    throw PlaygroundError.anyError
}

let apiKey = ""

var request = URLRequest(url: url)
request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
request.addValue(apiKey, forHTTPHeaderField: "apikey")

Task {
    let (data, response) = try await URLSession.shared.data(for: request)
    print(response)
    print(String(data: data, encoding: .utf8)!)
}





