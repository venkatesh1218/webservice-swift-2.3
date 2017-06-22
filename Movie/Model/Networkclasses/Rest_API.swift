//
//  Rest_API.swift
//  
//  Created by Apple on 03/08/16.
//  Copyright © 2016 Apple. All rights reserved.
//

import UIKit
import Foundation





enum REST_DELEGATE_ON : Int {
    case DELEGATE_WITH_TOKEN = 0,
    DELEGATE_WITH_TOKEN_AND_DATA
}

@objc protocol Rest_APIDelegate {
    optional func Rest_APIResponseArrived(Response:AnyObject,Token:String)
    optional func Rest_APIResponseArrived(Response:AnyObject,Token:String,Data:NSDictionary)
    optional func Rest_API_UploadTime(totalBytesWritten:NSInteger,writeBytes:NSInteger,Token:String)
}

class Rest_API:APIConsumerDelegate {
    
    var delegate:Rest_APIDelegate!
    var token :String = String()
    var _ref_data : NSDictionary = NSDictionary()
    var delegate_on : REST_DELEGATE_ON = REST_DELEGATE_ON.DELEGATE_WITH_TOKEN
    var objAPIConsumer : APIConsumer = APIConsumer()
    var restDelegate : Rest_APIDelegate! = nil

    func initWithToken(userToken:String)->AnyObject{
        self.token = userToken;
        self.objAPIConsumer = APIConsumer()
        self.objAPIConsumer.delegate = self
        delegate_on = REST_DELEGATE_ON.DELEGATE_WITH_TOKEN
        return self
    }

    func initWithToken(userToken:String,data:NSDictionary)->AnyObject{
        self.token = userToken;
        self._ref_data = data
        self.objAPIConsumer = APIConsumer()
        self.objAPIConsumer.delegate = self
        delegate_on = REST_DELEGATE_ON.DELEGATE_WITH_TOKEN_AND_DATA
        return self
    }
    
    
    func APIResponseArrived(Response:AnyObject){
        
        if(delegate_on == REST_DELEGATE_ON.DELEGATE_WITH_TOKEN_AND_DATA){
            restDelegate.Rest_APIResponseArrived!(Response, Token: self.token, Data: self._ref_data)
            
        }else if(delegate_on == REST_DELEGATE_ON.DELEGATE_WITH_TOKEN){
            restDelegate.Rest_APIResponseArrived!(Response, Token: self.token)
            
        }
        
    }
    
    func APIUploadTime(totalBytesWritten:NSInteger,totalBytesExpectedToWrite:NSInteger){
       restDelegate.Rest_API_UploadTime!(totalBytesWritten, writeBytes: totalBytesExpectedToWrite, Token: self.token)
    }
    
//    func postLoginDemo(appNum:integer_t,user_name:String,password:String){
//        let req  = [ "apps": NSNumber(int: appNum),
//            "users":user_name,
//            "password":password
//        ];
       // self.objAPIConsumer.doRequestPost(ARYVART_EVENTFLIP_Testurl, data: req)
   // }
    
    

    func Action_PostMethod(){
        
       // let req  = ["action":"dashboard"];
        
        self.objAPIConsumer.doRequestPost()
    }
    func Action_GetMethod(){
      //  let newUrl : String = ARYVART_EVENTFLIP_Testurl
       // self.objAPIConsumer.doRequestGet(newUrl)
    }
    
    
//    func Action_RestCall_POST(comment:[String : AnyObject],url:String){
//        
//        
//        Alamofire.request(.POST, url, parameters: comment).responseJSON{
//            response in
//            
//            
//            do {
//                let json = try NSJSONSerialization.JSONObjectWithData(response.data!, options: .AllowFragments)
//                
//                print(json)
//                
//            } catch {
//                print("error serializing JSON: \(error)")
//            }
//
//            
//    }
//}




    func Action_RestCall_POST(comment:[String : AnyObject],url:String){
        self.objAPIConsumer.doRequestPostAlomoFire(comment,url: url)
        
}




}



















