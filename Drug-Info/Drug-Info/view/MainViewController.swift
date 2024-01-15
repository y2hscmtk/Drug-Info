//
//  ViewController.swift
//  Drug-Info
//
//  Created by Choi76 on 2024/01/15.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var searchTextFiled: UITextField!
    @IBOutlet weak var btnSearch: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setTableView()
    }
    
    // tableview init
    func setTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        
        // nib 등록
        tableView.register(UINib(nibName: "DrugTableViewCell", bundle: nil), forCellReuseIdentifier: DrugTableViewCell.identifier)
        
    }
    
    
    
}

extension MainViewController : UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DrugTableViewCell.identifier, for: indexPath) as? DrugTableViewCell else {
            return UITableViewCell()
        }
        return cell
    }
    
    
}

