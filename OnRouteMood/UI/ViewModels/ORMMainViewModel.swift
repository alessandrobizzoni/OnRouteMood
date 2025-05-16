//
//  ORMMainViewModel.swift
//  OnRouteMood
//
//  Created by Alessandro Bizzoni on 14/5/25.
//

import Foundation
import Combine

import CoreLocation

class ORMMainViewModel: ObservableObject {
    
    private var ormInteractor: ORMInteractor
    
    private var cancellable: Set<AnyCancellable> = Set<AnyCancellable>()
    
    @Published var allTrips: [DomainTrips] = []
    
    @Published var beError: Bool = false
    
    @Published var completedForms: [ORMBugReport] = []
    
    init(ormInteractor: ORMInteractor) {
        self.ormInteractor = ormInteractor
    }
    
    var sortedTrips: [DomainTrips] {
        let order: [TripStatus] = [.ongoing, .scheduled, .finalized, .cancelled]
        return allTrips.sorted {
            guard let firstIndex = order.firstIndex(of: $0.status),
                  let secondIndex = order.firstIndex(of: $1.status) else {
                return false
            }
            return firstIndex < secondIndex
        }
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
                    print("[DEBUG] " + error.localizedDescription)
                }
            } receiveValue: { [weak self] newValue in
                self?.allTrips = newValue
                self?.beError = false
            }
            .store(in: &cancellable)
        
    }
    
    // MARK: - Local Storage
    
    func saveForm(
        firstName: String,
        surname: String,
        email: String,
        phone: String,
        date: Date,
        description: String
    ) {
        let report = ORMBugReport(
            firstName: firstName,
            surname: surname,
            email: email,
            phone: phone,
            date: date,
            description: description
        )
        
        completedForms.append(report)
        
        if let data = try? JSONEncoder().encode(completedForms) {
            UserDefaults.standard.set(data, forKey: "bug_reports")
        }
    }
    
    func loadReports() {
        guard let data = UserDefaults.standard.data(forKey: "bug_reports"), let decoded = try? JSONDecoder().decode([ORMBugReport].self, from: data) else { return }
        self.completedForms = decoded
    }
}
