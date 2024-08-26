//
//  NewsFromAPIView.swift
//  DoggyMapAPI
//
//  Created by Дмитрiй Дѣренъ on 01.05.2024.
//

import SwiftUI

struct NewsFromAPIView: View {
    
    @State private var newsList: [DoggyMapNews] = []
    @State private var isLoading = false
    
    var body: some View {
        if isLoading {
            ProgressView("Loading...")
                .onAppear {
                    fetchNews()
                }
        } else {
            ScrollView {
                ForEach(newsList) { news in
                    Button(action: {
                        
                    }){
                    VStack {
                            AsyncImage(url: URL(string: news.newsArtwork)){ image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .clipShape(
                                        RoundedRectangle(cornerRadius: 25.0)
                                    )
                                    .frame(width: 300, height: 300)
                            } placeholder: {
                                RoundedRectangle(cornerRadius: 25.0)
                                    .fill(Color.gray)
                                    .frame(width: 300, height: 300)
                            }
                            Text("\(news.newsName)")
                                .font(.headline)
                                .foregroundStyle(.black)

                            Text(news.newsDescription)
                                .font(.subheadline)
                                .foregroundStyle(.black)
                        }
                    .padding()
                    }
                    
                }
            }
            .frame(maxWidth: .infinity)
            .onAppear {
                if newsList.isEmpty {
                    fetchNews()
                }
            }
        }
    }
    
    func fetchNews() {
        isLoading = true
        Task {
            do {
                let fetchedNews = try await getNews()
                newsList = fetchedNews
            } catch {
                print("Failed to fetch news: \(error)")
            }
            isLoading = false
        }
    }
    
    func getNews() async throws -> [DoggyMapNews] {
        let endpoint = "https://amiable-reprieve-production.up.railway.app/api/news"
        
        guard let url = URL(string: endpoint) else {
            throw DoggyMapErrors.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw DoggyMapErrors.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode([DoggyMapNews].self, from: data)
        } catch {
            throw DoggyMapErrors.invalidData
        }
    }
}

//------------------- Model ------------------------

struct DoggyMapNews: Codable, Identifiable {
    let id = UUID()
    let newsArtwork: String
    let newsName: String
    let newsDescription: String
    let newsBannerTitle: String
    let newsText: String
    let newsLink: String
}

//--------------------- Errors ----------------------

//enum DoggyMapErrors: Error {
//    case invalidURL
//    case invalidResponse
//    case invalidData
//}


//#Preview {
//    NewsFromAPIView()
//}
