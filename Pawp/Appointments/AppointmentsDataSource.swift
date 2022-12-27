//
//  AppointmentsDataSource.swift
//  Pawp
//
//  Created by Nathan Pabrai on 12/26/22.
//

import Foundation

// TODO: We can implement a local persistence layer and share the persisted data while new data is fetched
@MainActor
class AppointmentsDataSource {
    static let appointmentsURL = URL(string: "https://interview.pawp.workers.dev/appointment/")!
    lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        return dateFormatter
    }()
    
    enum FetchState {
        case uninitiated
        case fetching
        case fetched(appointments:[Appointment])
        case error(description: String?)
    }
    
    @Published
    var fetchState: FetchState = .uninitiated
    
    private var dataTask: URLSessionDataTask?
    
    func fetch() {
        switch fetchState {
        case .uninitiated, .fetched(_), .error:
            dataTask?.cancel()
            fetchState = .fetching
            requestAppointmentsFromNetwork()
        case .fetching:
            // We are already fetching so don't refetch
            return
            
        }
    }
    
    private func requestAppointmentsFromNetwork() {
        dataTask = URLSession.shared.dataTask(with: Self.appointmentsURL) { data, response, error in
            if let data = data {
                DispatchQueue.main.async {
                    self.handleDataFetched(data)
                }
            }
            if let error = error {
                DispatchQueue.main.async {
                    self.fetchState = .error(description: error.localizedDescription)
                }
            }
        }
        dataTask?.resume()
    }
    
    private func handleDataFetched(_ data: Data) {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        do {
            let decoded = try decoder.decode(AppointmentNetworkResponse.self, from: data)
            // Sort appointments since they are undordered
            let appointments = decoded.appointments.sorted(by: { first, second in
                first.status.timeAgoFor(appointment: first) > second.status.timeAgoFor(appointment: second)})
            fetchState = .fetched(appointments: appointments)
        }
        catch {
            self.fetchState = .error(description: "Error decoding")
        }
    }
}
