//
//  NewsModel.swift
//  News
//
//  Created by Ceren Güneş on 18.09.2023.
//

import Foundation

struct NewsModel: Codable {
    let status: String?
    let articles: [News]
}

struct News: Codable {
    let source: Source?
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
}

struct Source: Codable {
    let id: String?
    let name: String?
}
