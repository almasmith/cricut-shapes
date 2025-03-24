//
//  ShapeButtonAPI.swift
//  CricutShapes
//
//  Created by Jason Smith on 3/24/25.
//

import Foundation

// I really like to make my decodable objects just match API results exactly and worry
// about the way my application will use data somewhere else. In my mind, I just feel
// a lot more free here if I can write networking code without having to worry about how
// my UI or persistence needs to look at the data.

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

// I've handled errors a bunch of different ways and never settled on something that
// I really like. I'm just letting these errors bubble up to the UI, but I've done
// implementations where an application layer transforms api errors to application errors
// and the presentation layer transforms application errors into `LocalizableError`s.
// But that's a lot of work and I haven't seen a huge payoff from it. I'm very open
// to other's preferences here.

enum APIError: Error {
    case invalidURL
    case networkError(Error)
    case decodingError(Error)
}

// If I were managing managing shared resources here, this might change from a struct
// with static methods, to an actor in order to protect access to the shared resources.
// For example if we were managing pagination across large result sets, or perhaps tracking
// download progress across multiple items.

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

