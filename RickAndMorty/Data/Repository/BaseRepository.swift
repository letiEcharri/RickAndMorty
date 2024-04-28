//
//  BaseRepository.swift
//  RickAndMorty
//
//  Created by Leticia Echarri on 28/4/24.
//

import Foundation

class BaseRepository: DataSource {
    let client: DataClient
    
    init(_ client: DataClient) {
        self.client = client
    }
}
