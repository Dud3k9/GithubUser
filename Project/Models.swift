//
//  User.swift
//  Project
//
//  Created by m on 25/12/2020.
//

import Foundation

struct User : Decodable{
    
    let id:Int
    let login : String
    let avatar_url:String
    let followers:Int
    let public_repos:Int
    let bio:String
}

struct Repo :Decodable{
    let name : String
    let description :String
    let languages_url :String
    let stargazers_count :Int
    let watchers_count :Int
    let forks_count : Int
    let licence :Licence
}

struct Licence :Decodable{
    let name :String
    let key:String
}
