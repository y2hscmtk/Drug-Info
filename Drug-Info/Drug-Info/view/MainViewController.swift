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
    
    // 검색 결과 알약 데이터
    var searchResult : [DrugItem] = []{
        didSet {
            tableView.reloadData() // 테이블 뷰 새로고침
        }
    }// 검색하기 전에는 빈 배열
    
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
    
    // 검색 버튼 클릭시 로직
    @IBAction func btnSearchDidTapped(_ sender: Any) {
        // 검색필드가 비어있는지 아닌지 검사
        if(searchTextFiled.text != ""){
            searchResult = [] // 이전 검색결과를 비운다(로딩 창을 띄우는동안 아무것도 보이지 않도록)
            // API로부터 데이터 요청
            let parameter = APIParameter(efcyQesitm: searchTextFiled.text!)
            print("paramete : \(parameter)")
            DrugAPI.shared.searchDrug(parameter,self)
        } else {
            print("내용이 비었습니다.")
        }
    }
    
}

// DrugAPI에서 데이터를 전달 받기 위함
extension MainViewController {
    func setSearchResultArray(searchResult : [DrugItem]){
        self.searchResult = searchResult
    }
}

extension MainViewController : UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DrugTableViewCell.identifier, for: indexPath) as? DrugTableViewCell else {
            return UITableViewCell()
        }
        // 셀을 찾는데 성공하였다면
        let drug = searchResult[indexPath.row]
        print("drugName : \(drug.itemName)")
        // 셀에 필요한 데이터 주입
        cell.drugName.text = drug.itemName
        cell.company.text = drug.entpName // 제조사 이름
        
        return cell
    }
    
    
}

