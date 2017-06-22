//
//  APIConsumer.swift
//
//  Created by Apple on 03/08/16.
//  Copyright © 2016 Apple. All rights reserved.
//
import Foundation
import UIKit
import Alamofire


protocol APIConsumerDelegate {
    func APIResponseArrived(Response:AnyObject)
}


class APIConsumer : NSObject,NSURLConnectionDelegate, NSURLConnectionDataDelegate{
    
    var connection : NSURLConnection = NSURLConnection()
    var responseData : NSMutableData = NSMutableData()
    var requestDic  = [String: NSObject]()
    var delegate:APIConsumerDelegate! = nil
    var activity_indicator_count :Int = 0
    
    func doRequestGet(url:String){
        showNetworkActivity()
        
        let session = NSURLSession.sharedSession()
        
        let urlPath = NSURL(string: url)
        let request = NSMutableURLRequest(URL: urlPath!)
        request.timeoutInterval = 60
        request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.HTTPMethod = "GET"
        
        let dataTask = session.dataTaskWithRequest(request) { (data:NSData?, response:NSURLResponse?, error:NSError?) -> Void in
            self.hideNetworkActivity()
            if((error) != nil) {
                print(error!.localizedDescription)
                [self.delegate .APIResponseArrived([])]
            }else {
                _ = NSString(data: data!, encoding:NSUTF8StringEncoding)
                let _: NSError?
                let jsonResult: AnyObject = try! NSJSONSerialization.JSONObjectWithData(data!, options:    NSJSONReadingOptions.MutableContainers)
                
                self.delegate.APIResponseArrived(jsonResult)
            }
        }
        dataTask.resume()
    }
    
    func doRequestGet(url:String,data:[String: NSObject]){
        showNetworkActivity()
        requestDic = data
        let theJSONData = try? NSJSONSerialization.dataWithJSONObject(
            data ,
            options: NSJSONWritingOptions(rawValue: 0))
        let jsonString = NSString(data: theJSONData!,encoding: NSASCIIStringEncoding)
        
        print("Request Object:\(data)")
        print("Request string = \(jsonString!)")
        
        let session = NSURLSession.sharedSession()
        
        let urlPath = NSURL(string: url)
        let request = NSMutableURLRequest(URL: urlPath!)
        request.timeoutInterval = 60
        request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.HTTPMethod = "GET"
        let postLength = NSString(format:"%lu", jsonString!.length) as String
        request.setValue(postLength, forHTTPHeaderField:"Content-Length")
        request.HTTPBody = jsonString!.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion:true)
        
        let dataTask = session.dataTaskWithRequest(request) { (data:NSData?, response:NSURLResponse?, error:NSError?) -> Void in
            self.hideNetworkActivity()
            if((error) != nil) {
                print(error!.localizedDescription)
                [self.delegate .APIResponseArrived([])]
            }else {
                _ = NSString(data: data!, encoding:NSUTF8StringEncoding)
                let _: NSError?
                let jsonResult: AnyObject = try! NSJSONSerialization.JSONObjectWithData(data!, options:    NSJSONReadingOptions.MutableContainers)
                
                self.delegate.APIResponseArrived(jsonResult)
            }
        }
        dataTask.resume()
        
    }
    
    func doRequestPost(){
        
        let request = NSMutableURLRequest(URL: NSURL(string: "http://192.168.1.132/EventFlip/")!)
        request.HTTPMethod = "POST"
        let postString = "action=dashboard"
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
            guard error == nil && data != nil else {                                                          // check for fundamental networking error
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? NSHTTPURLResponse where httpStatus.statusCode != 200 {
                
                // check for http errors
                print("statusCode should be 200, but is 111111111\(httpStatus.statusCode)")
                print("response = \(response)")
            }
            
//            let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
           // print("responseString = \(responseString)")
            
            let jsonResult: AnyObject = try! NSJSONSerialization.JSONObjectWithData(data!, options:    NSJSONReadingOptions.MutableContainers)

            
            self.delegate.APIResponseArrived(jsonResult)
        }
        task.resume()

        
        
        /*
        
        showNetworkActivity()
        requestDic = data
        
        let theJSONData = try? NSJSONSerialization.dataWithJSONObject(
            data ,
            options: NSJSONWritingOptions(rawValue: 0))
        let jsonString = NSString(data: theJSONData!,
                                  encoding: NSASCIIStringEncoding)
        
        
        print("Request Object:\(data)")
        print("Request string = \(jsonString!)")
        
        let session = NSURLSession.sharedSession()
        
        let urlPath = NSURL(string: url)
        let request = NSMutableURLRequest(URL: urlPath!)
        request.timeoutInterval = 60
        request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.HTTPMethod = "POST"
        let postLength = NSString(format:"%lu", jsonString!.length) as String
        request.setValue(postLength, forHTTPHeaderField:"Content-Length")
        request.HTTPBody = jsonString!.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion:true)
        
        let dataTask = session.dataTaskWithRequest(request) { (data:NSData?, response:NSURLResponse?, error:NSError?) -> Void in
            self.hideNetworkActivity()
            if((error) != nil) {
                print(error!.localizedDescription)
                [self.delegate .APIResponseArrived([])]
            }else {
                print("Succes:")
                _ = NSString(data: data!, encoding:NSUTF8StringEncoding)
                let _: NSError?
                let jsonResult: AnyObject = try! NSJSONSerialization.JSONObjectWithData(data!, options:    NSJSONReadingOptions.MutableContainers)
                
                self.delegate.APIResponseArrived(jsonResult)
            }
        }
        dataTask.resume()
 
 */
    }
    
    
    
    func doRequestPostAlomoFire(comment:[String : AnyObject],url:String){
        
        Alamofire.request(.POST, url, parameters: comment).responseJSON{
            response in
            
            do {
                let json = try NSJSONSerialization.JSONObjectWithData(response.data!, options: .AllowFragments)
                
              //  let jsonResult: AnyObject = try! NSJSONSerialization.JSONObjectWithData(data!, options:    NSJSONReadingOptions.MutableContainers)
                
                
                self.delegate.APIResponseArrived(json)
            } catch {
                print("error serializing JSON: \(error)")
            }
            
            
        }

        
    }
    
    //Method For Https Certification Approve
    func connection(connection: NSURLConnection,
                    willSendRequestForAuthenticationChallenge challenge: NSURLAuthenticationChallenge){
        if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust && challenge.protectionSpace.host == "Your Domain Name write if uses https" {
            let credential = NSURLCredential(forTrust: challenge.protectionSpace.serverTrust!)
            challenge.sender!.useCredential(credential, forAuthenticationChallenge: challenge)
        } else {
            challenge.sender?.performDefaultHandlingForAuthenticationChallenge!(challenge)
        }
    }
    
    
    func showNetworkActivity(){
        activity_indicator_count += 1
        if (activity_indicator_count > 0) {
            UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        }
    }
    
    func hideNetworkActivity(){
        activity_indicator_count -= 1;
        if(activity_indicator_count < 1){
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        }
    }
}