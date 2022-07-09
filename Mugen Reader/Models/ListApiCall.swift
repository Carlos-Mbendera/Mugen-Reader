//
//  ListApiCall.swift
//  Mugen Reader
//
//  Created by Carlos Mbendera on 26/06/2022.
//

import Foundation

func callMangaDexAPI(apiPassedURL: String) async -> [Manga]{
    
    var finalResponse = [Manga]()
    
    if let apiurl = URL(string: apiPassedURL)  {
     
    
        do{
            let (data, _) = try await URLSession.shared.data(from: apiurl)
          
            print(data)
            if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data){
                
                  finalResponse = decodedResponse.data
                
                print("Done Get Manga")
                
                
            }else{
                print("if let failed")
            }
            
        }
        catch{
            print("INVALID DATA DUDE, Emotional Damage")
        }
        
    }else{
        
        finalResponse = [dummymanga]
        
 }
    
return finalResponse
    
}
 
