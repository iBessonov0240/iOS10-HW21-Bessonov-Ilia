//
//  MarvelTableViewCell.swift
//  iOS10-HW21-Bessonov Ilia
//
//  Created by i0240 on 30.08.2023.
//

import UIKit

class MarvelTableViewCell: UITableViewCell {

    var marvelData: Results? {
        didSet {
            titleLabel.text = "\(marvelData?.title ?? "")"
            modifiedLabel.text = "\(marvelData?.modified ?? "")"
        }
    }

    // MARK: - Outlets

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .systemBlue
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var modifiedLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.font = .systemFont(ofSize: 11, weight: .regular)
        label.textColor = .systemBrown
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupHierarchy()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.accessoryType = .none
    }

    // MARK: - Setup

    private func setupHierarchy() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(modifiedLabel)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),

            modifiedLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            modifiedLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            modifiedLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
}
