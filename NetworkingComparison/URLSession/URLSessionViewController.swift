//
//  URLSessionViewController.swift
//  NetworkingComparison
//
//  Created by Ian Luo on 10/25/19.
//  Copyright © 2019 Lokae. All rights reserved.
//

import UIKit
import SwiftUI

struct URLSessionView: UIViewControllerRepresentable {
    typealias UIViewControllerType = URLSessionViewController

    func updateUIViewController(_ uiViewController: URLSessionViewController, context: UIViewControllerRepresentableContext<URLSessionView>) { }

    func makeUIViewController(context: Context) -> URLSessionViewController {
        return URLSessionViewController()
    }
}

class URLSessionViewController: UITableViewController {
    enum Section {
        case hourly
    }

    fileprivate let cellReuseIdentifier = "cell"

    fileprivate lazy var dataSource = makeDataSource()

    fileprivate let viewModel = URLSessionViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        tableView.dataSource = dataSource
        viewModel.refresh()
    }
}

private extension URLSessionViewController {
    func makeDataSource() -> UITableViewDiffableDataSource<Section, CodableForecast> {
        let reuseIdentifier = cellReuseIdentifier

        return UITableViewDiffableDataSource(
            tableView: tableView,
            cellProvider: { tableView, indexPath, forecast in
                let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
                cell.textLabel?.font = .monospacedSystemFont(ofSize: 14.0, weight: .regular)
                return cell
            }
        )
    }
}
