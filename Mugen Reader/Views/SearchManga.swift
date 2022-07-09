//
//  SearchManga.swift
//  Mugen Reader
//
//  Created by Carlos Mbendera on 24/06/2022.
//

import SwiftUI



struct SearchManga: View {
    
    
    @State private var mangaSearchResults = [Manga]()
    
    @State private var searchText: String = ""
    
    var body: some View {
        NavigationView{
            
        VStack{
           
            ZStack {
                   Rectangle()
                       .foregroundColor(Color("LightGray"))
                   HStack {
                       Image(systemName: "magnifyingglass")
                       TextField("What's your fancy?", text: $searchText)
                           .onSubmit {
                               Task{
                            await searchForManga(queryText: searchText)
                               }
                       }
                   }
                   .foregroundColor(.gray)
                   .padding(.leading, 13)
               }
                   .frame(height: 40)
                   .cornerRadius(13)
                   .padding()
           
            
      
          
                
                List(mangaSearchResults,id: \.id){
                    item in
                           
                    NavigationLink(destination: MangaInfo(mangaSelected: item), label: {
                        
                         ListViewMangaItem(item: item)
                        
                    })
                    
          
                }
                .navigationTitle("Search")
            }.navigationViewStyle(.stack)
            
            
            
            
        }
        
        
        
    }
    
    func searchForManga(queryText: String) async{
        
        let newQueryText =  queryText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        let apiString = "https://api.mangadex.org/manga?title=\(newQueryText!)&includedTagsMode=AND&excludedTagsMode=OR&availableTranslatedLanguage%5B%5D=en&contentRating%5B%5D=safe&contentRating%5B%5D=suggestive&contentRating%5B%5D=erotica&order%5BlatestUploadedChapter%5D=desc&includes%5B%5D=manga&includes%5B%5D=cover_art"
        
        
        
        print(apiString)
        
        
        mangaSearchResults = await callMangaDexAPI(apiPassedURL: apiString)
        
        }
        
    
    
//Search Manga Main Struct ends here
    
}



struct SearchManga_Previews: PreviewProvider {
    static var previews: some View {
        SearchManga()
    }
}
