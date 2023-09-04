//
//  MainScreenViewController.swift
//  iOS10-HW21-Bessonov Ilia
//
//  Created by i0240 on 30.08.2023.
//

import UIKit

class MainScreenViewController: UIViewController {

    private var marvelData: [Results]?
    private var filteredData = [Results]()

    // MARK: - Outlets

    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.textColor = .systemBlue
        textField.textAlignment = .center
        textField.attributedPlaceholder = NSAttributedString(string: "Type here...", attributes: [NSAttributedString.Key.foregroundColor : UIColor.systemGray3])
        textField.backgroundColor = .systemGray6
        textField.layer.cornerRadius = 10
        textField.clipsToBounds = true
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private lazy var findButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Find", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(findButtonTapped), for: .touchUpInside)
        return button
    }()

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(MarvelTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupHierarchy()
        setupLayout()
        loader()
    }

    // MARK: - Setup

    private func setup() {
        view.backgroundColor = .white
        title = "Data provided by Marvel. © 2023 MARVEL"
    }

    private func loader() {
        NetworkManager.shared.makeAPIRequest { [weak self] result in
            switch result {
            case .success(let marvelData):
                self?.marvelData = marvelData.data.results
                self?.tableView.reloadData()
            case .failure(let error):
                self?.presentAlert(title: "Bad Stuff Happend", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }

    private func setupHierarchy() {
        view.addSubviews([textField, findButton, tableView])
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            textField.heightAnchor.constraint(equalToConstant: 30),

            findButton.centerYAnchor.constraint(equalTo: textField.centerYAnchor),
            findButton.leadingAnchor.constraint(equalTo: textField.trailingAnchor, constant: 10),
            findButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            tableView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    // MARK: - Actions

    @objc func findButtonTapped() {
        if textField.text == "" {
            presentAlert(title: "Empty username", message: "Please enter something. We need to know what to look for 🤪.", buttonTitle: "Ok")
        } else {
            filterText(textField.text ?? "")
        }
    }
}

    // MARK: - UITableViewDataSource, UITableViewDelegate

extension MainScreenViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if textField.text == "" {
            return marvelData?.count ?? 0
        } else {
            return filteredData.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? MarvelTableViewCell
        if textField.text == "" {
            cell?.marvelData = marvelData?[indexPath.row]
        } else {
            cell?.marvelData = filteredData[indexPath.row]
        }
        return cell ?? UITableViewCell()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let selectedResult = marvelData?[indexPath.row] {
            let modalVC = DetailViewController()
            modalVC.marvelDescription = selectedResult
            modalVC.modalPresentationStyle = .formSheet
            present(modalVC, animated: true, completion: nil)
        }
    }
}

// MARK: - UI

extension MainScreenViewController: UITextFieldDelegate {

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        filterText(textField.text ?? "")
    }

    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        filterText("")
        return true
    }

    func filterText(_ query: String) {
        if query.isEmpty {
            filteredData = marvelData ?? []
        } else {
            filteredData = marvelData?.filter { $0.title?.lowercased().starts(with: query.lowercased()) == true } ?? []
        }

        tableView.reloadData()
    }
}
