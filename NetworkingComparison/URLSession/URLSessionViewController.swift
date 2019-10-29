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
    private enum Section: CaseIterable {
        case hourly
    }

    private let viewModel = URLSessionViewModel()

    private let cellReuseIdentifier = "cell"
    private lazy var dataSource: UITableViewDiffableDataSource<Section, CodableForecast> = {
        UITableViewDiffableDataSource(
            tableView: tableView,
            cellProvider: { tableView, indexPath, forecast in
                let cell = tableView.dequeueReusableCell(withIdentifier: self.cellReuseIdentifier, for: indexPath)
                cell.detailTextLabel?.text = forecast.formattedDate
                cell.textLabel?.text = forecast.formattedDescription
                return cell
        })
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(SubtitleCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        tableView.dataSource = dataSource

        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
        refresh()
    }

    @objc private func refresh() {
        viewModel.refresh { [weak self] forecasts in
            var snapshot = NSDiffableDataSourceSnapshot<Section, CodableForecast>()
            snapshot.appendSections(Section.allCases)
            snapshot.appendItems(forecasts, toSection: .hourly)
            self?.dataSource.apply(snapshot, animatingDifferences: false)

            DispatchQueue.main.async {
                self?.refreshControl?.endRefreshing()
            }
        }
    }
}
