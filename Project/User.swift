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
