//
//  ReposViewController.swift
//  Project
//
//  Created by m on 26/12/2020.
//

import Foundation
import UIKit
import Alamofire

class ReposViewController: UITableViewController  {
    
    var user:User?
    var repos : [Repo]=[]
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        reload(nil)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "repoDetails", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "repoDetails"{
            let viewController = segue.destination as! RepoDetailsViewController
            if let indexPath = tableView.indexPathForSelectedRow{
                viewController.repo=repos[indexPath.row]
            }
        }
            
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        repos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "repoCell",for: indexPath) as! RepoTableViewCell
        cell.repoName.text=repos[indexPath.row].name
        return cell
    }
    
    @IBAction func reload(_ sender: Any?) {
        guard let user = user else{
            return
        }
        AF.request("https://api.github.com/users/\(user.login)/repos").responseJSON{ response in
            if let error = response.error{
                self.presentError(error)
            }
            
            if let data = response.data{
                do{
                    let downloadedRepos = try JSONDecoder().decode([Repo].self, from: data)
                    self.repos=downloadedRepos
                    self.tableView.reloadData()
                }catch{
                    self.presentError(error)
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
    
}

class RepoTableViewCell : UITableViewCell{
    @IBOutlet weak var repoName: UILabel!
}
