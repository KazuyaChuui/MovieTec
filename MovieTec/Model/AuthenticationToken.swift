//
//  AuthenticationToken.swift
//  MovieTec
//
//  Created by Furry Ruiz on 26/02/23.
//


struct AuthenticationToken: Codable {
    let success: Bool
    let request_token: String
    
    private enum AuthTokenCodingKeys: String, CodingKey {
        case success
        case request_token
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: AuthTokenCodingKeys.self)
        success = try container.decode(Bool.self, forKey: .success)
        request_token = try container.decode(String.self, forKey: .request_token)
    }
}

struct SessionResponse: Codable {
    let success: Bool
    let session_id: String
    private enum SessionResponseCodingKeys: String, CodingKey {
        case success
        case session_id
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: SessionResponseCodingKeys.self)
        success = try container.decode(Bool.self, forKey: .success)
        session_id = try container.decode(String.self, forKey: .session_id)
    }
}

struct SessionDeleteResponse: Codable {
    let success: Bool
}
