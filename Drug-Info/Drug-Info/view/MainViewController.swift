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
    
    var activityIndicator: UIActivityIndicatorView! // 검색결과를 기다리는 동안 띄울 로딩창
    
    // 검색 결과 알약 데이터
    var searchResult : [DrugItem] = []{
        didSet {
            tableView.reloadData() // 테이블 뷰 새로고침
        }
    }// 검색하기 전에는 빈 배열
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        btnSearch.layer.cornerRadius = 10
        setTableView()
        
        // 인디케이터 초기화 및 설정
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = self.view.center
        self.view.addSubview(activityIndicator)
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 네비게이션 바 숨기기
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // 다른 뷰로 이동할 때 네비게이션 바를 다시 보이게 설정
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
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
            // 인디케이터 시작
            activityIndicator.startAnimating()
            
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
        
        // 인디케이터 정지
        activityIndicator.stopAnimating()
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
        cell.drugName.text = drug.itemName // 알약 이름
        cell.company.text = drug.entpName // 제조사 이름
        
        // 이미지 설정하는 로직 작성
        if let link = drug.itemImage{
            cell.drugImage.imageDownload(link: link)
        }
        
        // 셀 선택 효과 없애기(회색배경)
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        
        return cell
    }
    
    // 알약 탭 클릭시 이벤트 정의
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        // 이동할 화면 찾기
        let drugInfoView = storyboard.instantiateViewController(
            identifier: "DrugInfoViewController") as! DrugInfoViewController
        
        // 알약 정보 삽입
        let drug = searchResult[indexPath.row]
        // drugInfoView에 데이터 전달
        drugInfoView.drug = drug
        
        // 화면 이동
        navigationController?.pushViewController(drugInfoView, animated: true)
    }
    
    
}

