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
    let cryptoViewModel = CryptoViewModel()
    
    //MARK: -Funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        cryptoViewModel.requestData()

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

