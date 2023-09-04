//
//  AlertViewController.swift
//  iOS10-HW21-Bessonov Ilia
//
//  Created by i0240 on 02.09.2023.
//

import UIKit

class AlertViewController: UIViewController {

    private var alertTitle: String?
    private var message: String?
    private var buttonTitle: String?

    // MARK: - Outlets

    private lazy var conteinerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.clipsToBounds = true
        view.layer.cornerRadius = 16
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.white.cgColor
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .equalCentering
        stack.spacing = 10
        stack.setCustomSpacing(15, after: subtitleLabel)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.layoutMargins = UIEdgeInsets(top: 10, left: 0, bottom: 5, right: 0)
        stack.isLayoutMarginsRelativeArrangement = true
        stack.addArrangedSubview(titleLabel)
        stack.addArrangedSubview(subtitleLabel)
        stack.addArrangedSubview(button)
        return stack
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = alertTitle
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.alpha = 0.8
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = message
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemGray2
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    private lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        button.setTitle(buttonTitle, for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = .systemPink
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // MARK: - Initializers

    init(alertTitle: String? = nil, message: String? = nil, buttonTitle: String? = nil) {
        super.init(nibName: nil, bundle: nil)
        self.alertTitle = alertTitle
        self.message = message
        self.buttonTitle = buttonTitle
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75)
        setupHierarchy()
        setupLayout()
    }

    // MARK: - Setup

    private func setupHierarchy() {
        view.addSubview(conteinerView)
        conteinerView.addSubview(stackView)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            conteinerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            conteinerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            conteinerView.widthAnchor.constraint(equalToConstant: 280),
            conteinerView.heightAnchor.constraint(equalToConstant: 220),

            stackView.topAnchor.constraint(equalTo: conteinerView.topAnchor, constant: 15),
            stackView.leadingAnchor.constraint(equalTo: conteinerView.leadingAnchor, constant: 15),
            stackView.trailingAnchor.constraint(equalTo: conteinerView.trailingAnchor, constant: -15),
            stackView.bottomAnchor.constraint(equalTo: conteinerView.bottomAnchor, constant: -15),

            button.leadingAnchor.constraint(equalTo: conteinerView.leadingAnchor, constant: 15),
            button.trailingAnchor.constraint(equalTo: conteinerView.trailingAnchor, constant: -15),
            button.heightAnchor.constraint(equalToConstant: 45)
        ])
    }

    // MARK: - Actions

    @objc func buttonPressed() {
        dismiss(animated: true)
    }
}
