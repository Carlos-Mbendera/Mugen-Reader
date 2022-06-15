//
//  getMangaCover.swift
//  Mugen Reader
//
//  Created by Carlos Mbendera on 02/06/2022.
//



// TODO: FIX Async Cases for actual user caused fail cases and not API Failure



import SwiftUI

func returnCover(item: Manga) -> some View{
    
    var finallink = ""
   
    for relation in item.relationships{
        
        if relation.type == "cover_art"{
            
            if  let coverName = relation.attributes?.fileName{
            
                   finallink = "https://uploads.mangadex.org/covers/\(item.id)/\(coverName).256.jpg"
       
           //    let _ =  print("\(item.attributes.title) https://uploads.mangadex.org/covers/\(item.id)/\(coverName)")
             
            }
        }
    }
    
    // REASON FOR ASYNC TO HAPPEN 2 TIMES IS CAUSE SOMETIMES IT FAILS FIRST TRY BUT ALMOST ALWAYS SECOND
    
    
    
    return AsyncImage(url: URL(string: finallink) ) {phase in
        
        if let image = phase.image {
            image.resizable()
        
        } else if phase.error != nil {
         
            ////////////////////  TRY AGAIN FOR ERROR STARTS HERE
            
            AsyncImage(url: URL(string: finallink) ) {phase in
                
                if let image = phase.image {
                    image.resizable()
                
                } else if phase.error != nil {
                    Text("Unable To Load Image \n :(")
                } else {
                AsyncImage(url: URL(string: finallink) ) {image in
                image.resizable()
            } placeholder: {
                ProgressView()
                    }
                }
            }
        
            ////////////////////  TRY AGAIN FOR ERROR ENDS HERE
        
        }
        
        
        else {
        AsyncImage(url: URL(string: finallink) ) {image in
        
        image.resizable()
            
    } placeholder: {
        ProgressView()
            }
        }
    }
    
}




