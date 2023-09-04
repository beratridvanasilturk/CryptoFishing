//
//  ViewController.swift
//  CryptoFishing
//
//  Created by Berat Rıdvan Asiltürk on 3.09.2023.
//

import UIKit



class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: -Variables
    var cryptoList : [Crypto]()
    //MARK: -Outlets
    @IBOutlet weak var tableView: UITableView!
    //MARK: -Funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        let url = URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json")!
        WebService().downloadCurrenties(url: url) { result in
            switch result {
            case .success(let cryptos):
                print(cryptos)
            case .failure(let failure):
                print(failure)
            }
        }
        
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var content = cell.defaultContentConfiguration()
        // Modelleri kullanarak currency ve price'larini cektik
        content.text = cryptoList[IndexPath.row].currency
        content.secondaryText = cryptoList[IndexPath.row].price
        cell.contentConfiguration = content
        return cell
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cryptoList.count
    }
}

