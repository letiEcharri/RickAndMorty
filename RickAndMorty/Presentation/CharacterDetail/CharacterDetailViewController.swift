//
//  CharacterDetailViewController.swift
//  RickAndMorty
//
//  Created by Leticia Echarri on 29/4/24.
//

import UIKit

protocol CharacterDetailViewControllerContract: AnyObject {
    var viewModel: CharacterDetailViewModelContract { get set }

    func changeViewState(_ state: CharacterDetailViewModel.ViewState)
}

class CharacterDetailViewController: UIViewController {
    struct Model: Equatable {
        let imageUrlString: String
        let name: String
        let species: String
        let status: Status
        let location: String
        let episodes: [String]
        let gender: String
        
        enum Status: String {
            case alive = "Alive"
            case dead = "Dead"
            case unknown
        }
    }
    
    private struct LayoutConstants {
        static let cornerRadius: CGFloat = 15
        static let shadowRadius: CGFloat = 10
        static let imageCornerRadius: CGFloat = imageSize / 2
        static let imageSize: CGFloat = 200
        static let padding: CGFloat = 25
        static let containerPadding: CGFloat = 25
        static let spacing: CGFloat = 25
        static let stateSize: CGFloat = 15
        static let statusSpacing: CGFloat = 10
    }
    
    // MARK: - Views
    private lazy var image: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = LayoutConstants.imageCornerRadius
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "userIcon")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: LayoutConstants.imageSize).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: LayoutConstants.imageSize).isActive = true
        
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 30)
        label.textAlignment = .center

        return label
    }()
    
    private lazy var statusView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = LayoutConstants.stateSize / 2
        view.widthAnchor.constraint(equalToConstant: LayoutConstants.stateSize).isActive = true
        view.heightAnchor.constraint(equalToConstant: LayoutConstants.stateSize).isActive = true
        
        return view
    }()
    
    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 20)

        return label
    }()
    
    private lazy var statusContainer: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            statusView,
            statusLabel
        ])
        stack.axis = .horizontal
        stack.spacing = LayoutConstants.statusSpacing
        
        return stack
    }()
    
    private lazy var genderLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 20)
        label.textAlignment = .center

        return label
    }()
    
    private lazy var locationTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 20, weight: .light)
        label.textAlignment = .center
        label.textColor = .lightGray
        label.text = "Last known location:"

        return label
    }()
    
    private lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 20)
        label.textAlignment = .center

        return label
    }()
    
    private lazy var episodeTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 20, weight: .light)
        label.textAlignment = .center
        label.textColor = .lightGray
        label.text = "First seen in:"

        return label
    }()
    
    private lazy var episodeLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 20)
        label.textAlignment = .center

        return label
    }()
    
    private lazy var numEpisodesTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 20, weight: .light)
        label.textAlignment = .center
        label.textColor = .lightGray
        label.text = "Number of episodes:"

        return label
    }()
    
    private lazy var numEpisodesLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 20)
        label.textAlignment = .center

        return label
    }()
    
    private lazy var container: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            image,
            titleLabel,
            statusContainer,
            genderLabel,
            locationTitleLabel,
            locationLabel,
            episodeTitleLabel,
            episodeLabel,
            numEpisodesTitleLabel,
            numEpisodesLabel
        ])
        stack.axis = .vertical
        stack.spacing = LayoutConstants.spacing
        stack.alignment = .center
        
        stack.setCustomSpacing(5, after: locationTitleLabel)
        stack.setCustomSpacing(5, after: episodeTitleLabel)
        stack.setCustomSpacing(5, after: numEpisodesTitleLabel)
        
        return stack
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = LayoutConstants.cornerRadius
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.3
        view.layer.shadowOffset = CGSize(width: 2, height: 2)
        view.layer.shadowRadius = LayoutConstants.shadowRadius
        
        return view
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .lightGreenRM
        scrollView.showsVerticalScrollIndicator = false
        scrollView.bounces = false

        return scrollView
    }()
    
    // MARK: - Properties
    var viewModel: CharacterDetailViewModelContract
    
    // MARK: - Life cycle
    init(viewModel: CharacterDetailViewModelContract) {
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
        viewModel.viewDidLoad()
    }
}

private extension CharacterDetailViewController {
    func setupViews() {
        title = "DETAIL"
        view.backgroundColor = .darkGreenRM
        
        container.fit(to: containerView,
                      with: ConstraintsConstants(constant: LayoutConstants.containerPadding))
        containerView.fit(to: scrollView,
                          with: ConstraintsConstants(constant: LayoutConstants.padding))
        scrollView.fit(to: view, with: .init(), position: .top, safeAreaLayout: true)
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor,
                                             constant: -LayoutConstants.padding * 2).isActive = true
    }
    
    func setImage(with urlString: String) {
        if let url = URL(string: urlString) {
            Task {
                try? await image.downloadImage(from: url)
            }
        }
    }
    
    func setupStatus(with status: Model.Status, and species: String) {
        switch status {
        case .alive:
            statusView.backgroundColor = .green
        case .dead:
            statusView.backgroundColor = .red
        case .unknown:
            statusView.backgroundColor = .yellow
        }
        statusLabel.text = String(format: "%@ - %@",
                                  status.rawValue,
                                  species)
    }
}

extension CharacterDetailViewController: CharacterDetailViewControllerContract {
    func changeViewState(_ state: CharacterDetailViewModel.ViewState) {
        DispatchQueue.main.async {
            switch state {
            case .clear:
                break
            case .update(let model):
                self.setImage(with: model.imageUrlString)
                self.titleLabel.text = model.name
                self.setupStatus(with: model.status, and: model.species)
                self.genderLabel.text = model.gender
                self.locationLabel.text = model.location
                self.episodeLabel.text = model.episodes.first
                self.numEpisodesLabel.text = String(model.episodes.count)
            }
        }
    }
}
