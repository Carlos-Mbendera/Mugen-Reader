//
//  ContentView.swift
//  Mugen Reader
//
//  Created by Carlos Mbendera on 02/06/2022.
//

import SwiftUI


struct MainView: View {
    
    @State private var seasonalListIDs = [ListMangaIDs]()
    
    @State private var mangaResults = [Manga]()
    
    
    var body: some View {
        
        NavigationView{
            
            List(mangaResults,id: \.id){
                item in
                       
                NavigationLink(destination: MangaInfo(mangaSelected: item), label: {
                    HStack {
                        
                      
                            
                   returnCover(item: item)
                            .frame(width: 75, height: 112.5)
                            .cornerRadius(10)
                         
                        
                        VStack(alignment: .leading){
                            Text(item.attributes.title.en)
                                .fontWeight(.semibold)
                                .lineLimit(2)
                                .padding(.bottom, 5)
                                
                            
                            
                                Text("Status: \(item.attributes.status)").padding(.leading, 5)
                            
                            if let mangaYear = item.attributes.year{
                                Text("Year: \(String(mangaYear))").padding(.leading, 5)
                                //Not all have year
                            }else{
                                Text("Year: N/A").padding(.leading, 5)
                            }
                    
                        }
                    }
                })
                
      
            }
            .navigationTitle("Seasonal")
            .task{
                await processSeasonalList()
            }
            
        }.navigationViewStyle(.stack)
        
      
        
        
    }
    
    func processSeasonalList() async{
        await getSeasonalMangaList()
        await getSeasonalMangaDetails()
    }
    
    
    
  func  getSeasonalMangaList() async{
        
      let seasonListId: String = "1f43956d-9fe6-478e-9805-aa75ec0ac45e"
      let listURL: String = "https://api.mangadex.org/list/\(seasonListId)"
      
      guard let apiurl = URL(string: listURL) else {
        
          print("Failure and Emotional Damage")
          return
      }
      
          do{
              let (data, _) = try await URLSession.shared.data(from: apiurl)
            
              print(data)
              if let decodedResponse = try? JSONDecoder().decode(SeasonalResponse.self, from: data){
                  
                  seasonalListIDs = decodedResponse.data.relationships
                  print("Done Get Seasonal")
                  
                  
              }else{
                  print("if let failed")
              }
              
              
              
          }
          catch{
              print("INVALID DATA DUDE, Emotional Damage")
          }
      
    }
    
    
    
    
    
    func getSeasonalMangaDetails() async{
        print("Started get details")
        var idsListString: String = ""
        
        for a in seasonalListIDs{
            idsListString = "\(idsListString)&ids%5B%5D=\(a.id)"
        }
        
        
        
        
        var detailsAPICall: String = "https://api.mangadex.org/manga?includedTagsMode=AND&excludedTagsMode=OR&availableTranslatedLanguage%5B%5D=en\(idsListString)&contentRating%5B%5D=safe&contentRating%5B%5D=suggestive&contentRating%5B%5D=erotica&order%5BlatestUploadedChapter%5D=desc&includes%5B%5D=manga&includes%5B%5D=cover_art"
        
  
        
        guard let apiurl = URL(string: detailsAPICall) else {
          
            print("Failure and Emotional Damage")
            return
        }

        
            do{
                let (data, _) = try await URLSession.shared.data(from: apiurl)
              
                print(data)
                if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data){
                    
                    mangaResults = decodedResponse.data
                    print("Done Get Seasonal Manga")
                    
                    
                }else{
                    print("if let failed")
                }
                
            }
            catch{
                print("INVALID DATA DUDE, Emotional Damage")
            }
        
    }
    

    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}


