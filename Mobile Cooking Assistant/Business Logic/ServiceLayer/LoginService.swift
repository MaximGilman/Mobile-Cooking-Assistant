//
//  LoginService.swift
//  Mobile Cooking Assistant
//
//  Created by Parshakov Alexander on 9/27/21.
//

import Foundation

protocol LoginService: AnyObject {
    func logIn(login: String, password: String, completion: @escaping (String, User?) -> Void)
    func logOut(completion: @escaping (Bool) -> Void)
    func register(login: String, password: String, userName: String, completion: @escaping (String, User?) -> Void)
    func logInGoogle(completion:@escaping (Bool)->Void)
}

final class BaseLoginService: LoginService {
   
    func logIn(login: String, password: String, completion: @escaping (String, User?) -> Void){
        
        if(login.isEmpty || password.isEmpty){
            completion("login or password is not filled", nil)
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
        
        var errorString : String = ""
        var user :User?
        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            DispatchQueue.main.async {
                var responseDict = [String: Any]()
                do {
                     responseDict = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String: Any]
                       }
                catch let error as NSError {
                           print(error)
                       }
                
                if error != nil || (response as! HTTPURLResponse).statusCode != 200 {
                    errorString = responseDict["message"] as! String
                    completion(errorString, nil)
                } else if let data = data {
                    let id = responseDict["key"] as! Int
                    let name = responseDict["name"] as! String

                    user = User(id:id, name:name, photo:nil, recipes:nil, loginData:nil)
                    completion("",user)
                }
            }
        }.resume()
    }
    
    func logOut(completion: @escaping (Bool) -> Void) {
        completion(true)
    }
    
    func register(login: String, password: String, userName: String,completion: @escaping (String, User?) -> Void) {
        guard !login.isEmpty && !password.isEmpty && !userName.isEmpty else {
            completion("some data is not filled", nil)
            return
        }
        
        let dict: [String: Any] = [
            "login": login,
            "password": password,
            "name":userName,
            "email":"no email"
        ]
        let url = URL(string: "http://94.242.58.199/dipd/user/create")!
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
        var errorString : String = ""
        var user :User?
        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            DispatchQueue.main.async {
                var responseDict = [String: Any]()
                do {
                     responseDict = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String: Any]
                    errorString = responseDict["message"] as! String
                       }
                catch let error as NSError {
                           print(error)
                       }
                
                if error != nil || (response as! HTTPURLResponse).statusCode != 200 {
                    completion(errorString, nil)
                } else if let data = data {
                    let id = responseDict["key"] as! Int
                    let name = responseDict["name"] as! String

                    user = User(id:id, name:name, photo:nil, recipes:nil, loginData:nil)
                    completion("",user)
                }
            }
        }.resume()
    }
    
    func logInGoogle(completion: @escaping (Bool) -> Void) {
     //   let signInConfig = GIDConfiguration.init(clientID: "206916034058-9ln4c2s8g418t481ho4hqje4ff6himhe.apps.googleusercontent.com")
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
