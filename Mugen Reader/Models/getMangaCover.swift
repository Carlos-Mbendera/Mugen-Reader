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
            
                   finallink = "https://uploads.mangadex.org/covers/\(item.id)/\(coverName)"
                        
               
       
           //     let _ =  print("\(item.attributes.title) https://uploads.mangadex.org/covers/\(item.id)/\(coverName)")
             
            }
        }
    }
    
    return AsyncImage(url: URL(string: finallink) )
    {phase in
        
        switch phase{
       
        case.success(let image):
            image.resizable()
        case.failure(_):
            AsyncImage(url: URL(string: finallink) ) {image in
            
            image.resizable()
                
        } placeholder: {
            ProgressView()
        }
        case .empty:
            AsyncImage(url: URL(string: finallink) ) {image in
            
            image.resizable()
                
        } placeholder: {
            ProgressView()
        }
        @unknown default:
            AsyncImage(url: URL(string: finallink) ) {image in
            
            image.resizable()
                
        } placeholder: {
            ProgressView()
        }
        }
    }
}




