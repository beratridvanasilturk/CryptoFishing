//
//  CryptoViewModel.swift
//  CryptoFishing
//
//  Created by Berat Rıdvan Asiltürk on 4.09.2023.
//

import Foundation
// RxSwift, ViewModel sinifi icerisinde bir publish yayin yapacagiz ve VC icerisinde view'den ViewModel'e Subscribe olmamizi saglar, boylece ViewModel icerisinde herhangi bir degisiklik olursa VC'da abone oldugumuz verileri gozlemleme imkani saglar
import RxSwift
import RxCocoa

// MVVM mimarisinin amaci VC'da yapilacak olan tum islemlerin sadece kullanicinin gormesi gerektigi yerlerle ilgili olmasi gerektiginden oturu VC'ya yuk bindirmeden gerekli atiflari modelden veya ViewModel'den aliriz.

// ViewModel'den veriyi alip VC'a gondermemiz icin 3 temel arac vardir
    // 1. RXSwift
    // 2. Combine Framework
    // 3. Delegate Pattern
// Bu projede RXSwift kullanilacaktir. RxSwift'i de SPM ile entegre edecegiz.
class CryptoViewModel {
    
    // Crypto listesini tutup VC'da gozlemlemek istiyorsak sadece bu olusturulan publishSubject degiskeni bizim icin yeterli olacaktir
    let cryptos : PublishSubject<[Crypto]> = PublishSubject()
    // VC'da error'u cekmek istersek bu degiskeni olusturabiliriz
    let error : PublishSubject<String> = PublishSubject()
    // Bu loading degiskenini de url'den data cekerken false, basarili bir sekilde cektikten sonra ise true yaparak ui'da yukleniyor iconu icin bir secenek atayabilmede kullanilir
    let loading : PublishSubject<Bool> = PublishSubject()
    
    func requestData() {
        
        // Bu bir boolean degil ozunde publishSubject oldugu ve RxSwift'ten geldigi icin onNext yani bir sonraki degeri seklinde ancak atama yapabiliriz
        self.loading.onNext(true)
        
        // ViewModel'e tasimamiz gerek buyuk projelerde MVVM icin bu gereklidir
        let url = URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json")!
        WebService().downloadCurrenties(url: url) { result in
            
            // Result'u basarili bir sekilde aldiysam artik loading'i kaldirabilirim
            self.loading.onNext(false)
            
            switch result {
            case .success(let cryptos):
                
                self.cryptos.onNext(cryptos)
//
//                self.cryptoList = cryptos
//                // UrlSession kendisi arka planda global thread'da atadigi icin hatanin giderilmesi icin main'e almamiz lazim
//                // Main thread kullanici arayuzu ile etkilesim yapma anlamina gelir
//                DispatchQueue.main.async {
//                    self.tableView.reloadData()
//                }
//
            case .failure(let failure):
                switch failure {
                case .parsingError :
                    self.error.onNext("Parsing Error")
                case .serverError :
                    self.error.onNext("Server Error")
                }
            }
        }
    }
}
