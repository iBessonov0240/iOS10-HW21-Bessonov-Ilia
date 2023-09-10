//
//  MarvelTableViewCell.swift
//  iOS10-HW21-Bessonov Ilia
//
//  Created by i0240 on 30.08.2023.
//

import UIKit
import AlamofireImage

class MarvelTableViewCell: UITableViewCell {

    var marvelData: Results? {
        didSet {
            if let thumbnail = marvelData?.thumbnail {
                let imageURLString = thumbnail.path + "." + thumbnail.imageExtension
                if let url = URL(string: imageURLString) {
                    personImage.af.setImage(withURL: url)
                }
            }
            titleLabel.text = "\(marvelData?.title ?? "")"

            if let modifiedDate = marvelData?.modified {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
//                if let formattedDate = dateFormatter.date(from: modifiedDate) {
                if let date = parseDate(dateString: modifiedDate, formatter: dateFormatter) {
                    dateFormatter.dateFormat = "MMM d, yyyy"
                    let dateString = dateFormatter.string(from: date)
                    modifiedLabel.text = dateString
                }
            } else {
                modifiedLabel.text = ""
            }
        }
    }

    // MARK: - Outlets

    private lazy var personImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 30
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.lineBreakMode = .byWordWrapping
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .systemBlue
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var modifiedLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
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

    private func parseDate(dateString: String, formatter: DateFormatter) -> Date? {
        // Remove the negative year symbol
        var cleanedDateString = dateString
        if cleanedDateString.hasPrefix("-") {
            cleanedDateString.removeFirst()
        }
        return formatter.date(from: cleanedDateString)
    }

    private func setupHierarchy() {
        contentView.addSubviews([personImage, titleLabel, modifiedLabel])
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            personImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            personImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            personImage.widthAnchor.constraint(equalToConstant: 60),
            personImage.heightAnchor.constraint(equalToConstant: 60),

            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: personImage.trailingAnchor, constant: 15),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),

            modifiedLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
            modifiedLabel.leadingAnchor.constraint(equalTo: personImage.trailingAnchor, constant: 15),
            modifiedLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            modifiedLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
}
