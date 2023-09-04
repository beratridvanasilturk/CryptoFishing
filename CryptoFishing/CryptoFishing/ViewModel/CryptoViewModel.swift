//
//  CryptoViewModel.swift
//  CryptoFishing
//
//  Created by Berat Rıdvan Asiltürk on 4.09.2023.
//

import Foundation
import RxSwift
import RxCocoa

// MVVM mimarisinin amaci VC'da yapilacak olan tum islemlerin sadece kullanicinin gormesi gerektigi yerlerle ilgili olmasi gerektiginden oturu VC'ya yuk bindirmeden gerekli atiflari modelden veya ViewModel'den aliriz.

// ViewModel'den veriyi alip VC'a gondermemiz icin 3 temel arac vardir
    // 1. RXSwift
    // 2. Combine Framework
    // 3. Delegate Pattern
// Bu projede RXSwift kullanilacaktir. RxSwift'i de SPM ile entegre edecegiz.
class CryptoViewModel {
    
    func requestData() {
        
        
        // ViewModel'e tasimamiz gerek buyuk projelerde MVVM icin bu gereklidir
        let url = URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json")!
        WebService().downloadCurrenties(url: url) { result in
            switch result {
            case .success(let cryptos):
                
                print(cryptos)
//
//                self.cryptoList = cryptos
//                // UrlSession kendisi arka planda global thread'da atadigi icin hatanin giderilmesi icin main'e almamiz lazim
//                // Main thread kullanici arayuzu ile etkilesim yapma anlamina gelir
//                DispatchQueue.main.async {
//                    self.tableView.reloadData()
//                }
//
            case .failure(let failure):
            print(failure)
            }
        }
        
        
    }
    
}
