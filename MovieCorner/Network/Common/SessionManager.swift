//
//  SessionManager.swift
//  MovieCorner
//
//  Created by M Usman on 21/11/2023.
//

import Alamofire

class SessionManager {
    
    private static var _sessionInstance: Session?
    
    public static  let session: Session = {
        let configuration = URLSessionConfiguration.af.default
        configuration.timeoutIntervalForRequest = 30
        return Session(configuration: configuration)
    }()
}
