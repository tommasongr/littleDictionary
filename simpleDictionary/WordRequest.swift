//
//  WordRequest.swift
//  simpleDictionary
//
//  Created by Tommaso Negri on 23/04/2020.
//  Copyright © 2020 Tommaso Negri. All rights reserved.
//

import Foundation

struct WordRequest {
    let API_HEADER = [
        "x-rapidapi-host": "lingua-robot.p.rapidapi.com",
        "x-rapidapi-key": "67fd5cf601msh382ba30a8182f55p16125ajsnc4de5a346fb0"
    ]
    
    func requestWords(word: String, completionHandler: @escaping (_ entries: [Word]) -> Void) {
        let request = NSMutableURLRequest(url: NSURL(string: "https://lingua-robot.p.rapidapi.com/language/v1/entries/en/" + word)! as URL,
                                                        cachePolicy: .useProtocolCachePolicy,
                                                    timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = API_HEADER
                
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            
            guard let data = data, error == nil else {
                print("Something went wrong")
                return
            }
            
            var result: Words?
            do {
//                let httpResponse = response as? HTTPURLResponse
//                print(httpResponse!)
                
                result = try JSONDecoder().decode(Words.self, from: data)
            } catch {
                print("FAILED: \(error)")
            }
            
            guard let json = result else {
                return
            }
            
            completionHandler(json.entries)
        })

        dataTask.resume()
    }
    
}
