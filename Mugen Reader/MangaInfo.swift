//
//  MangaInfo.swift
//  Mugen Reader
//
//  Created by Carlos Mbendera on 02/06/2022.
//

import SwiftUI

struct MangaInfo: View {
  
  //  @State private var chapteResults = [ChapterList]()
   
    @State private var chapterResults = [FeedChapters]()
    
    
   
    var mangaSelected: Manga
    
    var body: some View {
        
        VStack {
            HStack{
                
                returnCover(item: mangaSelected)
                    .frame(width: 112.5, height: 168.75)
                    .cornerRadius(10)
                
                
                Text(mangaSelected.attributes.title.en).font(.title).padding()
            }
            
            Text(mangaSelected.attributes.description.en)
                .font(.body)
                .lineLimit(4)
                .padding()
            
            
            List(chapterResults, id: \.id) { item in
                
                
                NavigationLink(destination: ReadChapter(chapterID: item.id), label: {
                    
                    if let chapterOptional = item.attributes.chapter{
                        if let titleoptional = item.attributes.title{
                        
                        Text("Chapter \(chapterOptional)")
                        if (titleoptional.isEmpty){
                            //DO Nothing, There's proably a better way to write this. Just note that Manga Dex API sometimes returns whitespace which passes unwrap and messes up ui
                            //Hence me doing this
                        }else{
                            Text(titleoptional).padding(.leading, 10)
                        }
                      
                     
                    }else{
                        
                        Text("Chapter \(chapterOptional)")
                        }
                    }
                    
                    //Nav Link Ends Here next line
                })
                
               //List ends here next line
            }
            .task {
                await getMangaFeed()
            }
            
            
            
        }
        
    }
    
    
    
    
    
    func getMangaFeed() async{
        
        print("Get Aggregated List Started")
        
        let mangaID : String = mangaSelected.id
       
        let rawURL: String = "https://api.mangadex.org/manga/\(mangaID)/feed?limit=100&translatedLanguage%5B%5D=en&contentRating%5B%5D=safe&contentRating%5B%5D=suggestive&contentRating%5B%5D=erotica&contentRating%5B%5D=pornographic&includeFutureUpdates=1&order%5BcreatedAt%5D=asc&order%5BupdatedAt%5D=asc&order%5BpublishAt%5D=asc&order%5BreadableAt%5D=asc&order%5Bvolume%5D=asc&order%5Bchapter%5D=asc"
        
        print("API CALL IS \(rawURL)")
   
        
        guard let apiurl = URL(string: rawURL) else {
          
            print("Failure and Emotional Damage")
            return
        }

        
            do{
                let (data, _) = try await URLSession.shared.data(from: apiurl)
              
                print(data)
                if let decodedResponse = try? JSONDecoder().decode(FeedResponse.self, from: data){
                    
                    chapterResults = decodedResponse.data
                    
                    print("Done Get VOlUMES broski")
                    
                   
                    
                }else{
                    print("if let failed")
                }
                
                
                
            }
            catch{
                print("INVALID DATA DUDE, Emotional Damage")
            }
        
        print("Get VOLUMES Finished")
        }
    
}
    
    
    
    
    
    





var dummyAttrubuts: MangaAttributes = MangaAttributes(title: dummyLang, description: dummyLang, year: 2000, status: "Tired")
var dummyLang: MangaLang = MangaLang(en: "en")

var dummyRelation = [MangaRelations]()


var dummymanga: Manga = Manga(id: "Blah", type: "manga", attributes: dummyAttrubuts, relationships: dummyRelation)


struct MangaInfo_Previews: PreviewProvider {
    static var previews: some View {
        MangaInfo(mangaSelected: dummymanga)
    }
}
