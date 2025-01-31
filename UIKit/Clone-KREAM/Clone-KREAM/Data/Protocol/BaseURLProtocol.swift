//
//  BaseURLProtocol.swift
//  Clone-KREAM
//
//  Created by 이승진 on 1/28/25.
//

import Foundation
import Moya

protocol BaseURLProtocol: TargetType {}

extension BaseURLProtocol {
    var baseURL: URL {
        guard let url = URL(string: SecretClass.shared.baseURL()) else {
            fatalError("print: \(SecretClass.shared.baseURL())")
        }
        return url
    }
}
