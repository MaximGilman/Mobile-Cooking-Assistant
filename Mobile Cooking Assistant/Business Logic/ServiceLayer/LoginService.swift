//
//  LoginService.swift
//  Mobile Cooking Assistant
//
//  Created by Parshakov Alexander on 9/27/21.
//

import Foundation

protocol LoginService: AnyObject {
    func logIn(login: String, password: String, completion: @escaping (Bool) -> Void)
    func logOut(completion: @escaping (Bool) -> Void)
    func register(login: String, password: String, completion: @escaping (Bool) -> Void)
    func logInGoogle(completion:@escaping (Bool)->Void)
}

final class BaseLoginService: LoginService {
    func logIn(login: String, password: String, completion: @escaping (Bool) -> Void) {
        guard !login.isEmpty && !password.isEmpty else {
            completion(false)
            return
        }
        
        let dict: [String: Any] = [
            "login": login,
            "password": password
        ]
        let url = URL(string: "http://94.242.58.199/dipd/user/login")!
        var request = URLRequest(url: url)
        
        var jsonData = NSData()
        do {
            jsonData = try JSONSerialization.data(withJSONObject: dict, options: .fragmentsAllowed) as NSData
        } catch {
            print(error.localizedDescription)
        }
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData as Data
        request.httpMethod = "POST"
        
        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            DispatchQueue.main.async {
                if error != nil || (response as! HTTPURLResponse).statusCode != 200 {
                    completion(false)
                } else if let data = data {
                    completion(true)
                }
            }
        }.resume()
    }
    
    func logOut(completion: @escaping (Bool) -> Void) {
        completion(true)
    }
    
    func register(login: String, password: String, completion: @escaping (Bool) -> Void) {
        guard !login.isEmpty && !password.isEmpty else {
            completion(false)
            return
        }
        
        let dict: [String: Any] = [
            "login": login,
            "password": password
        ]
        let url = URL(string: "http://94.242.58.199/dipd/user/login")!
        var request = URLRequest(url: url)
        var jsonData = NSData()
        do {
            jsonData = try JSONSerialization.data(withJSONObject: dict, options: .fragmentsAllowed) as NSData
        } catch {
            print(error.localizedDescription)
        }
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData as Data
        request.httpMethod = "POST"
        
        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            DispatchQueue.main.async {
                if error != nil || (response as! HTTPURLResponse).statusCode != 200 {
                    completion(false)
                } else if let data = data {
                    completion(true)
                }
            }
        }.resume()
    }
    
    func logInGoogle(completion: @escaping (Bool) -> Void) {
        let signInConfig = GIDConfiguration.init(clientID: "206916034058-9ln4c2s8g418t481ho4hqje4ff6himhe.apps.googleusercontent.com")
    }
}

extension URL {

    func appending(_ queryItem: String, value: String?) -> URL {

        guard var urlComponents = URLComponents(string: absoluteString) else { return absoluteURL }

        // Create array of existing query items
        var queryItems: [URLQueryItem] = urlComponents.queryItems ??  []

        // Create query item
        let queryItem = URLQueryItem(name: queryItem, value: value)

        // Append the new query item in the existing query items array
        queryItems.append(queryItem)

        // Append updated query items array in the url component object
        urlComponents.queryItems = queryItems

        // Returns the url from new url components
        return urlComponents.url!
    }
}
