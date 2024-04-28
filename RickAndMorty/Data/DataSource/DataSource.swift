//
//  DataSource.swift
//  RickAndMorty
//
//  Created by Leticia Echarri on 28/4/24.
//

import Foundation

enum DataClient {
    case rickAndMorty(RMDataSourceContract)
}

protocol DataSource {
    func request(_ client: DataClient) async throws -> AnyObject
}

extension DataSource {
    func request(_ client: DataClient) async throws -> AnyObject {
        switch client {
        case .rickAndMorty(let dataSource):
            return dataSource as AnyObject
        }
    }
}
