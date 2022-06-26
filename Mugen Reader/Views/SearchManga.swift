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
        
        let apiString = "https://api.mangadex.org/manga?title=\(newQueryText!)&includedTagsMode=AND&excludedTagsMode=OR&availableTranslatedLanguage%5B%5D=en&contentRating%5B%5D=safe&order%5BlatestUploadedChapter%5D=desc&includes%5B%5D=manga&includes%5B%5D=cover_art"
        
        
      //This call works fine at the costs of any and all lewd to suggustive manga
        //Can put them back if you remove descriptions from the Codable 
        
        print(apiString)
        
        
        guard let apiurl = URL(string: apiString) else {
          
            print("Failure and Emotional Damage")
            return
        }

        
            do{
                let (data, _) = try await URLSession.shared.data(from: apiurl)
              
                print(data)
                if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data){
                    print(decodedResponse)
                    
                     mangaSearchResults = decodedResponse.data
                    
                    print("Done Get Searched For Manga")
                    
                }else{
                    print("if let failed")
                }
                
            }
            catch{
                print("INVALID DATA DUDE, Emotional Damage")
            }
        }
        
    
    
//Search Manga Main Struct ends here
    
}



struct SearchManga_Previews: PreviewProvider {
    static var previews: some View {
        SearchManga()
    }
}
