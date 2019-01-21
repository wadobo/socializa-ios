//
//  SocializaBackend.swift
//  Socializa
//
//  Created by Jose Luis Fernandez-Mayoralas on 12/1/19.
//  Copyright © 2019 wadobo. All rights reserved.
//

import Foundation


final class SocializaBackend {
    struct SocializaRequest: Encodable {
        var client_id: String
        var grant_type: String
        var backend: String
        var token: String
    }
    
    struct SocializaAccessToken: Decodable {
        var access_token: String
        var token_type: String
        var refresh_token: String
    }

    enum SocializaPlatform: String {
        case facebook
        case google
    }
    
    enum SocializaError: Error {
        case emptyResponse(url: URL)
    }
    
    static let shared = SocializaBackend()
    
    fileprivate let baseURLString = "https://socializa.wadobo.com/api/v1.0/"
    fileprivate let iosClientId = "z5SCIpsCZR1wnPlJFZtDkNmGVBQpViWMRx5aKIV9"
    
    private init() {}
    
    func convertToken(_ token: String, platform: SocializaPlatform, completion: @escaping (SocializaAccessToken?, Error?) -> ()) {
        let url = URL(string: baseURLString + "/auth/convert-token/")!
        let params = SocializaRequest(
            client_id: iosClientId,
            grant_type: "convert_token",
            backend: platform.rawValue,
            token: token
        )
        
        fetchData(url: url, params: params, completion: completion)
    }
    
    fileprivate func fetchData<T: Encodable, U: Decodable>(url: URL, params: T, completion: @escaping (U?, Error?) -> ()) {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        let jsonParams = try! JSONEncoder().encode(params)
        urlRequest.httpBody = jsonParams
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let responseData = data else {
                completion(nil, SocializaError.emptyResponse(url: url))
                return
            }
            
            do {
                let result = try JSONDecoder().decode(U.self, from: responseData)
                completion(result, nil)
            } catch {
                completion(nil, error)
            }
        }.resume()
    }
}
