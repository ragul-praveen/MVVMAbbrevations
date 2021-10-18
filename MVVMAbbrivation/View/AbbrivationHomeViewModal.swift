//
//  AbbrivationHomeViewModal.swift
//  AppleLogin
//
//  Created by Codigo Technologies on 15/10/21.
//

import Foundation
import UIKit


class AbrivationHomeViewModal:NSObject {
    
    var abrivationHomeModal:[AbrivationHomeModal]!
     
    func callAbbrivationAPI(_ string:String, completion:@escaping(_ isShowTableView:Bool)->()){
       
        let url = URL(string: "http://www.nactem.ac.uk/software/acromine/dictionary.py?sf=\(string)")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.timeoutInterval = 30
        URLSession.shared.dataTask(with: request) { resData, response, error in
            if (response as? HTTPURLResponse)?.statusCode == 200 {
                if resData != nil {
                    do {
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        let json = try decoder.decode([AbrivationHomeModal].self, from: resData ?? Data())
                       self.abrivationHomeModal = json
                        completion(self.numberOfSearchedItems() > 0)
                    }
                    catch {
                        print(error.localizedDescription)
                    }
                }
            }else {
                DispatchQueue.main.async {
                    let appdelegateWindow = UIApplication.shared.delegate as? AppDelegate
                    
                    openPopUP(Title: "Error", Message: "API Issue Contact Admin or check Params", vc: appdelegateWindow?.window?.rootViewController ?? UIViewController())
                }
               
            }
        }.resume()
    }
    
    func numberOfSearchedItems()->Int {
        return abrivationHomeModal != nil ? abrivationHomeModal.first?.lfs?.count ?? 0 : 0
    }
    
    
    func getSearchedItem(_ indexPath:IndexPath)-> Lfs {
        return (abrivationHomeModal.first?.lfs ?? [])[indexPath.row]
    }
    
    
}



func openPopUP(Title: String,Message: String, vc: UIViewController){
    let alert = UIAlertController(title: Title, message: Message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style:   .default, handler: nil))
    vc.present(alert, animated: true, completion: nil)
}
