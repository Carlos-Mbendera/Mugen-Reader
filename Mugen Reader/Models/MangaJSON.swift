//
//  MangaJSON.swift
//  Mugen Reader
//
//  Created by Carlos Mbendera on 02/06/2022.
//

import Foundation


struct SeasonalResponse: Codable{
    var  result:    String
    var  response:  String
    var  data: CustomList
}

struct CustomList: Codable{
    var id: String
    var type: String
    var relationships: [ListMangaIDs]
    
}

struct ListMangaIDs:Codable{
    var id: String
}




struct FeedResponse: Codable{
    var  result:    String
    var  response:  String
    var  data: [FeedChapters]
}

struct FeedChapters: Codable{
    var id: String
    var attributes: ChapterDetails
}

struct ChapterDetails: Codable{
    var volume   :    String?
    var chapter  :    String?
    var title    :    String?
}






struct Response: Codable{
    
  var  result:    String
  var  response:  String
  var  data: [Manga]
    
}


struct Manga: Codable{
    var id: String
    var type: String
    var attributes: MangaAttributes
    var relationships: [MangaRelations]
}


struct MangaAttributes: Codable{
    var title: MangaLang
    var description: MangaLang
   // var lastChapter: String
    var year: Int? //Not all Manga on Manga Dex have Year Released, Causes errors if assumed. Same applies to above ones. Just rather not force them into app
    var status: String
}

struct MangaLang: Codable   {
    var en: String
}


struct MangaRelations: Codable{
    var id: String
    var type: String
    var attributes: MangaRelationAttributes?
}

struct MangaRelationAttributes: Codable{
    var fileName: String?
}

