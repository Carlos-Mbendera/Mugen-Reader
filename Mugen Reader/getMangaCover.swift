//
//  getMangaCover.swift
//  Mugen Reader
//
//  Created by Carlos Mbendera on 02/06/2022.
//

import SwiftUI

func returnCover(item: Manga) -> some View{
    
    var finallink = ""
   
    for relation in item.relationships{
        
        if relation.type == "cover_art"{
            
            if  let coverName = relation.attributes?.fileName{
            
                   finallink = "https://uploads.mangadex.org/covers/\(item.id)/\(coverName)"
                        
               
       
                let _ =  print("\(item.attributes.title) https://uploads.mangadex.org/covers/\(item.id)/\(coverName)")
             
            }
        }
    }
    
    return AsyncImage(url: URL(string: finallink) ){ image in
        
        image.resizable()
            
    } placeholder: {
        ProgressView()
    }
    .frame(width: 75, height: 112.5)
    .cornerRadius(10)

}




func returnBiggerCover(item: Manga) -> some View{
    
    var finallink = ""
   
    for relation in item.relationships{
        
        if relation.type == "cover_art"{
            
            if  let coverName = relation.attributes?.fileName{
            
                   finallink = "https://uploads.mangadex.org/covers/\(item.id)/\(coverName)"
                        
               
       
                let _ =  print("\(item.attributes.title) https://uploads.mangadex.org/covers/\(item.id)/\(coverName)")
             
            }
        }
    }
    
    return AsyncImage(url: URL(string: finallink) ){ image in
        
        image.resizable()
            
    } placeholder: {
        ProgressView()
    }
    .frame(width: 112.5, height: 168.75)
    .cornerRadius(10)

}
