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
    private struct LayoutConstants {
        static let searchBarBorderWidth: CGFloat = 1
        static let searchBarCornerRadius: CGFloat = 10
        static let searchBarViewHeight: CGFloat = 56
    }
    
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
        table.backgroundColor = .lightGreenRM

        table.register(CharacterListCell.self, forCellReuseIdentifier: CharacterListCell.identifier)

        return table
    }()
    
    private lazy var searchBar: UISearchBar =  {
        let bar = UISearchBar()
        bar.backgroundColor = .lightGreenRM
        bar.searchBarStyle = .default
        bar.sizeToFit()
        bar.backgroundImage = UIImage()
        bar.delegate = self
        bar.searchTextField.layer.borderColor = UIColor.darkGreenRM.cgColor
        bar.searchTextField.layer.borderWidth = LayoutConstants.searchBarBorderWidth
        bar.searchTextField.layer.cornerRadius = LayoutConstants.searchBarCornerRadius
        bar.searchTextField.leftView?.tintColor = .darkGreenRM
        bar.searchTextField.attributedPlaceholder = NSAttributedString(
            string: "Search",
            attributes: [.foregroundColor: UIColor.lightGray]
        )
        bar.setShowsCancelButton(true, animated: true)
        bar.tintColor = .darkGreenRM
    
        return bar
    }()
    
    private lazy var searchView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.addSubview(searchBar)
        view.heightAnchor.constraint(equalToConstant: LayoutConstants.searchBarViewHeight)
            .isActive = true
        
        return view
    }()
    
    private let cellSpinner = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
    private let searchController = UISearchController(searchResultsController: nil)
    
    // MARK: - Properties
    private var isSearchActive: Bool {
        searchBar.text != nil && !searchBar.text!.isEmpty
    }
    var activityIndicator = UIActivityIndicatorView()
    private var cells: [CharacterListCell.Model] = [] {
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
        
        searchView.fit(to: view, with: .init(), position: .top, safeAreaLayout: true)
        
        tableView.fit(to: view, with: [
            tableView.topAnchor.constraint(equalTo: searchView.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        UITextField
            .appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes =
        [
                NSAttributedString.Key.foregroundColor: UIColor.darkGreenRM
        ]
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
        
        if isReachedTheEnd, !isSearchActive {
            cellSpinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
            tableView.tableFooterView = cellSpinner
            cellSpinner.startAnimating()
            tableView.tableFooterView?.isHidden = false
            Task {
                await viewModel.search(name: "", isSearchActive: isSearchActive)
            }
        }
    }
}

// MARK: Search Bar Delegate
extension CharacterListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        Task {
            let text = searchBar.text ?? ""
            if !text.isEmpty {
                searchBar.searchTextField.resignFirstResponder()
            }
            await viewModel.search(name: text, isSearchActive: isSearchActive)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.searchTextField.resignFirstResponder()
        Task {
            let text = searchBar.text ?? ""
            if text.isEmpty {
                await viewModel.search(name: "", isSearchActive: isSearchActive)
            }
        }
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
