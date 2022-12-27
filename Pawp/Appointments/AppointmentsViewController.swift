//
//  AppointmentsViewController.swift
//  Pawp
//
//  Created by Nathan Pabrai on 12/26/22.
//

import Combine
import UIKit

class AppointmentsViewController: UIViewController, HeaderDisplaying {
    var headerText = "Appointments"
    static let reuseID = "AppointmentsVCTableviewCell"
    var dataSource = AppointmentsDataSource()
    var latestAppointments = [Appointment]() {
        didSet {
            //TODO: Check for empty state and add empty state UI.
            tableView.reloadData()
        }
    }
    var dataSourceCancellable: AnyCancellable?
    var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        setupViews()
        setupDataSource()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        dataSource.fetch()
    }
    
    private func setupViews() {
        view.addSubviewIgnoringAutoresizingMask(tableView)
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: RootViewController.headerHeight),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsSelection = false
        tableView.register(AppointmentTableViewCell.self, forCellReuseIdentifier: Self.reuseID)
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    private func setupDataSource() {
        dataSourceCancellable = dataSource.$fetchState.sink { fetchState in
            switch fetchState {
            case .fetched(let appointments):
                print("fetched appointments \(appointments)")
                self.latestAppointments = appointments
            case .error(let description):
                print("error fetching appointments \(String(describing: description))")
            case .fetching:
                //TODO: Add loader
                print("fetching")
            case .uninitiated:
                return
            }
        }
    }
}

extension AppointmentsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Self.reuseID, for: indexPath) as? AppointmentTableViewCell else {
            return UITableViewCell()
        }
        let appointment = latestAppointments[indexPath.row]
        cell.configure(appointment: appointment)
        cell.listener = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension AppointmentsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return latestAppointments.count
    }
}

extension AppointmentsViewController: AppointmentCellListener {
    func removeAppointmentWith(id: String) {
        latestAppointments = latestAppointments.filter{ $0.id != id }
    }
}
