//
//  RMDataSource.swift
//  RickAndMorty
//
//  Created by Leticia Echarri on 28/4/24.
//

import Foundation
import RickMortySwiftApi

class RMDataSource {
    private var client = RMClient()
    
    func character() -> RMCharacter {
        client.character()
    }
    
    func episode() -> RMEpisode {
        client.episode()
    }
    
    func location() -> RMLocation {
        client.location()
    }
}
