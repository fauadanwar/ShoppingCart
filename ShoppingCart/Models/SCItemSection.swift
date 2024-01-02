//
//  SCItemSection.swift
//  ShoppingCart
//
//  Created by Fauad Anwar on 17/02/22.
//

import Foundation

struct SCItemSection: Decodable, Hashable
{
    let id = UUID()
    let title: String = "All"
    var items: [SCItem]
    
    enum CodingKeys: String, CodingKey {
        case items = "results"
    }
    
    func hash(into hasher: inout Hasher) {
      hasher.combine(id)
    }
    
    static func == (lhs: SCItemSection, rhs: SCItemSection) -> Bool {
      lhs.id == rhs.id
    }
}

extension SCItemSection
{
    static func getSampleData() -> SCItemSection
    {
        var items = SCItemSection(items: [SCItem]())
        do {
            let jsonDict = ["results" : [
                [
                    "created_at":"2019-02-24 04:04:17.566515",
                    "price":"AED 5",
                    "name":"Notebook",
                    "uid":"4878bf592579410fba52941d00b62f94",
                    "image_ids":[
                        "9355183956e3445e89735d877b798689"
                    ],
                    "image_urls":[
                        "https://demo-app-photos-45687895456123.s3.amazonaws.com/9355183956e3445e89735d877b798689?AWSAccessKeyId=ASIASV3YI6A4QFBHOVW5&Signature=X6Ga2xRfkmKPVk0iQD1CrXtJTNc%3D&x-amz-security-token=IQoJb3JpZ2luX2VjEF4aCXVzLWVhc3QtMSJIMEYCIQC934OR%2F72vgjI0D%2FLaM8dIdEF%2BQ6iev7bbH9RSGhtkTAIhALAerzLLOkhVwgsLkYSkSfAYlpFJ1LSfjGuS3ilwbGE%2BKpQCCBcQAxoMMTg0Mzk4OTY2ODQxIgzdg1kU5zG7xip2TTwq8QE%2F0YBDIfDlPSS8hRT2fuMumTgnnOVQngoigyNoImRhhDnnOUiozK87BoCRsrHyfyVBxFpXy1bUReBL%2Fe7CeHBW2Y8xCrjF9AUM%2BBx8fEFhUvRQKUWe4D6xPklbq58qlWJ0nz5e8WtW9H3dHziVV3%2FnHDU26RHazZcAzvnsWaQLSNJ4eoyrM%2BobXOz8mwBJnh5eRd0ebZuWgTOiD3Il3qFgLjGfVHu4Zxyb%2BROmQkUx4I9cpstR%2FdfXu3U2n%2Fw4zYSFC0ggZ8jPOrGp%2FfzFl5nESw1VyROk72zdpdbEesUngeYQuCLzNE4vq5vti6M7VrtxMM2%2FtIwGOpkBnbxodqA1iGVxWTBJAf7QJX5FKPpKcms9fqjeaStL9q5eRB9KCDyw0nkJc3HglvQX9nROkqjhJXIduoekCfhnoSzW8uM0h0iup%2FLOwrHK9OaAOLsfqckK%2B6%2Fk1%2FtHsK%2BeieKbKB0AbMmqc1mhV5DoDYMfaTL0qFAn%2Bdd3hszF6LYzyLTNJE3LeaEr0%2BI1zCcNwVHV9PeeXFSD&Expires=1636642581"
                    ],
                    "image_urls_thumbnails":[
                        "https://demo-app-photos-45687895456123.s3.amazonaws.com/9355183956e3445e89735d877b798689-thumbnail?AWSAccessKeyId=ASIASV3YI6A4QFBHOVW5&Signature=A79DacgpHxwkOaDK8ed%2FXr9jRBw%3D&x-amz-security-token=IQoJb3JpZ2luX2VjEF4aCXVzLWVhc3QtMSJIMEYCIQC934OR%2F72vgjI0D%2FLaM8dIdEF%2BQ6iev7bbH9RSGhtkTAIhALAerzLLOkhVwgsLkYSkSfAYlpFJ1LSfjGuS3ilwbGE%2BKpQCCBcQAxoMMTg0Mzk4OTY2ODQxIgzdg1kU5zG7xip2TTwq8QE%2F0YBDIfDlPSS8hRT2fuMumTgnnOVQngoigyNoImRhhDnnOUiozK87BoCRsrHyfyVBxFpXy1bUReBL%2Fe7CeHBW2Y8xCrjF9AUM%2BBx8fEFhUvRQKUWe4D6xPklbq58qlWJ0nz5e8WtW9H3dHziVV3%2FnHDU26RHazZcAzvnsWaQLSNJ4eoyrM%2BobXOz8mwBJnh5eRd0ebZuWgTOiD3Il3qFgLjGfVHu4Zxyb%2BROmQkUx4I9cpstR%2FdfXu3U2n%2Fw4zYSFC0ggZ8jPOrGp%2FfzFl5nESw1VyROk72zdpdbEesUngeYQuCLzNE4vq5vti6M7VrtxMM2%2FtIwGOpkBnbxodqA1iGVxWTBJAf7QJX5FKPpKcms9fqjeaStL9q5eRB9KCDyw0nkJc3HglvQX9nROkqjhJXIduoekCfhnoSzW8uM0h0iup%2FLOwrHK9OaAOLsfqckK%2B6%2Fk1%2FtHsK%2BeieKbKB0AbMmqc1mhV5DoDYMfaTL0qFAn%2Bdd3hszF6LYzyLTNJE3LeaEr0%2BI1zCcNwVHV9PeeXFSD&Expires=1636642581"
                    ]
                ],
                [
                    "created_at":"2019-02-23 11:11:01.282260",
                    "price":"AED 45",
                    "name":"mouse, computer mouse",
                    "uid":"0fa43a3cb366475fb5d60fe1a208fe95",
                    "image_ids":[
                        "c96e82f913034c27b291a1722613f162"
                    ],
                    "image_urls":[
                        "https://demo-app-photos-45687895456123.s3.amazonaws.com/c96e82f913034c27b291a1722613f162?AWSAccessKeyId=ASIASV3YI6A4QFBHOVW5&Signature=ljH2MzL%2FzYkIN3FEP4C66IdmIGM%3D&x-amz-security-token=IQoJb3JpZ2luX2VjEF4aCXVzLWVhc3QtMSJIMEYCIQC934OR%2F72vgjI0D%2FLaM8dIdEF%2BQ6iev7bbH9RSGhtkTAIhALAerzLLOkhVwgsLkYSkSfAYlpFJ1LSfjGuS3ilwbGE%2BKpQCCBcQAxoMMTg0Mzk4OTY2ODQxIgzdg1kU5zG7xip2TTwq8QE%2F0YBDIfDlPSS8hRT2fuMumTgnnOVQngoigyNoImRhhDnnOUiozK87BoCRsrHyfyVBxFpXy1bUReBL%2Fe7CeHBW2Y8xCrjF9AUM%2BBx8fEFhUvRQKUWe4D6xPklbq58qlWJ0nz5e8WtW9H3dHziVV3%2FnHDU26RHazZcAzvnsWaQLSNJ4eoyrM%2BobXOz8mwBJnh5eRd0ebZuWgTOiD3Il3qFgLjGfVHu4Zxyb%2BROmQkUx4I9cpstR%2FdfXu3U2n%2Fw4zYSFC0ggZ8jPOrGp%2FfzFl5nESw1VyROk72zdpdbEesUngeYQuCLzNE4vq5vti6M7VrtxMM2%2FtIwGOpkBnbxodqA1iGVxWTBJAf7QJX5FKPpKcms9fqjeaStL9q5eRB9KCDyw0nkJc3HglvQX9nROkqjhJXIduoekCfhnoSzW8uM0h0iup%2FLOwrHK9OaAOLsfqckK%2B6%2Fk1%2FtHsK%2BeieKbKB0AbMmqc1mhV5DoDYMfaTL0qFAn%2Bdd3hszF6LYzyLTNJE3LeaEr0%2BI1zCcNwVHV9PeeXFSD&Expires=1636642585"
                    ],
                    "image_urls_thumbnails":[
                        "https://demo-app-photos-45687895456123.s3.amazonaws.com/c96e82f913034c27b291a1722613f162-thumbnail?AWSAccessKeyId=ASIASV3YI6A4QFBHOVW5&Signature=DZpHB1Ig%2BIfx7AqIv4IwnHkgEGU%3D&x-amz-security-token=IQoJb3JpZ2luX2VjEF4aCXVzLWVhc3QtMSJIMEYCIQC934OR%2F72vgjI0D%2FLaM8dIdEF%2BQ6iev7bbH9RSGhtkTAIhALAerzLLOkhVwgsLkYSkSfAYlpFJ1LSfjGuS3ilwbGE%2BKpQCCBcQAxoMMTg0Mzk4OTY2ODQxIgzdg1kU5zG7xip2TTwq8QE%2F0YBDIfDlPSS8hRT2fuMumTgnnOVQngoigyNoImRhhDnnOUiozK87BoCRsrHyfyVBxFpXy1bUReBL%2Fe7CeHBW2Y8xCrjF9AUM%2BBx8fEFhUvRQKUWe4D6xPklbq58qlWJ0nz5e8WtW9H3dHziVV3%2FnHDU26RHazZcAzvnsWaQLSNJ4eoyrM%2BobXOz8mwBJnh5eRd0ebZuWgTOiD3Il3qFgLjGfVHu4Zxyb%2BROmQkUx4I9cpstR%2FdfXu3U2n%2Fw4zYSFC0ggZ8jPOrGp%2FfzFl5nESw1VyROk72zdpdbEesUngeYQuCLzNE4vq5vti6M7VrtxMM2%2FtIwGOpkBnbxodqA1iGVxWTBJAf7QJX5FKPpKcms9fqjeaStL9q5eRB9KCDyw0nkJc3HglvQX9nROkqjhJXIduoekCfhnoSzW8uM0h0iup%2FLOwrHK9OaAOLsfqckK%2B6%2Fk1%2FtHsK%2BeieKbKB0AbMmqc1mhV5DoDYMfaTL0qFAn%2Bdd3hszF6LYzyLTNJE3LeaEr0%2BI1zCcNwVHV9PeeXFSD&Expires=1636642585"
                    ]
                ]
            ]
            ]
            let data = try! JSONSerialization.data(withJSONObject: jsonDict)
            items = try JSONDecoder().decode(SCItemSection.self, from: data)
            return items
        }
        catch
        {
            return items
        }
    }
}
