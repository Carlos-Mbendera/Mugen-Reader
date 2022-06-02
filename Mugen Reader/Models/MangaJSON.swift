//
//  MangaJSON.swift
//  Mugen Reader
//
//  Created by Carlos Mbendera on 02/06/2022.
//

import Foundation

struct Response: Codable{
    
  var  result:    String
  var  response:  String
  var  data: [Manga]
    
}

struct ChapterResponse: Codable{
    
  var  result:    String
  var  response:  String
  var  data: [ChapterList]
    
}


struct Manga: Codable{
    var id: String
    var type: String
    var attributes: MangaAttributes
    var relationships: [MangaRelations]
}

struct ChapterList: Codable{
    var id: String
    var type: String
    var attributes: ChapterAttributes
}


struct ChapterAttributes: Codable{
    
   var chapter    : String
   var title      : String
  // var pages      : String
//   var publishAt  : Date
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
    var fileName: String
}

