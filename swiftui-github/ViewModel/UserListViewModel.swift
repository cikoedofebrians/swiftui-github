//
//  UserListViewModel.swift
//  swiftui-github
//
//  Created by Ciko Edo Febrian on 29/09/23.
//

import Foundation
import Combine

class UserListViewModel: ObservableObject {
    @Published var userList: [User] = [User]()
    @Published var isError: Bool = false
    @Published var errorMessage : String  = ""

    var fetchDataSubjects = PassthroughSubject<Int, Never>()
    
    private var cancellables = Set<AnyCancellable>()
    private var currentLastId: Int? = nil
    
    init() {
        fetchData()
        fetchDataSubjects.send(10)
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
//            self.errorMessage = "Real"
//            self.isError = true
//        }
    }
    
    
    func dismissError() {
        isError = false
        errorMessage = ""
    }
    
    func fetchData() {
        fetchDataSubjects
            .print()
            .flatMap { [weak self] _ in
                APIService.shared.getUsers(since: self?.currentLastId)
            }
            .sink { [weak self] result in
                switch result {
                case .finished :
                    print("Data sucessfully fetched.")
                case .failure(let error):
                    self?.isError = true
                    switch error {
                    case APIError.invalidResponse:
                        self?.errorMessage = "Invalid Response"
                    case APIError.dataNotFound:
                        self?.errorMessage = "Data Not Found"
                    default:
                        self?.errorMessage = "Something Went Wrong"
                    }
                }
            } receiveValue: { users in
                DispatchQueue.main.async { [weak self] in
                    self?.userList.append(contentsOf: users)
                }
            }
            .store(in: &cancellables)
    }
}
