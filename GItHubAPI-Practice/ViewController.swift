//
//  ViewController.swift
//  GItHubAPI-Practice
//
//  Created by 大西玲音 on 2021/10/28.
//

import UIKit

final class ViewController: UIViewController {
    
    @IBOutlet private weak var iconImageView: UIImageView!
    @IBOutlet private weak var searchTextField: UITextField!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var tableView: UITableView!
    
    private var userRepos = [(name: String, commit: Int)]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.register(CustomTableViewCell.nib,
                           forCellReuseIdentifier: CustomTableViewCell.identifier)
        searchTextField.delegate = self
        searchTextField.text = "Reon0429-cat"
        
    }
    
    private func searchUserRepository(userName: String) {
        APIClient().searchUser(userName: userName) { result in
            switch result {
                case .success(let user):
                    DispatchQueue.main.async {
                        self.nameLabel.text = user.name
                        let url = URL(string: user.avatarUrl)
                        let data = try! Data(contentsOf: url!)
                        self.iconImageView.image = UIImage(data: data)
                        self.searchUserRepositories(userName: userName)
                    }
                case .failure(let message):
                    print("DEBUG_PRINT: ", message)
            }
        }
    }
    
    private func searchUserRepositories(userName: String) {
        APIClient().searchUserRepositories(userName: userName) { result in
            switch result {
                case .success(let repositories):
                    DispatchQueue.main.async {
                        for repository in repositories {
                            self.searchUserRepositoriesCommit(userName: userName,
                                                              repositoryName: repository.name)
                        }
                    }
                case .failure(let message):
                    print("DEBUG_PRINT: ", message)
            }
        }
    }
    
    private func searchUserRepositoriesCommit(userName: String,
                                              repositoryName: String) {
        APIClient().searchUserRepositoriesCommitsCount(userName: userName,
                                                       repositoryName: repositoryName) { result in
            switch result {
                case .success(let commitCount):
                    DispatchQueue.main.async {
                        self.userRepos.append((
                            name: repositoryName,
                            commit: commitCount
                        ))
                        self.tableView.reloadData()
                    }
                case .failure(let message):
                    print("DEBUG_PRINT: ", message)
            }
        }
    }
    
}

extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text else { return false }
        searchUserRepository(userName: text)
        textField.endEditing(true)
        return true
    }
    
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        userRepos.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: CustomTableViewCell.identifier
        ) as! CustomTableViewCell
        let repo = userRepos[indexPath.row]
        cell.configure(name: repo.name, commitCount: repo.commit)
        return cell
    }
    
}
