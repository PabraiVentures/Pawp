//
//  AppointmentModel.swift
//  Pawp
//
//  Created by Nathan Pabrai on 12/26/22.
//

import Foundation

enum AppointmentStatus: String, Codable {
    case requested = "REQUESTED"
    case completed = "COMPLETED"
    case initiated = "INITIATED"
    case active = "ACTIVE"
    
    func timeAgoFor(appointment: Appointment) -> Date {
        // Todo error handling if expected time isnt present
        switch self {
        case .active:
            return appointment.lastMessageAt ?? appointment.requestedAt
        case .completed:
            return appointment.lastMessageAt ?? appointment.endTime
        case .initiated:
            return appointment.lastMessageAt ?? appointment.startTime
        case .requested:
            return appointment.requestedAt
        }
    }
}

struct AppointmentNetworkResponse: Codable {
    var appointments: [Appointment]
}

struct Appointment: Codable {
    var id: String
    var professional: Professional
    var lastMessageAt: Date?
    var lastMessage: String?
    var requestedAt: Date
    var startTime: Date
    var endTime: Date
    var status: AppointmentStatus
}

struct Professional: Codable {
    var firstName: String
    var lastName: String
}
