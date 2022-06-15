//
//  MangaInfo.swift
//  Mugen Reader
//
//  Created by Carlos Mbendera on 02/06/2022.
//

import SwiftUI

struct MangaInfo: View {
  
  //  @State private var chapteResults = [ChapterList]()
    @State private var volumeResults = [Volume]()
    @State private var chapteResults = [ListChapterAggregated]()
    
    
   
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
            
            
            List(volumeResults, id: \.volume) { item in
                  Text("Volume \(item.volume)")
               
            }.task {
                await getListOfChapterAggregated()
            }
            .navigationTitle("Chapters")
            
            
        }
        
    }
    
    
    
    
    
    func getListOfChapterAggregated() async{
        
        print("Get Aggregated List Started")
        
        let mangaID : String = mangaSelected.id
       
        
        let rawURL: String = "https://api.mangadex.org/manga/\(mangaID)/aggregate?translatedLanguage%5B%5D=en"
        
        
        guard let apiurl = URL(string: rawURL) else {
          
            print("Failure and Emotional Damage")
            return
        }

        
            do{
                let (data, _) = try await URLSession.shared.data(from: apiurl)
              
                print(data)
                if let decodedResponse = try? JSONDecoder().decode(ChapterAggregateRoot.self, from: data){
                    
                    volumeResults = Array(decodedResponse.volumes.values)
                    
                    print("Done Get VOlUMES broski")
                    
                   for a in volumeResults{
                        print("Volume is \(a.volume)")
                    }
                    
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
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    /*
    
    
    func getChapterList() async{
        
        print("Get Chapter List Started")
        
        let mangaID : String = mangaSelected.id
        var chapterLimit: Int = 99
        
        let rawURL: String = "https://api.mangadex.org/chapter?limit=\(chapterLimit)&manga=\(mangaID)&contentRating%5B%5D=safe&contentRating%5B%5D=suggestive&contentRating%5B%5D=erotica&contentRating%5B%5D=pornographic&includeFutureUpdates=1&order%5BcreatedAt%5D=asc&order%5BupdatedAt%5D=asc&order%5BpublishAt%5D=asc&order%5BreadableAt%5D=asc&order%5Bvolume%5D=asc&order%5Bchapter%5D=asc"
        
        
        guard let apiurl = URL(string: rawURL) else {
          
            print("Failure and Emotional Damage")
            return
        }

        
            do{
                let (data, _) = try await URLSession.shared.data(from: apiurl)
              
                print(data)
                if let decodedResponse = try? JSONDecoder().decode(ChapterResponse.self, from: data){
                    
                    chapteResults = decodedResponse.data
                    print("Done Get Chapters broski")
                    
                    for a in chapteResults{
                        print("id is \(a.id)")
                    }
                    
                }else{
                    print("if let failed")
                }
                
                
                
            }
            catch{
                print("INVALID DATA DUDE, Emotional Damage")
            }
        
        print("Get chapter Finished")
        }
    
}


*/




var dummyAttrubuts: MangaAttributes = MangaAttributes(title: dummyLang, description: dummyLang, year: 2000, status: "Tired")
var dummyLang: MangaLang = MangaLang(en: "en")

var dummyRelation = [MangaRelations]()


var dummymanga: Manga = Manga(id: "Blah", type: "manga", attributes: dummyAttrubuts, relationships: dummyRelation)


struct MangaInfo_Previews: PreviewProvider {
    static var previews: some View {
        MangaInfo(mangaSelected: dummymanga)
    }
}
