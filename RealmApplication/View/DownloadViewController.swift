//
//  DownloadViewController.swift
//  RealmApplication
//
//  Created by Skorodumov Dmitry on 18.10.2023.
//

import UIKit

class DownloadViewController: UIViewController {
    private var jokeData: [String] = []
    private var downloadDelegate : DownloadViewControllerDelegate?
    private lazy var tableView: UITableView = {
        let tableView = UITableView.init(
            frame: .zero,
            style: .grouped
        )
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var downloadButton: UIButton = {
        let buttonLog = CustomButton(title: "Загрузить цитату", titleColor: .white, buttonBackgroundColor: UIColor(patternImage: UIImage(named: "BluePixel")!)) { [weak self] in
            self?.buttonPressed()
        }
        buttonLog.translatesAutoresizingMaskIntoConstraints = false
        return buttonLog
        
    }()
    
    private enum CellReuseID: String {
        case base = "BaseTableViewCell_ReuseID"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setupConstraints()
        tuneTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    private func addSubviews() {
        view.addSubview(tableView)
        view.addSubview(downloadButton)
    }
    
    private func setupConstraints() {
        let safeAreaGuide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor),
            //tableView.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor),
            tableView.heightAnchor.constraint(equalToConstant:  400),
            
            downloadButton.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor,constant: 16),
            downloadButton.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor, constant: -16),
            downloadButton.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 25),
            downloadButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    init(downloadDelegate: DownloadViewControllerDelegate) {
        self.downloadDelegate = downloadDelegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func tuneTableView() {
        // 2. Настраиваем отображение таблицы
        tableView.rowHeight = UITableView.automaticDimension
        //tableView.estimatedRowHeight = 150.0
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0.0
        }
        
        // 3. Указываем, с какими классами ячеек и кастомных футеров / хэдеров
        //    будет работать таблица
        tableView.register(
            DownloadTableViewCell.self,
            forCellReuseIdentifier: CellReuseID.base.rawValue
        )
        
        
        // 4. Указываем основные делегаты таблицы
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
    }
    
    @objc func buttonPressed() {
    
        guard let delegate = downloadDelegate else { return }
        
        delegate.getRandomJoke() {_joke in
            self.jokeData.removeAll()
            self.jokeData.append(_joke)
            self.tableView.reloadData()
        }
        
    }
}

extension DownloadViewController: UITableViewDataSource {
    
    func numberOfSections(
        in tableView: UITableView
    ) -> Int {
        1
    }
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {jokeData.count}
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CellReuseID.base.rawValue,
            for: indexPath
        ) as? DownloadTableViewCell else {
            fatalError("could not dequeueReusableCell")
        }
        if jokeData.count > 0 {
            cell.update(jokeData[indexPath.row])
        }
        return cell
    }
    
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {}
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    }
}

extension DownloadViewController: UITableViewDelegate {
    
    func tableView(
        _ tableView: UITableView,
        heightForHeaderInSection section: Int
    ) -> CGFloat {return 0}
    
    func tableView(
        _ tableView: UITableView,
        viewForHeaderInSection section: Int
    ) -> UIView? {
        return nil
    }
    
    private func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableView.automaticDimension
       }
    private func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}


