//
//  DetailViewController.swift
//  iOS10-HW21-Bessonov Ilia
//
//  Created by i0240 on 01.09.2023.
//

import UIKit

class DetailViewController: UIViewController {

    var marvelDescription: Results?

    // MARK: - Outlets

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "dgsbfdx"
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setupLayout()
        fillDetails()
        view.backgroundColor = .systemGray5
    }

    // MARK: - Setup

    private func setupHierarchy() {
        view.addSubview(descriptionLabel)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 25),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25)
        ])
    }

    private func fillDetails() {
        if let description = marvelDescription?.description, !description.isEmpty {
               descriptionLabel.text = description
           } else {
               descriptionLabel.text = "There is no description"
           }
    }
}
