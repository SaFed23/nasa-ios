//
//  Picture.swift
//  Example Api
//
//  Created by TaniaLebed on 5/10/20.
//  Copyright © 2020 TaniaLebed. All rights reserved.
//

import Foundation

struct Picture {
    let earth_date: String?
    let img_src: String?
}

extension Picture: Decodable {
    enum CodingKeys: String, CodingKey {
        case earth_date
        case img_src
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let earth_date = try container.decode(String.self, forKey: .earth_date)
        let img_src = try container.decode(String.self, forKey: .img_src)
        self.init(earth_date: earth_date, img_src: img_src)
    }
}

struct Pictures: Decodable {
    var photos: [Picture]
}
