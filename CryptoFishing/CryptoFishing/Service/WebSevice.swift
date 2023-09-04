//
//  WebSevice.swift
//  CryptoFishing
//
//  Created by Berat Rıdvan Asiltürk on 4.09.2023.
//

import Foundation

enum CryptoError : Error {
    case serverError
    case parsingError
}

class WebService {
    
    // Islem bittikten sonra ne yapilmasi gerektigini comletion handler sayesinde duzenleriz
    // Escaping ile func icerisindeki islemler bittikten sonra calistirilacagi anlasilir
    // Result yapisi bize completion edilecek seyin success or fail durumlarini degerlendirebilmemiz icin hazir bir iceriktir. [Detayli bilgi icin result'a tikla documents oku :)]
    // Result icerisinde ne dondurulecekse <> icerisine yazmamiz gerekiyor
    // Currency'i bir array seklinde yazmamizin sebebi url 'deki json formatindan swift'e cevirdigimiz verinin bir dizi icerisinde yer almasindan dolayidir. Yani liste icerisindeydi json verilerimiz biz de onu belirttik.
    func downloadCurrenties(url: URL, completionHandler: @escaping (Result<[Crypto], CryptoError>) -> Void ) {
        // URLSession, (datatask ile) veri istegi yaptigimizda url'ye istek atar ve cevap geldikten sonra yapilacak islemleri burada yazmamiza olanak saglar
        URLSession.shared.dataTask(with: url) { data, response, error in
            // Response -cevap- geldikten sonra bu blok calisir
            
            if let error = error {
                completionHandler(.failure(.serverError))
                // Eger hata yoksa bir data donmus demektir
            } else if let data = data {
                
                // Do catch yapmamizin amaci bizim Crypto modelini yanlis yazmamiz olasiliginda uygulamayi cokmekten kurtarmak icin swift'in kendi uyarisi sonucu ekledik
                do {
                    // .decode sonrasinda parantez icerisinde neye gore decode edilecegi sorulur bize, biz de crypto dizisine gore decode edilecegini soyleriz
                    let cryptoList = try? JSONDecoder().decode([Crypto].self, from: data)
                    // cryptoList optionaldan kurtarmak icin if let yapisini kullanabiliriz
                    if let cryptoList = cryptoList {
                        completionHandler(.success(cryptoList))
                        // eger bir onceki if let blogu calismazsa veri gelmesine ragmen ben bu  datayi alamadim demektir, yine completionHandler cagirarak fail durumunu verip parsing'de sorun yasadigimizi belirtebiliriz
                    } else {
                        completionHandler(.failure(.parsingError))
                    }
                }
            }
        // UrlSession bitiminde resume etmezsek hicbir zaman calismaz unutmamamiz gereken bir durumdur
        }.resume()
    }
}
