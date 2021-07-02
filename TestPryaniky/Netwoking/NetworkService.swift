//
//  NetworkService.swift
//  TestPryaniky
//
//  Created by Александр Рублев on 02.07.2021.
//

import Moya
import Alamofire

protocol NetworkServiceable {
    func request<T: Decodable>(_ endPoint: APIEndPoint, completion: @escaping (Result<T, Error>) -> Void)
}

fileprivate class DefaultAlamofireManager: Alamofire.Session {
    static let sharedManager: DefaultAlamofireManager = {
        let configuration = URLSessionConfiguration.default
        configuration.headers = .default
        configuration.requestCachePolicy = .useProtocolCachePolicy
        return DefaultAlamofireManager(configuration: configuration)
    }()
}

final class NetworkService {
    
    private let provider = MoyaProvider<TargetProvider>(endpointClosure: NetworkService.endpointClosure, session: DefaultAlamofireManager.sharedManager)
    
    private static func customEndpointMapping(for target: TargetProvider) -> Endpoint {
        let url = "\(target.baseURL.absoluteString)\(target.path)"
        
        print(url)
        return Endpoint(url: url,
                        sampleResponseClosure: { .networkResponse(200, target.sampleData) },
                        method: target.method,
                        task: target.task,
                        httpHeaderFields: target.headers)
    }

    static let endpointClosure = { (target: TargetProvider) -> Endpoint  in
        let defaultEndpoint = customEndpointMapping(for: target)
        return defaultEndpoint
    }
}

extension NetworkService: NetworkServiceable {
    func request<T: Decodable>(
        _ endPoint: APIEndPoint,
        completion: @escaping (Result<T, Error>) -> Void ) {
        let targetProvider = TargetProvider(with: endPoint)
        provider.request(targetProvider) { result in
            switch result {
            case .success(let response):
                do {
                    let result: T = try response.data.decode()
                    completion(.success(result))
                } catch let error {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

extension Data {
    func decode<T: Decodable>(type: T.Type = T.self) throws -> T {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            let decoded = try decoder.decode(type, from: self)
            return decoded
        } catch {
            throw error
        }
    }
}
