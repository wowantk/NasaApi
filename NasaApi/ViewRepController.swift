//
//  ViewRepController.swift
//  NasaApi
//
//  Created by macbook on 21.02.2021.
//

import UIKit

class ViewRepController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var fvc:ViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "TableViewResponseCell", bundle: nil), forCellReuseIdentifier: "TableViewResponseCell")
    }
    
    
}

extension ViewRepController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewResponseCell", for: indexPath) as? TableViewResponseCell{
            cell.setModel(with: repArr[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        fvc?.url = repArr[indexPath.row]
        fvc?.requestPage = 1
        self.dismiss(animated: true, completion: nil)
        DispatchQueue.main.async {
            self.fvc?.tablleView.reloadData()
        }
    }
}


