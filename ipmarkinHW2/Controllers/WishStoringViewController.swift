import UIKit

final class WishStoringViewController: UIViewController {
    private let table: UITableView = UITableView(frame: .zero)
    private var wishArray: [String] = ["I wish to add cells to the table"]
    private let defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        loadUserSavedWishes()
        configureTable()
    }
    
    private func configureTable() {
        view.addSubview(table)
        table.backgroundColor = .red
        table.dataSource = self
        table.separatorStyle = .none
        table.layer.cornerRadius = Constants.tableCornerRadius
        table.frame = view.bounds
        table.register(AddWishCell.self, forCellReuseIdentifier: AddWishCell.reuseId)
        table.register(WrittenWishCell.self, forCellReuseIdentifier: WrittenWishCell.reuseId)
    }
    private func saveUserWishes() {
        defaults.set(wishArray, forKey: Constants.wishesKey)
    }
    private func loadUserSavedWishes() {
        if let savedWishes = defaults.array(forKey: Constants.wishesKey) as? [String] {
               wishArray = savedWishes
        }
    }
}

extension WishStoringViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return Constants.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return wishArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: AddWishCell.reuseId, for: indexPath)
            guard let addWishCell = cell as? AddWishCell else { return cell }
            
            addWishCell.addWish = { [weak self] newWish in
                self?.wishArray.append(newWish)
                self?.saveUserWishes()
                self?.table.reloadData()
            }
            return addWishCell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: WrittenWishCell.reuseId, for: indexPath)
            guard let writtenWishCell = cell as? WrittenWishCell else { return cell }
            
            writtenWishCell.configure(with: wishArray[indexPath.row])
            return writtenWishCell
        }
    }
}

