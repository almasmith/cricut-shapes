//
//  ShapeButtonAPI.swift
//  CricutShapes
//
//  Created by Jason Smith on 3/24/25.
//

import Foundation

struct Buttons: Decodable {
    let buttons: [ButtonName]
}

struct ButtonName: Decodable {
    let name: String
    let drawPath: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case drawPath = "draw_path"
    }
}

enum APIError: Error {
    case invalidURL
    case networkError(Error)
    case decodingError(Error)
}

struct ShapeButtonAPI {
    private static let endpoint = "https://staticcontent.cricut.com/static/test/shapes_001.json"
    
    @discardableResult
    static func shapeButtonNames() async throws -> [ButtonName] {
        if let url = URL(string: endpoint) {
            var data: Data?
            do {
                (data, _) = try await URLSession.shared.data(from: url)
            } catch {
                throw APIError.networkError(error)
            }
            do {
                let buttons = try JSONDecoder().decode(Buttons.self, from: data!)
                return buttons.buttons
            } catch {
                throw APIError.decodingError(error)
            }
        } else {
            throw APIError.invalidURL
        }
    }
}

