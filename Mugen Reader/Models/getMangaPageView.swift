//
//  getMangaPageView.swift
//  Mugen Reader
//
//  Created by Carlos Mbendera on 16/06/2022.
//

import SwiftUI


func returnMangaPage(pageLink: String) -> some View{
    

    
    // REASON FOR ASYNC TO HAPPEN 2 TIMES IS CAUSE SOMETIMES IT FAILS FIRST TRY BUT ALMOST ALWAYS SECOND
    
    return AsyncImage(url: URL(string: pageLink) ) {phase in
        
        if let image = phase.image {
            image.resizable()
            
        
        } else if phase.error != nil {
         
            ////////////////////  TRY AGAIN FOR ERROR STARTS HERE
            
            AsyncImage(url: URL(string: pageLink) ) {phase in
                
                if let image = phase.image {
                    image.resizable()
                
                } else if phase.error != nil {
                    Text("Unable To Load Image \n :(")
                } else {
                AsyncImage(url: URL(string: pageLink) ) {image in
                image.resizable()
            } placeholder: {
                ProgressView()
                    }
                }
            }
        
            ////////////////////  TRY AGAIN FOR ERROR ENDS HERE
        
        }
        
        
        else {
        AsyncImage(url: URL(string: pageLink) ) {image in
        
        image.resizable()
            
    } placeholder: {
        ProgressView()
            }
        }
    }
    
}


