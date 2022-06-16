//
//  ReadChapter.swift
//  Mugen Reader
//
//  Created by Carlos Mbendera on 02/06/2022.
//

import SwiftUI





struct ReadChapter: View {
    
    var chapterID: String
    
    
    @State private var baseUrl = String()
    @State private var chapterHash = String()
    @State private var chapterPages = [String]()
    
    var body: some View {
        
      
        
        List(chapterPages, id: \.self){ pageURL in
            
            let urlFULLLink = ("\(baseUrl)/data-saver/\(chapterHash)/\(pageURL)")
            
            
            returnMangaPage(pageLink: urlFULLLink)
                    .frame(width: 331.5, height: 512.5)
            
            let _ = print(urlFULLLink)
       
        
            //LIST ENDS HERE, NEXT Line
        }.task {
            await getReadChapterURLSList()
        }
       
        
        
        
        
        
        
        //MARK: - Below code preloads all pages instead lazy loading. It works but is more prone to download errors and I haven't fixed returnMangaPage
        
     /*  ScrollView{
        VStack {
            ForEach(chapterPages, id: \.self) { pageURL in
                
                let urlFULLLink = ("\(baseUrl)/data-saver/\(chapterHash)/\(pageURL)")
                
                returnMangaPage(pageLink: urlFULLLink)
                        .frame(width: 331.5, height: 512.5)
                        
                
            }
        }
            .task {
                await getReadChapterURLSList()
            }
        }
        */
    }
    
  
    
    
    func getReadChapterURLSList() async{
        
        print("Started getting pages")
        
        let getReadChaptersURL = ("https://api.mangadex.org/at-home/server/\(chapterID)")
        
        guard let callURL = URL(string: getReadChaptersURL) else{
            
            print("We had an error with the URL, rare, but it happens")
            return
        }
        
        
        
        do{
            let (data,_) = await try URLSession.shared.data(from: callURL)
          
            if let decodedResponse = try? JSONDecoder().decode(ReadChapterResponse.self, from: data){
                
                baseUrl = decodedResponse.baseUrl
                chapterPages = decodedResponse.chapter.dataSaver
                chapterHash = decodedResponse.chapter.hash
                
            }else{
                print("Read Chapter if let failed")
            }
            
            
            
        }catch{
            print("OMG, the api call failed. BIG SAD")
        }
        
    }
    
    
    
}










var dummyID = ("this is a dummy id :(")

struct ReadChapter_Previews: PreviewProvider {
    static var previews: some View {
        ReadChapter(chapterID: dummyID)
    }
}
