//
//  NetworkConnector.swift
//  VieSure
//
//  Created by Papp Balázs on 2020. 05. 12..
//  Copyright © 2020. com.balazs.papp. All rights reserved.
//

import Foundation

protocol NetworkConnectorProtocol {
    func requestFromUrl(_ url: URL, completion: @escaping (Result<Data, Error>)->Void)
}

class NetworkConnector: NetworkConnectorProtocol {

    func requestFromUrl(_ url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        let session = URLSession(configuration: .default)
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))

                return
            }

            guard let data = data, let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(NetworkError.unknown))
                return
            }

            completion(.success(data))
        }

        task.resume()
    }

}
