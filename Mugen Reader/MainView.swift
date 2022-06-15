//
//  ContentView.swift
//  Mugen Reader
//
//  Created by Carlos Mbendera on 02/06/2022.
//

import SwiftUI


struct MainView: View {
    
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
            .navigationTitle("Home")
            .task{
                await getManga()
            }
            
        }.navigationViewStyle(.stack)
        
      
        
        
    }
    
    
    func getManga() async{
        
    //    print("Get Manga Started")
        
        
        let mangaCallURL: String = "https://api.mangadex.org/manga?limit=5&includedTagsMode=AND&excludedTagsMode=OR&availableTranslatedLanguage%5B%5D=en&contentRating%5B%5D=safe&contentRating%5B%5D=suggestive&contentRating%5B%5D=erotica&contentRating%5B%5D=pornographic&order%5BlatestUploadedChapter%5D=desc&includes%5B%5D=cover_art"
        
      
        
       
        guard let apiurl = URL(string: mangaCallURL) else {
          
            print("Failure and Emotional Damage")
            return
        }

        
            do{
                let (data, _) = try await URLSession.shared.data(from: apiurl)
              
                print(data)
                if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data){
                    
                    mangaResults = decodedResponse.data
                    print("Done Get Manga")
                    
                    for a in mangaResults{
                        print("id is \(a.id)")
                    }
                    
                }else{
                    print("if let failed")
                }
                
                
                
            }
            catch{
                print("INVALID DATA DUDE, Emotional Damage")
            }
        
     //   print("Get Manga Finished")
        }
    
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}


