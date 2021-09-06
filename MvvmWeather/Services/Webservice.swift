//
//  Webservice.swift
//  MvvmWeather
//
//  Created by usr on 2021/9/6.
//

import Foundation

struct Resource<T> {
    let url: URL
    let parse: (Data) -> T?
}

final class Webservice {
    func load<T>(resource : Resource<T>, completion: @escaping (T?) -> Void) {
        URLSession.shared.dataTask(with: resource.url) { data, response, error in
            if let data = data {
                debugPrint(data)
                /* ⭐️ 回呼（Callback）執行於背景執行緒，若想更新 UI 必須
                 * 指定 completion 執行在主執行緒上 */
                DispatchQueue.main.async {
                    completion(resource.parse(data))
                }
            } else {
                completion(nil)
            }
        }.resume()
    }
}
