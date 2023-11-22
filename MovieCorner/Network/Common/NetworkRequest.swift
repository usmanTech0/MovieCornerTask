//
//  NetworkRequest.swift
//  MovieCorner
//
//  Created by M Usman on 21/11/2023.
//

import Foundation

import Foundation
import Alamofire



public class NetworkRequest <Req:Encodable,Res:Codable> : NSObject{
    var method:HTTPMethod=HTTPMethod.get
    var url:String?
    var requestModel:Req! // by default nil
    
    init(method:HTTPMethod,url:String) {
        self.method=method
        self.url=url
    }
    
    init(method:HTTPMethod,url:String,requestModel:Req) {
        self.method=method
        self.url=url
        self.requestModel=requestModel
    }
    
    let token =
        "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIzMjJmMDM3Njg5YWE2MmIwNzg5ZTQ5MTVkYjQxNGZhYSIsInN1YiI6IjY1NWMzY2U3ZWE4NGM3MTA5MTBlZWZhOSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.a8tQvE2-f5oecUoCa1CStNOTw1dmmna6t_0uM1RQW7M"
    
    func sendHTTPRequest(
        successful: @escaping (Res?) -> Void,
        failed: @escaping (_ responseCode: Int, _ error:String) -> Void
    )
    {
        var request = URLRequest(url: URL(string: self.url!)!)
        request.httpMethod=method.rawValue
        //attaching token
        request.setValue( "Bearer \(token)", forHTTPHeaderField: "Authorization")
        SessionManager.session.request(request)
            .responseData { response in
                switch response.result {
                case .success(let success):
                    let data = try? JSONDecoder().decode(Res.self, from: success)
                    
                    if let FailureData = try? JSONDecoder().decode(ResponseFailure.self, from: success) , FailureData.statusCode != nil {
                        failed(FailureData.statusCode ?? 0,FailureData.statusMessage ?? "")
                        return
                    }
                    
                    if let serverResponse = data {
                        successful(serverResponse)
                    }
                    
                case .failure(let fail):
                    print(fail)
                    failed(fail.responseCode ?? 400,fail.localizedDescription)
                    return
                }
            }
    }
}
