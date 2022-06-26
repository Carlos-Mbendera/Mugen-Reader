//
//  MangaJSON.swift
//  Mugen Reader
//
//  Created by Carlos Mbendera on 02/06/2022.
//

import Foundation


struct ReadChapterResponse: Codable{
   var result:  String
   var baseUrl: String
   var chapter: ReadChapterPages
}

    struct ReadChapterPages: Codable{
        var  hash: String
        var  data: [String]
        var  dataSaver: [String]
    }





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
    var en: String?
}


struct MangaRelations: Codable{
    var id: String
    var type: String
    var attributes: MangaRelationAttributes?
}

struct MangaRelationAttributes: Codable{
    var fileName: String?
}













// FOR DEBUGIN PURPOSES



struct DBResponse: Codable{
    
  var  result:    String
  var  response:  String
  var  data: [DBManga]
    
}


struct DBManga: Codable{
    var id: String
    var type: String
    var attributes: DBMangaAttributes
    var relationships: [DBMangaRelations]
}


struct DBMangaAttributes: Codable{
    var title: DBMangaLang
    var description: DBMangaLang
   // var lastChapter: String
   var year: Int? //Not all Manga on Manga Dex have Year Released, Causes errors if assumed. Same applies to above ones. Just rather not force them into app
   var status: String
}

struct DBMangaLang: Codable   {
    var en: String?
}


struct DBMangaRelations: Codable{
    var id: String
    var type: String
    var attributes: DBMangaRelationAttributes?
}

struct DBMangaRelationAttributes: Codable{
    var fileName: String?
}


