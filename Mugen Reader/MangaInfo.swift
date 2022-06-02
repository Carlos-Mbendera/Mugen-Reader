//
//  MangaInfo.swift
//  Mugen Reader
//
//  Created by Carlos Mbendera on 02/06/2022.
//

import SwiftUI

struct MangaInfo: View {
  
    @State private var chapteResults = [ChapterList]()
   
    var mangaSelected: Manga
    
    var body: some View {
        
        VStack {
            HStack{
                
                returnBiggerCover(item: mangaSelected)
                
                
                Text(mangaSelected.attributes.title.en).font(.title).padding()
            }
            
            Text(mangaSelected.attributes.description.en)
                .font(.body)
                .lineLimit(4)
                .padding()
            
            
            List(chapteResults, id: \.id) { item in
                Text("Chapter \(item.attributes.chapter)")
                Text(item.attributes.title).font(.caption).padding(.leading, 10)
                
            }.task {
                await getChapterList()
            }
            .navigationTitle("Chapters")
            
            
        }
        
    }
    
    
    
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







var dummyAttrubuts: MangaAttributes = MangaAttributes(title: dummyLang, description: dummyLang, year: 2000, status: "Tired")
var dummyLang: MangaLang = MangaLang(en: "en")

var dummyRelation = [MangaRelations]()


var dummymanga: Manga = Manga(id: "Blah", type: "manga", attributes: dummyAttrubuts, relationships: dummyRelation)


struct MangaInfo_Previews: PreviewProvider {
    static var previews: some View {
        MangaInfo(mangaSelected: dummymanga)
    }
}
