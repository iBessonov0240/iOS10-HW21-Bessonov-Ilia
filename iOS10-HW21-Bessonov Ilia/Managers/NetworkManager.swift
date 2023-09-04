//
//  NetworkManager.swift
//  iOS10-HW21-Bessonov Ilia
//
//  Created by i0240 on 30.08.2023.
//

import Foundation
import Alamofire

class NetworkManager {
    static let shared = NetworkManager()
    let url = "https://gateway.marvel.com/v1/public/comics?ts=1&apikey=cb27167c4dce10cd59fb1968b971df57&hash=3768edceb96d70710ab3045fea36fc6d"

    private init() {

    }

    func makeAPIRequest(completion: @escaping (Result<MarvelData, ErrorMessage>) -> Void) {
        AF.request(url).responseDecodable(of: MarvelData.self) { response in

            switch response.result {
            case .success:
                do {
                    guard let data = response.data else {
                        throw AFError.responseSerializationFailed(reason: .inputDataNilOrZeroLength)
                    }
                    let decoder = JSONDecoder()
                    let marvelDetails = try decoder.decode(MarvelData.self, from: data)

                    guard case marvelDetails.code = 200 else {
                        completion(.failure(.invalidResponse))
                        return
                    }
                    completion(.success(marvelDetails))
                } catch {
                    completion(.failure(.invalidData))
                }
            case .failure:
                completion(.failure(.unableToComplete))
            }
        }
    }
}
