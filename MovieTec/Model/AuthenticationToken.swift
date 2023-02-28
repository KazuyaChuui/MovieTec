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

struct SessionResponseNoID: Codable {
    let success: Bool
    
    private enum SessionCodingKeys: String, CodingKey {
        case success
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: SessionCodingKeys.self)
        success = try container.decode(Bool.self, forKey: .success)
    }
}

struct SessionDeleteResponse: Codable {
    let success: Bool
}

struct Account: Codable {
    let avatar: Avatar
    let username: String
    
    private enum AccountCodingKeys: String, CodingKey {
        case avatar
        case username
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: AccountCodingKeys.self)
        avatar = try container.decode(Avatar.self, forKey: .avatar)
        username = try container.decode(String.self, forKey: .username)
    }
}

struct Avatar: Codable {
    let tmdb: Tmdb
    
    private enum AvatarCodingKeys: String, CodingKey {
        case tmdb
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: AvatarCodingKeys.self)
        tmdb = try container.decode(Tmdb.self, forKey: .tmdb)
    }
}

struct Tmdb: Codable {
    let avatar_path: String
    
    private enum AvatarCodingKeys: String, CodingKey {
        case avatar_path
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: AvatarCodingKeys.self)
        avatar_path = try container.decode(String.self, forKey: .avatar_path)
    }
}

struct UploadData: Codable {
    let username: String
    let password: String
    let request_token: String
}


struct UploadRequest: Codable {
    let request_token: String
}

struct DeleteRequest: Codable {
    let session_id: String
}
