//
//  WebSevice.swift
//  CryptoFishing
//
//  Created by Berat Rıdvan Asiltürk on 4.09.2023.
//

import Foundation

class WebService {
    
    // Islem bittikten sonra ne yapilmasi gerektigini comletion handler sayesinde duzenleriz
    // Escaping ile func icerisindeki islemler bittikten sonra calistirilacagi anlasilir
    // Result yapisi bize completion edilecek seyin success or fail durumlarini degerlendirebilmemiz icin hazir bir iceriktir. [result'a tikla oku :)]
    // Result icerisinde ne dondurulecekse <> icerisine yazmamiz gerekiyor
    // Currency'i bir array seklinde yazmamizin sebebi url 'deki json formatindan swift'e cevirdigimiz verinin bir dizi icerisinde yer almasindan dolayidir. Yani liste icerisindeydi json verilerimiz biz de onu belirttik.
    func downloadCurrenties(url: URL, completionHandler: @escaping (Result<[Crypto], NSError>) -> Void ) {
        // URLSession, (datatask ile) veri istegi yaptigimizda url'ye istek atar ve cevap geldikten sonra yapilacak islemleri burada yazmamiza olanak saglar
        URLSession.shared.dataTask(with: url) { data, response, error in
            // Response -cevap- geldikten sonra bu blok calisir
            
        }
    }
}
