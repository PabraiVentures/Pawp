//
//  ViewController.swift
//  Pawp
//
//  Created by Nathan Pabrai on 12/26/22.
//

import UIKit

protocol HeaderDisplaying {
    var headerText: String { get }
}

class RootViewController: UITabBarController {
    static let headerHeight: CGFloat = 65
    lazy var header: UIStackView = {
        //TODO: Make tappable
        let stackView = UIStackView(arrangedSubviews: [titleIcon ,titleLabel])
        stackView.spacing = 16
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.backgroundColor = .white
        stackView.clipsToBounds = false
    
        return stackView
    }()
    
    lazy var headerBackground: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
        
    lazy var titleIcon: UIView = {
        let titleImage = UIImage(named: "icon-open_tab")!
        let imageView = UIImageView(image: titleImage)
        let container = UIView()
        container.addSubviewIgnoringAutoresizingMask(imageView)
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 16),
            container.widthAnchor.constraint(equalTo: imageView.widthAnchor),
            container.heightAnchor.constraint(equalTo: imageView.heightAnchor, constant: 4)
        ])
        return container
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.133, green: 0.133, blue: 0.133, alpha: 1)
        label.font = Font.objectiveBold.uifont.withSize(20)
        label.text = "Unavailable"
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        setupViews()
        setupTabs()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubviewIgnoringAutoresizingMask(headerBackground)
        view.addSubviewIgnoringAutoresizingMask(header)
        NSLayoutConstraint.activate([
            header.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            header.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            header.heightAnchor.constraint(equalToConstant: Self.headerHeight),
            header.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerBackground.topAnchor.constraint(equalTo: view.topAnchor),
            headerBackground.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerBackground.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerBackground.bottomAnchor.constraint(equalTo: header.bottomAnchor)
        ])
        
        tabBar.backgroundColor = .white

    }
    
    private func setupTabs() {
        let prescriptionTabVC = UnavailableViewController()
        prescriptionTabVC.title = "Prescription"
        let prescriptionTabItem = UITabBarItem(title: nil,
                                               image: UIImage(named: "icon-rx"),
                                               selectedImage: UIImage(named: "icon-rx")?.withTintColor(.blue, renderingMode: .alwaysTemplate))
        prescriptionTabVC.tabBarItem = prescriptionTabItem
        
        let appointmentsTabVC = AppointmentsViewController()
        let appointmentsTabItem = UITabBarItem(title: nil,
                                               image: UIImage(named: "icon-calendar"),
                                               selectedImage: UIImage(named: "icon-calendar")?.withTintColor(.blue, renderingMode: .alwaysTemplate))
        appointmentsTabVC.tabBarItem = appointmentsTabItem
        
        let paymentsTabVC = UnavailableViewController()
        paymentsTabVC.title = "Payments"
        let paymentsTabItem = UITabBarItem(title: nil,
                                               image: UIImage(named: "icon-payments"),
                                               selectedImage: UIImage(named: "icon-payments")?.withTintColor(.blue, renderingMode: .alwaysTemplate))
        paymentsTabVC.tabBarItem = paymentsTabItem
        
        let performanceTabVC = UnavailableViewController()
        performanceTabVC.title = "Performance"
        let performanceTabItem = UITabBarItem(title: nil,
                                               image: UIImage(named: "icon-performance"),
                                               selectedImage: UIImage(named: "icon-performance")?.withTintColor(.blue, renderingMode: .alwaysTemplate))
        performanceTabVC.tabBarItem = performanceTabItem
        
        viewControllers = [prescriptionTabVC, appointmentsTabVC, paymentsTabVC, performanceTabVC]
    }
    
    private func setTitleText(_ text: String?) {
        guard let text = text else {
            titleLabel.attributedText = nil
            return
        }
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 0.94
        titleLabel.attributedText = NSMutableAttributedString(string: text, attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }
}

extension RootViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if let headerDisplayingVC = viewController as? HeaderDisplaying
        {
            titleLabel.text = headerDisplayingVC.headerText
        } else {
            titleLabel.text = "Unavailable"
        }
    }
}
