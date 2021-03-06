//
//  RecognitionAPI.swift
//  SmartReceipts
//
//  Created by Bogdan Evsenev on 05/11/2017.
//  Copyright © 2017 Will Baumann. All rights reserved.
//

import RxSwift
import Moya

enum SmartReceiptsAPI {
    case signup(credentials: Credentials)
    case login(credentials: Credentials)
    case logout
    case user
    case subscriptions
    case saveDevice(token: String)
    case recognition(id: String)
    case recognize(url: URL, incognito: Bool)
    case mobileAppPurchases(receipt: String)
}

extension SmartReceiptsAPI: TargetType {
    var baseURL: URL {
        let prefix = FeatureFlags.useProdEndpoints.isEnabled ? "www" : "beta"
        return URL(string: "https://\(prefix).smartreceipts.co/api")!
    }

    var path: String {
        switch self {
        case .signup: return "/users/sign_up"
        case .login: return "/users/log_in"
        case .logout: return "/users/log_out"
        case .user: return "/users/me"
        case .subscriptions: return "/subscriptions"
        case .saveDevice: return "/users/me"
        case .recognition(let id): return "/recognitions/\(id)"
        case .recognize: return "/recognitions"
        case .mobileAppPurchases: return "/mobile_app_purchases"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .signup: return .post
        case .login: return .post
        case .logout: return .delete
        case .user: return .get
        case .subscriptions: return .get
        case .saveDevice: return .patch
        case .recognition: return .get
        case .recognize: return .post
        case .mobileAppPurchases: return .post
        }
    }
    
    var headers: [String : String]? { return nil }
    
    var parameters: [String: Any] {
        switch self {
        case .signup(let creds):
            return ["signup_params" : [ "type": "signup", "email" : creds.email, "password": creds.password] ]
        case .login(let creds):
            return ["login_params" : [ "type": "login", "email" : creds.email, "password": creds.password] ]
        case .logout: return [:]
        case .user: return [:]
        case .subscriptions: return [:]
        case .saveDevice(let token):
            return ["user" : [ "registration_ids": [token] ] ]
        case .recognition: return [:]
        case .recognize(let url, let incognito):
            return ["recognition": [ "s3_path" : "ocr/\(url.lastPathComponent)", "incognito" : incognito] ]
        case .mobileAppPurchases(let receipt):
            return ["encoded_receipt": receipt, "pay_service": "Apple Store", "goal": "Recognition"]
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        switch self {
        case .signup: return URLEncoding.httpBody
        case .login: return URLEncoding.httpBody
        case .logout: return URLEncoding.httpBody
        case .user: return URLEncoding.httpBody
        case .subscriptions: return URLEncoding.httpBody
        case .saveDevice: return JSONEncoding.default
        case .recognition: return URLEncoding.httpBody
        case .recognize: return JSONEncoding.default
        case .mobileAppPurchases: return JSONEncoding.default
        }
    }
    
    var authParams: [String: Any] {
        switch self {
        case .user,
             .subscriptions,
             .saveDevice,
             .recognize,
             .recognition,
             .mobileAppPurchases,
             .logout:
            return ["auth_params[token]": AuthService.shared.token, "auth_params[id]": AuthService.shared.id]
            
        default:
            return [:]
        }
    }
    
    var task: Task {
        return .requestCompositeParameters(bodyParameters: parameters, bodyEncoding: parameterEncoding, urlParameters: authParams)
    }
    
    var sampleData: Data { return Data() }
    
}
