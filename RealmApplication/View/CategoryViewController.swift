//
//  CategoryViewController.swift
//  RealmApplication
//
//  Created by Skorodumov Dmitry on 18.10.2023.
//

import UIKit

class CategoryViewController: UIViewController {
    
    private lazy var categoryData: [String] = []
    private var categoryDelegate : CategoryViewControllerDelegate?
    private lazy var tableView: UITableView = {
        let tableView = UITableView.init(
            frame: .zero,
            style: .grouped
        )
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private enum categoryCellReuseID: String {
        case base = "BaseTableViewCell_ReuseID"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setupConstraints()
        tuneTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tuneTableView()
        tableView.reloadData()
    }
    
    private func addSubviews() {
        view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        let safeAreaGuide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor),
        ])
    }
    
    init(categoryDelegate: CategoryViewControllerDelegate) {
        self.categoryDelegate = categoryDelegate
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
            CategoryViewCell.self,
            forCellReuseIdentifier: categoryCellReuseID.base.rawValue
        )
        
        
        // 4. Указываем основные делегаты таблицы
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
        
        guard let delegate = categoryDelegate else { return }
        
        self.categoryData = delegate.getJokeList()
        self.tableView.reloadData()
        
    }
    
    @objc func infoPressed(_ sender: UIButton) {
    
    }
}

extension CategoryViewController: UITableViewDataSource {
    
    func numberOfSections(
        in tableView: UITableView
    ) -> Int {
        1
    }
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {categoryData.count}
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: categoryCellReuseID.base.rawValue,
            for: indexPath
        ) as? CategoryViewCell else {
            fatalError("could not dequeueReusableCell")
        }
        if categoryData.count > 0 {
            cell.update(categoryData[indexPath.row])
        }
        return cell
    }
    
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        let nameOfCategory = categoryData[indexPath.row]
        let quoteVC = Factory(flow: .quoteOfCategory, category: nameOfCategory,  navigation: navigationController!)
        navigationController?.pushViewController(quoteVC.viewController!, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    }
}

extension CategoryViewController: UITableViewDelegate {
    
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




