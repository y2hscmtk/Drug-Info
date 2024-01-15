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
        
    }
    
    
    
}

extension MainViewController : UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
}

