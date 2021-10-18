//
//  AbbrivationHomePage.swift
//  AppleLogin
//
//  Created by Codigo Technologies on 15/10/21.
//

import UIKit
typealias tableViewDelegate = UITableViewDataSource&UITableViewDelegate

class AbbrivationHomePage: UIViewController {
    var spinner:UIActivityIndicatorView!
    
     var viewModal:AbrivationHomeViewModal!
    @IBOutlet weak var abbrivationTextFields: UITextField!
    @IBOutlet weak var abbrivationListsTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModal = AbrivationHomeViewModal()
        // Do any additional setup after loading the view.
        abbrivationListsTableView.separatorStyle = .singleLine
        abbrivationTextFields.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        abbrivationTextFields.addTarget(self, action: #selector(searchAction), for: .editingChanged)
        abbrivationListsTableView.delegate = self
        abbrivationListsTableView.dataSource = self
        spinner = UIActivityIndicatorView(frame: CGRect(x: 200, y: 0, width: 40, height: 40))
        spinner.style = .gray
        spinner.isHidden = true
        abbrivationTextFields.rightView = spinner
        abbrivationTextFields.rightViewMode = .whileEditing
        self.abbrivationListsTableView.isHidden = true
        self.abbrivationListsTableView.tableFooterView = UIView()
    }
    
    @objc func searchAction(_ textField:UITextField) {
        spinner.isHidden = false
        spinner.startAnimating()
        viewModal.callAbbrivationAPI(textField.text ?? "") { isShowTableView in
            DispatchQueue.main.async {
                self.spinner.stopAnimating()
                self.spinner.isHidden = true
                self.abbrivationListsTableView.isHidden = !isShowTableView
                self.abbrivationListsTableView.reloadData()
            }
           
        }
    }
  

}


//MARK:- TableView Delegate and Datasource
extension AbbrivationHomePage:tableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModal.numberOfSearchedItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "SearchListCell")
        let searchedDic = viewModal.getSearchedItem(indexPath)
        cell.textLabel?.text = (searchedDic.lf ?? "").capitalized
        cell.textLabel?.adjustsFontSizeToFitWidth = true
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    
}
