//
//  CharacterListViewController.swift
//  RickAndMorty
//
//  Created by Leticia Echarri on 28/4/24.
//

import UIKit

protocol CharacterListViewControllerContract: AnyObject {
    var viewModel: CharacterListViewModelContract { get set }

    func changeViewState(_ state: CharacterListViewModel.ViewState)
}

class CharacterListViewController: UIViewController, ActivityIndicatorPresenter {
    // MARK: - Views
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.backgroundColor = .clear
        table.rowHeight = UITableView.automaticDimension
        table.separatorStyle = .none
        table.showsVerticalScrollIndicator = false
        table.bounces = false
        table.delegate = self
        table.dataSource = self
        table.tableFooterView?.isHidden = true

        table.register(CharacterListCell.self, forCellReuseIdentifier: CharacterListCell.identifier)

        return table
    }()
    
    private let cellSpinner = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
    private let searchController = UISearchController(searchResultsController: nil)
    
    // MARK: - Properties
    var activityIndicator = UIActivityIndicatorView()
    var cells: [CharacterListCell.Model] = [] {
        didSet {
            cellSpinner.stopAnimating()
            tableView.tableFooterView?.isHidden = true
            tableView.reloadData()
        }
    }
    var viewModel: CharacterListViewModelContract
    
    // MARK: - Life cycle
    init(viewModel: CharacterListViewModelContract) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("Storyboard are a pain")
    }
    
    override func loadView() {
        super.loadView()
        setupViews()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        Task {
            await viewModel.viewDidLoad()
        }
    }
}

private extension CharacterListViewController {
    func setupViews() {
        title = "CHARACTERS"
        view.backgroundColor = .darkGreenRM
        tableView.backgroundColor = .lightGreenRM
        
        tableView.fit(to: view, with: [
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.tintColor = .white
        definesPresentationContext = true
        navigationItem.searchController = searchController
        
        UITextField
            .appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = 
        [
                NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        searchController.searchBar.searchTextField.layer.borderColor = UIColor.white.cgColor
        searchController.searchBar.searchTextField.layer.borderWidth = 1
        searchController.searchBar.searchTextField.layer.cornerRadius = 10
        searchController.searchBar.searchTextField.leftView?.tintColor = .white

    }
}

// MARK: Table Delegate & DataSource
extension CharacterListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CharacterListCell.identifier,
                                                       for: indexPath) as? CharacterListCell else {
            return UITableViewCell()
        }
        
        let item = cells[indexPath.row]
        cell.configure(with: item)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = cells[indexPath.row]
        viewModel.didSelect(cell.id)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let isReachedTheEnd = indexPath.section == tableView.numberOfSections - 1 &&
        indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1
        
        if isReachedTheEnd {
            cellSpinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
            tableView.tableFooterView = cellSpinner
            cellSpinner.startAnimating()
            tableView.tableFooterView?.isHidden = false
            Task {
                await viewModel.getMoreCharacters()
            }
        }
    }
}

// MARK: Search Delegate
extension CharacterListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        print("Search text : \(searchController.searchBar.text!)")
    }
}

// MARK: Contract
extension CharacterListViewController: CharacterListViewControllerContract {
    func changeViewState(_ state: CharacterListViewModel.ViewState) {
        DispatchQueue.main.async {
            self.hideActivityIndicator()
            switch state {
            case .clear:
                break
            case .showLoader:
                self.showActivityIndicator()
            case .updateList(let cells):
                self.cells = cells
            }
        }
    }
}
