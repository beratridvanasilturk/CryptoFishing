//
//  ViewController.swift
//  CryptoFishing
//
//  Created by Berat Rıdvan Asiltürk on 3.09.2023.
//

import UIKit
import RxCocoa
import RxSwift

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: -Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    
    //MARK: -Variables
    var cryptoList = [Crypto]()
    let cryptoViewModel = CryptoViewModel()
    
    // setupBindings func icerisindeki datalarin cok fazla yer kaplamamasi hafizadan silinmesi icin bir cop kutusu anlaminda kullanilir
    let disposeBag = DisposeBag()
    
    //MARK: -Funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        setupBindings()
        cryptoViewModel.requestData()

    }
    
    private func setupBindings() {
            
        // Sirasiyla 1: Error icin atamalari gerceklestirecegiz
        // 2: Main.async'da islemlerin yurutulmesi gerektigini soyledik
        // 3: Subscribe oldugumuz yerden verileri nereye atamamiz gerekiyorsa orada gosteririz (ui veya consol)
        // 4: Dispose ile ram'i temizler datalari gereksiz tutmayiz
        cryptoViewModel
            .error
            .observe(on: MainScheduler.asyncInstance)
            .subscribe { errorString in
                // Bunun icerisinde bir label'a mi yoksa print seklinde mi islemleri yazdirmak istiyorsak yazdirabiliriz
                print(errorString)
            }.disposed(by: disposeBag)
            // dipose bag'e atarak ramda yer tutmamasini saglariz
        
        cryptoViewModel
            .cryptos
            .observe(on: MainScheduler.asyncInstance)
            .subscribe { ourCryptoList in
                self.cryptoList = ourCryptoList
                self.tableView.reloadData()
            }.disposed(by: disposeBag)
        
        // Binding : Cok komplike olmayan ve cok kullanilan toollar icin az kod satiriyla cok is yapabilecegimiz bir model ile ui'i binding etmeye yarar
        
        // .bind icerisindeki to: ile veri true geldiyse true'ya false geldiyse otomatikman false'a cevirir. Boylelikle ViewModel'den ne gelirse gelsin onu indicatorView icerisinde uygulamaya baslar
        cryptoViewModel
            .loading
            .bind(to: self.indicatorView.rx.isAnimating)
            .disposed(by: disposeBag)
        
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

