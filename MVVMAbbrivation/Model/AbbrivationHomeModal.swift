//
//  AbbrivationHomeModal.swift
//  AppleLogin
//
//  Created by Codigo Technologies on 15/10/21.
//

import Foundation

struct Root: Decodable {
    let arrivals: Arrivals
}
struct Arrivals: Decodable {
    let all: [AbrivationHomeModal]
}
struct AbrivationHomeModal : Codable {
    var sf : String?
    let lfs : [Lfs]?

    enum CodingKeys: String, CodingKey {

        case sf = "sf"
        case lfs = "lfs"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        if let  newSF = try values.decodeIfPresent(String.self, forKey: .sf) {
            sf = newSF
        }
        lfs = try values.decodeIfPresent([Lfs].self, forKey: .lfs)
    }

}

struct Vars : Codable {
    let lf : String?
    let freq : Int?
    let since : Int?

    enum CodingKeys: String, CodingKey {

        case lf = "lf"
        case freq = "freq"
        case since = "since"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        lf = try values.decodeIfPresent(String.self, forKey: .lf)
        freq = try values.decodeIfPresent(Int.self, forKey: .freq)
        since = try values.decodeIfPresent(Int.self, forKey: .since)
    }

}

struct Lfs : Codable {
    let lf : String?
    let freq : Int?
    let since : Int?
    let vars : [Vars]?

    enum CodingKeys: String, CodingKey {

        case lf = "lf"
        case freq = "freq"
        case since = "since"
        case vars = "vars"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        lf = try values.decodeIfPresent(String.self, forKey: .lf)
        freq = try values.decodeIfPresent(Int.self, forKey: .freq)
        since = try values.decodeIfPresent(Int.self, forKey: .since)
        vars = try values.decodeIfPresent([Vars].self, forKey: .vars)
    }

}



