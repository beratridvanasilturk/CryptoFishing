//
//  ViewController.swift
//  CryptoFishing
//
//  Created by Berat Rıdvan Asiltürk on 3.09.2023.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: -Outlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: -Variables
    var cryptoList = [Crypto]()
    
    //MARK: -Funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        let url = URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json")!
        WebService().downloadCurrenties(url: url) { result in
            switch result {
            case .success(let cryptos):
                self.cryptoList = cryptos
                // UrlSession kendisi arka planda global thread'da atadigi icin hatanin giderilmesi icin main'e almamiz lazim
                // Main thread kullanici arayuzu ile etkilesim yapma anlamina gelir
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            case .failure(let failure):
            print(failure)
            }
        }
        
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var content = cell.defaultContentConfiguration()
        // Modelleri kullanarak currency ve price'larini cektik
        content.text = cryptoList[indexPath.row].currency
        content.secondaryText = cryptoList[indexPath.row].price
        cell.contentConfiguration = content
        return cell
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cryptoList.count
    }
}

