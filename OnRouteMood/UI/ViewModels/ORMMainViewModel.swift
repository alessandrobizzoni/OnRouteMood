//
//  ORMMainViewModel.swift
//  OnRouteMood
//
//  Created by Alessandro Bizzoni on 14/5/25.
//

import Foundation
import Combine

class ORMMainViewModel: ObservableObject {
    
    private var ormInteractor: ORMInteractor
    
    private var cancellable: Set<AnyCancellable> = Set<AnyCancellable>()
    
    @Published var allTrips: [DomainTrips] = []
    
    @Published var beError: Bool = false
    
    init(ormInteractor: ORMInteractor) {
        self.ormInteractor = ormInteractor
    }
    
    func getTrips() {
        ormInteractor.getTrips()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    return
                    
                case .failure(let error):
                    self?.beError = true
                }
            } receiveValue: { [weak self] newValue in
                self?.allTrips = newValue
                self?.beError = false
            }
            .store(in: &cancellable)

    }
    
}
