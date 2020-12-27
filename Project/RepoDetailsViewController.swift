//
//  repoDetailsViewController.swift
//  Project
//
//  Created by m on 27/12/2020.
//

import Foundation
import UIKit
import Alamofire

class RepoDetailsViewController : UIViewController{
    
    var repo:Repo?
    var languages:[String]?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        reload(nil)
        updateData()
    }
    
    func updateData(){
        if let repo=repo{
            print(repo)
            repoName.text=repo.name
            repoStars.text=String(repo.stargazers_count)
            repoWatches.text=String(repo.watchers_count)
            repoforks.text=String(repo.forks_count)
            if let description=repo.description{
                repoDescription.text="Description:\n\(description)"
            }else{
                repoDescription.text="No descripton"
            }
            if let license=repo.license{
                repoLicense.text="License:\n\(license.name)"
            }else{
                repoLicense.text="No License"
            }
            if let languages = languages{
                repoLanguages.text="Languages:\(languages[0])"
            }
            
            
        }
    }
    
    @IBAction func reload(_ sender: Any?) {
        if let repoLangUrl = repo?.languages_url{
            AF.request(repoLangUrl).responseJSON{response in
                if let error = response.error{
                    self.presentError(error)
                }
                if let data=response.data{
//                    do{
//                        let downloadedLanguages=try JSONDecoder().decode(//todo, from: data)
//                       self.languages=downloadedLanguages
//                        self.updateData()
//                    }catch{
//                        self.presentError(error)
//                    }
                }
            }
        }
    }
    
    func presentError(_ error:Error){
        let alert=UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "reload", style: .default, handler: {_ in self.reload(nil)}))
        self.present(alert, animated: true)
    }
    
    @IBOutlet weak var repoName: UILabel!
    @IBOutlet weak var repoStars: UILabel!
    @IBOutlet weak var repoWatches: UILabel!
    @IBOutlet weak var repoforks: UILabel!
    @IBOutlet weak var repoLanguages: UILabel!
    @IBOutlet weak var repoDescription: UILabel!
    @IBOutlet weak var repoLicense: UILabel!
    
}
