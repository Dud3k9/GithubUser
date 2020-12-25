//
//  ViewController.swift
//  Project
//
//  Created by m on 09/12/2020.
//

import UIKit
import Alamofire

class SearchUserViewController: UIViewController, UISearchBarDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate=self
        	
    }
    
    	

    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //searchText= text
    }
    
    
    @IBAction func onTapUser(_ sender: Any) {
        performSegue(withIdentifier: "UserDetail", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "UserDetail"{
            let viewController = segue.destination as! UserDetailViewConroller
            //przekazywanie danych
        }
        	
    }
    

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userView: UIView!
    
    
   }

