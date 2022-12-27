//
//  AppointmentTableViewCell.swift
//  Pawp
//
//  Created by Nathan Pabrai on 12/27/22.
//

import UIKit

protocol AppointmentCellListener: AnyObject {
    func removeAppointmentWith(id: String)
}

class AppointmentTableViewCell: UITableViewCell {
    weak var listener: AppointmentCellListener?
    let green = UIColor(red: 0.106, green: 0.698, blue: 0.451, alpha: 1)
    let blue = UIColor(red: 0.165, green: 0.447, blue: 0.831, alpha: 1)
    let orange = UIColor(red: 0.953, green: 0.455, blue: 0.357, alpha: 1)
    let grey = UIColor(red: 0.055, green: 0.078, blue: 0.173, alpha: 0.16)
    let textDark = UIColor.black.withAlphaComponent(0.9)
    let textLight = UIColor.black.withAlphaComponent(0.64)
    var currentID: String?
    lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.font = Font.objectiveBold.uifont.withSize(11)
        return label
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = Font.objectiveMedium.uifont.withSize(14)
        label.textColor = textDark
        return label
    }()
    
    
    let topHStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 12
        stackView.alignment = .center
        return stackView
    }()
    
    let nameVStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    let dotView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 4
        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(equalToConstant: 8),
            view.heightAnchor.constraint(equalToConstant: 8)
        ])
        return view
    }()
    
    lazy var initiatedIconView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "icon-notification"))
        
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 32),
            imageView.widthAnchor.constraint(equalToConstant: 32)
        ])
        return imageView
    }()
    
    lazy var requestedIconView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "icon-request"))
        
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 32),
            imageView.widthAnchor.constraint(equalToConstant: 32)
        ])
        return imageView
    }()
    
    lazy var avatarView: UILabel = {
        let label = UILabel()
        label.font = Font.objectiveBold.uifont.withSize(11)
        label.backgroundColor = orange
        NSLayoutConstraint.activate([
            label.heightAnchor.constraint(equalToConstant: 32),
            label.widthAnchor.constraint(equalToConstant: 32)
        ])
        label.layer.cornerRadius = 16
        label.clipsToBounds = true
        label.textAlignment = .center
        return label
    }()
    
    lazy var detailsLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        return label
    }()
    
    lazy var joinButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 17
        button.titleLabel?.font = Font.objectiveBold.uifont.withSize(12)
        button.titleLabel?.textColor = .white
        button.setTitle("Join Appointment", for: .normal)
        button.backgroundColor = green
        NSLayoutConstraint.activate([
            button.heightAnchor.constraint(equalToConstant: 34),
            button.widthAnchor.constraint(equalToConstant: 173)
        ])
        return button
    }()
    
    lazy var acceptButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 17
        button.titleLabel?.font = Font.objectiveBold.uifont.withSize(12)
        button.titleLabel?.textColor = grey
        button.backgroundColor = .lightGray
        button.setTitle("Accept", for: .normal)
        button.backgroundColor = blue
        button.addTarget(self, action: #selector(removeAppointment), for: .touchUpInside)
        NSLayoutConstraint.activate([
            button.heightAnchor.constraint(equalToConstant: 34),
            button.widthAnchor.constraint(equalToConstant: 113)
        ])
        return button
    }()
    
    lazy var declineButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 17
        button.titleLabel?.font = Font.objectiveBold.uifont.withSize(12)
        button.setTitleColor(textLight, for: .normal)
        button.setTitle("Decline", for: .normal)
        button.backgroundColor = grey
        button.addTarget(self, action: #selector(removeAppointment), for: .touchUpInside)
        NSLayoutConstraint.activate([
            button.heightAnchor.constraint(equalToConstant: 34),
            button.widthAnchor.constraint(equalToConstant: 113)
        ])
        return button
    }()
    
    
    lazy var buttonStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [joinButton])
        stackView.axis = .horizontal
        stackView.spacing = 8
        return stackView
    }()
    
    lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = textDark
        label.font = Font.objectiveMedium.uifont.withSize(11)
        return label
    }()
    
    lazy var divider: UIView = {
        let view = UIView()
        view.backgroundColor = grey
        return view
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubviewIgnoringAutoresizingMask(topHStack)
        contentView.addSubviewIgnoringAutoresizingMask(timeLabel)
        contentView.addSubviewIgnoringAutoresizingMask(detailsLabel)
        contentView.addSubviewIgnoringAutoresizingMask(buttonStack)
        contentView.addSubviewIgnoringAutoresizingMask(divider)
        topHStack.addArrangedSubview(dotView)
        topHStack.addArrangedSubview(initiatedIconView)
        topHStack.addArrangedSubview(nameVStack)
        nameVStack.addArrangedSubview(statusLabel)
        nameVStack.addArrangedSubview(nameLabel)
        buttonStack.addArrangedSubview(joinButton)
        
        NSLayoutConstraint.activate([
            topHStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 17),
            topHStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 18),
            topHStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 16),
            timeLabel.centerYAnchor.constraint(equalTo: topHStack.centerYAnchor, constant: 0),
            timeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            topHStack.bottomAnchor.constraint(equalTo: detailsLabel.topAnchor, constant: -10),
            detailsLabel.leadingAnchor.constraint(equalTo: nameVStack.leadingAnchor),
            detailsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -33),
            buttonStack.topAnchor.constraint(equalTo: detailsLabel.bottomAnchor, constant: 12),
            buttonStack.leadingAnchor.constraint(equalTo: nameVStack.leadingAnchor, constant: 0),
            divider.topAnchor.constraint(equalTo: buttonStack.bottomAnchor, constant: 12),
            divider.trailingAnchor.constraint(equalTo: topHStack.trailingAnchor, constant: 0),
            divider.heightAnchor.constraint(equalToConstant: 1),
            divider.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0)
        ])
    }
    
    func configure(appointment: Appointment) {
        currentID = appointment.id
        timeLabel.text = timeTextFor(date: appointment.status.timeAgoFor(appointment: appointment))
        nameLabel.text = "\(appointment.professional.firstName) \(appointment.professional.lastName)"
        
        switch appointment.status {
        case .initiated, .requested:
            dotView.alpha = 1.0
            removeStackviewSubviews(stackView: nameVStack)
            nameVStack.addArrangedSubview(statusLabel)
            nameVStack.addArrangedSubview(nameLabel)
            
            removeStackviewSubviews(stackView: topHStack)
            topHStack.addArrangedSubview(dotView)
            

            removeStackviewSubviews(stackView: buttonStack)
            if case .initiated = appointment.status {
                dotView.backgroundColor = green
                buttonStack.addArrangedSubview(joinButton)
                topHStack.addArrangedSubview(initiatedIconView)

                statusLabel.text = "Starting soon"
                statusLabel.textColor = green
                
                detailsLabel.attributedText = detailsAttributedStringFor(string: "Your appointment with \(appointment.professional.firstName) begins \(timeFromNowFor(date: appointment.startTime))")
            }
            if case .requested = appointment.status {
                dotView.backgroundColor = blue
                buttonStack.addArrangedSubview(acceptButton)
                buttonStack.addArrangedSubview(declineButton)
                topHStack.addArrangedSubview(requestedIconView)

                statusLabel.text = "Request to book"
                statusLabel.textColor = blue
                
                let details = NSMutableAttributedString(attributedString: detailsAttributedStringFor(string: "\(appointment.professional.firstName) has requested an appointment on\n"))
                
                details.append(detailsBoldAttributedStringFor(string: appointmentTimeTextFor(date: appointment.startTime)))
                detailsLabel.attributedText = details
                
            }
            topHStack.addArrangedSubview(nameVStack)
            NSLayoutConstraint.activate([
                detailsLabel.leadingAnchor.constraint(equalTo: nameVStack.leadingAnchor, constant: 0),
                buttonStack.leadingAnchor.constraint(equalTo: nameVStack.leadingAnchor, constant: 0),
                divider.leadingAnchor.constraint(equalTo: nameVStack.leadingAnchor, constant: 0),
                
            ])
            
        case .completed, .active:
            
            removeStackviewSubviews(stackView: nameVStack)
            nameVStack.addArrangedSubview(nameLabel)
            
            removeStackviewSubviews(stackView: topHStack)
            topHStack.addArrangedSubview(dotView)
            topHStack.addArrangedSubview(avatarView)
            if let first = appointment.professional.firstName.first,
               let second = appointment.professional.lastName.first {
                avatarView.text = "\(String(first) + String(second))"
            }
            
            
            if case .completed = appointment.status {
                dotView.alpha = 0
                avatarView.backgroundColor = grey
                avatarView.textColor = textDark
                detailsLabel.attributedText = detailsAttributedStringFor(string: "This conversation has ended.")
            }
            if case .active = appointment.status {
                dotView.backgroundColor = blue
                dotView.alpha = 1.0
                avatarView.backgroundColor = orange
                avatarView.textColor = .white
                detailsLabel.attributedText = detailsAttributedStringFor(string: appointment.lastMessage ?? "No messages.")
            }
            topHStack.addArrangedSubview(nameVStack)
            NSLayoutConstraint.activate([
                detailsLabel.leadingAnchor.constraint(equalTo: nameVStack.leadingAnchor, constant: 0),
                divider.leadingAnchor.constraint(equalTo: nameVStack.leadingAnchor, constant: 0),
            ])
            
            removeStackviewSubviews(stackView: buttonStack)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        currentID = nil
    }
    
    @objc func removeAppointment() {
        guard let currentID = currentID else { return }
        listener?.removeAppointmentWith(id: currentID)
    }
    
    private func timeFromNowFor(date: Date)-> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .short
        return formatter.localizedString(for: date, relativeTo: .now)
    }
    
    private func timeTextFor(date: Date)-> String {
        let formatter = DateFormatter()
        if Calendar.current.isDateInToday(date) {
            formatter.dateFormat = "h:mm a"
        } else {
            formatter.dateFormat = "MMM d, h:mm a"
        }
        return formatter.string(for: date) ?? "N/A"
    }
    
    private func appointmentTimeTextFor(date: Date)-> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "E, MMM d @ h:mm a"
        return formatter.string(from: date)
    }
    
    private func removeStackviewSubviews(stackView: UIStackView) {
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
    }
    
    private func detailsAttributedStringFor(string: String) -> NSAttributedString {
        let paragraphStyle =  NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.75
        return NSAttributedString(string: string,
                                  attributes: [.font: Font.objectiveRegular.uifont.withSize(12),
                                               .foregroundColor: textLight,
                                               .paragraphStyle: paragraphStyle])
    }
    
    private func detailsBoldAttributedStringFor(string: String) -> NSAttributedString {
        let paragraphStyle =  NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.75
        return NSAttributedString(string: string,
                                  attributes: [.font: Font.objectiveBold.uifont.withSize(12),
                                               .foregroundColor: textLight,
                                               .paragraphStyle: paragraphStyle])
    }
}
