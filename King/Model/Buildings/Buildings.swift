//
//  Buildings.swift
//  King
//
//  Created by 1111 on 28.07.21.
//

import Foundation

class Buildings  {
    static let shared : [Building] = {
        guard
          let url = Bundle.main.url(forResource: "Buildings", withExtension: "json"),
          let data = try? Data(contentsOf: url)
          else {
            return []
        }
        do {
          let decoder = JSONDecoder()
          return try decoder.decode([Building].self, from: data)
        } catch {
          return []
        }
      }()
    private init() {}
}
