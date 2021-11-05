//
//  APIClient.swift
//  GItHubAPI-Practice
//
//  Created by 大西玲音 on 2021/10/29.
//

import Foundation

enum Result<Success, Failure> {
    case success(Success)
    case failure(Failure)
}

typealias ResultHandler<T> = (Result<T, String>) -> Void

final class APIClient {
    
    func searchUser(userName: String,
                    completion: @escaping ResultHandler<User>) {
        let urlString = "https://api.github.com/users/\(userName)"
        guard let url = URL(string: urlString) else {
            completion(.failure("url見つからない"))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                completion(.failure("dataがnil"))
                return
            }
            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            let user = try! jsonDecoder.decode(User.self, from: data)
            completion(.success(user))
        }
        task.resume()
    }
    
    func searchUserRepositories(userName: String,
                                completion: @escaping ResultHandler<[UserRepository]>) {
        let urlString = "https://api.github.com/users/\(userName)/repos"
        guard let url = URL(string: urlString) else {
            completion(.failure("url見つからない"))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                completion(.failure("dataがnil"))
                return
            }
            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            let userRepositories = try! jsonDecoder.decode([UserRepository].self, from: data)
            completion(.success(userRepositories))
        }
        task.resume()
    }
    
    func searchUserRepositoriesCommitsCount(userName: String,
                                            repositoryName: String,
                                            completion: @escaping ResultHandler<Int>) {
        let urlString = "https://api.github.com/repos/\(userName)/\(repositoryName)/commits"
        print("DEBUG_PRINT: ", urlString)
        guard let url = URL(string: urlString) else {
            completion(.failure("url見つからない"))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                completion(.failure("dataがnil"))
                return
            }
            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            let userCommits = try! jsonDecoder.decode([UserCommit].self, from: data)
            completion(.success(userCommits.count))
        }
        task.resume()
    }
    
}

let userJson = """
{
    "avatar_url": "https://avatars.githubusercontent.com/u/66917548?v=4",
    "name": "OONISHI REON"
}
"""
    .data(using: .utf8)!

let repositoryJson = """
[
    {
        "name": "repo1"
    },
    {
        "name": "repo2"
    },
    {
        "name": "repo3"
    }
]
"""
    .data(using: .utf8)!

let commitJson = """
[
    {
        "commit": {
            "author": {
                "date": "2021-10-28 21:42:29 +0000"
            }
        }
    },
    {
        "commit": {
            "author": {
                "date": "2021-10-29 21:42:29 +0000"
            }
        }
    },
    {
        "commit": {
            "author": {
                "date": "2021-10-30 21:42:29 +0000"
            }
        }
    },
    {
        "commit": {
            "author": {
                "date": "2021-11-28 21:42:29 +0000"
            }
        }
    },
    {
        "commit": {
            "author": {
                "date": "2021-11-28 21:42:29 +0000"
            }
        }
    },
    {
        "commit": {
            "author": {
                "date": "2021-12-28 21:42:29 +0000"
            }
        }
    },
    {
        "commit": {
            "author": {
                "date": "2021-10-28 21:42:29 +0000"
            }
        }
    },
    {
        "commit": {
            "author": {
                "date": "2021-10-31 21:42:29 +0000"
            }
        }
    },
    {
        "commit": {
            "author": {
                "date": "2021-10-31 21:42:29 +0000"
            }
        }
    }
]
""".data(using: .utf8)!

let commitJson2 = """
[
    {
        "commit": {
            "author": {
                "date": "2021-11-28 21:42:29 +0000"
            }
        }
    },
    {
        "commit": {
            "author": {
                "date": "2021-11-28 21:42:29 +0000"
            }
        }
    },
    {
        "commit": {
            "author": {
                "date": "2021-12-28 21:42:29 +0000"
            }
        }
    },
    {
        "commit": {
            "author": {
                "date": "2021-10-28 21:42:29 +0000"
            }
        }
    },
    {
        "commit": {
            "author": {
                "date": "2021-10-31 21:42:29 +0000"
            }
        }
    },
    {
        "commit": {
            "author": {
                "date": "2021-10-31 21:42:29 +0000"
            }
        }
    }
]
""".data(using: .utf8)!

let commitJson3 = """
[
    {
        "commit": {
            "author": {
                "date": "2021-10-28 21:42:29 +0000"
            }
        }
    },
    {
        "commit": {
            "author": {
                "date": "2021-10-29 21:42:29 +0000"
            }
        }
    },
    {
        "commit": {
            "author": {
                "date": "2021-10-30 21:42:29 +0000"
            }
        }
    },
    {
        "commit": {
            "author": {
                "date": "2021-11-28 21:42:29 +0000"
            }
        }
    },
    {
        "commit": {
            "author": {
                "date": "2021-12-28 21:42:29 +0000"
            }
        }
    },
    {
        "commit": {
            "author": {
                "date": "2021-10-28 21:42:29 +0000"
            }
        }
    },
    {
        "commit": {
            "author": {
                "date": "2021-10-31 21:42:29 +0000"
            }
        }
    },
    {
        "commit": {
            "author": {
                "date": "2021-10-31 21:42:29 +0000"
            }
        }
    }
]
""".data(using: .utf8)!
