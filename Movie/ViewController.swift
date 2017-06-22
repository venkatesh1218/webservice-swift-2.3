//
//  ViewController.swift
//  Movie
//
//  Created by VInoth on 3/1/17.
//  Copyright © 2017 Aryvart. All rights reserved.
//

import UIKit

class ViewController: UIViewController,Rest_APIDelegate{
    
    
    @IBOutlet weak var Movies_Indicator: UIActivityIndicatorView!
    @IBOutlet weak var Movie_Tb_movielist: UITableView!
    var movies_Serverdata = NSMutableArray()
    
var comment: [String:AnyObject] = Dictionary<String, AnyObject>()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        Movies_Indicator.hidesWhenStopped = true;
        Movies_Indicator.activityIndicatorViewStyle  = UIActivityIndicatorViewStyle.Gray;
        Movies_Indicator.center = view.center;
        Movies_Indicator.startAnimating();
        Web_Services_Call()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    
    // MARK: Web Services Call
    
    func Web_Services_Call(){
        
        
        
        
        let rest : Rest_API = Rest_API()
        rest.initWithToken("Movies")
        rest.restDelegate = self
        
        
        
        rest.Action_RestCall_POST(comment, url:"https://api.themoviedb.org/3/discover/movie?api_key=f29e4356214210de149b4d32007cb04c&primary_release_date.gte=2016-01-01&primary_release_date.lte=2016-03-31")
        
    }
    
    // MARK: Web Services Response
    
    func Rest_APIResponseArrived(Response:AnyObject,Token:String){
        Movies_Indicator.stopAnimating();
    
        if(Token == "Movies"){
           // print(" \(Token) And Response is \(Response)")
            
           movies_Serverdata=Response.objectForKey("results") as! NSMutableArray
            
            let descriptor: NSSortDescriptor =  NSSortDescriptor(key: "release_date", ascending:false, selector: "caseInsensitiveCompare:")
            let sortedResults: NSArray = movies_Serverdata.sortedArrayUsingDescriptors([descriptor])
            
            
            movies_Serverdata=NSMutableArray(array: sortedResults)
            
            
            Movie_Tb_movielist.reloadData()
            
                   }
    }
    
    

    // MARK: tableview delegate methods
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return movies_Serverdata.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("MovieSID", forIndexPath: indexPath)as! MovieTableViewCell
        
        cell.Movie_Title.text=movies_Serverdata[indexPath.row].valueForKey("original_title")! as? String
        
        cell.Movie_Overview.text=movies_Serverdata[indexPath.row].valueForKey("overview")! as? String
        

        
        cell.Movie_Relase.text=movies_Serverdata[indexPath.row].valueForKey("release_date")! as? String
        

        cell.Movies_Language.text=movies_Serverdata[indexPath.row].valueForKey("original_language")! as? String
        
   
        
        
        cell.Movie_Rates.text=String(movies_Serverdata[indexPath.row].valueForKey("vote_average")!)
            cell.Movie_Votes.text=String((movies_Serverdata[indexPath.row].valueForKey("vote_count"))!)


        
        return cell
        
        
    }
    
    
    
    
    

    
    
    
    
    
}

