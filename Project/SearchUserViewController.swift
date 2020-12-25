//
//  ViewController.swift
//  Project
//
//  Created by m on 09/12/2020.
//

import UIKit
import Alamofire


class SearchUserViewController: UIViewController, UISearchBarDelegate {

    var user:User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate=self
    }
  
    
    func updateData(){
        userName.text=user?.login
        if let url=self.user?.avatar_url{
            AF.request(url).response(){response in
                self.userImage.image=UIImage(data: response.data!)
            }
        }
        if user==nil {
        userName.text="no user"
            userImage.image=nil
        }
    }
    
    func downloadUser(username : String){
        AF.request("https://api.github.com/users/"+username).responseJSON{ response in
            if let error = response.error{
                let alert=UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "ok", style: .default))
                self.present(alert,animated: true)
            }
            
            if let data = response.data{
                do{
                    let downloadedUser = try JSONDecoder().decode(User.self, from: data)
                    self.user=downloadedUser
                }catch{
                    self.user=nil
                }
                self.updateData()
            }
        }
    }
    	

    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        downloadUser(username: searchText)
    }
    
    
    @IBAction func onTapUser(_ sender: Any) {
        if user != nil{
        performSegue(withIdentifier: "UserDetail", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "UserDetail"{
            let viewController = segue.destination as! UserDetailViewConroller
            viewController.user=self.user
        }
    }
    

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userView: UIView!
    
    
   }

