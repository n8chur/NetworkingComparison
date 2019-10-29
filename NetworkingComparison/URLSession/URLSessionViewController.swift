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

class SubtitleCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

class URLSessionViewController: UITableViewController {
    fileprivate enum Section: CaseIterable {
        case hourly
    }

    fileprivate let cellReuseIdentifier = "cell"

    fileprivate lazy var dataSource = makeDataSource()

    fileprivate let viewModel = URLSessionViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(SubtitleCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        tableView.dataSource = dataSource

        viewModel.refresh { [weak self] forecasts in
            self?.update(forecasts: forecasts)
        }
    }
}

private extension URLSessionViewController {
    func update(forecasts: [CodableForecast]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, CodableForecast>()
        snapshot.appendSections(Section.allCases)
        snapshot.appendItems(forecasts, toSection: .hourly)
        dataSource.apply(snapshot, animatingDifferences: false)
    }

    func makeDataSource() -> UITableViewDiffableDataSource<Section, CodableForecast> {
        let reuseIdentifier = cellReuseIdentifier

        return UITableViewDiffableDataSource(
            tableView: tableView,
            cellProvider: { tableView, indexPath, forecast in
                let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
                cell.detailTextLabel?.text = forecast.formattedDate
                cell.textLabel?.text = forecast.formattedDescription
                return cell
            }
        )
    }
}
