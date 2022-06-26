//
//  ListMangaItem.swift
//  Mugen Reader
//
//  Created by Carlos Mbendera on 25/06/2022.
//

import SwiftUI



struct ListViewMangaItem: View{
    
     var item : Manga
    
    var body: some View{
        HStack {
            
          
                
       returnCover(item: item)
                .frame(width: 75, height: 112.5)
                .cornerRadius(10)
             
            
            VStack(alignment: .leading){
                if let title = item.attributes.title.en{
                
                Text(title)
                    .fontWeight(.semibold)
                    .lineLimit(2)
                    .padding(.bottom, 5)
                }else {
                    Text("Title Comes Here UwU")
                        .fontWeight(.semibold)
                        .lineLimit(2)
                        .padding(.bottom, 5)
                }
                
                
                
                
                    Text("Status: \(item.attributes.status)").padding(.leading, 5)
                
                if let mangaYear = item.attributes.year{
                    Text("Year: \(String(mangaYear))").padding(.leading, 5)
                    //Not all have year
                }else{
                    Text("Year: N/A").padding(.leading, 5)
                }
        
            }
        }
    }
}
