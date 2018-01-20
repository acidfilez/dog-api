//
//  DogsListViewController.swift
//  dog-api
//
//  Created by Magno C. Heck on 1/19/18.
//  Copyright © 2018 none. All rights reserved.
//

import UIKit
import EmptyKit

private let reuseIdentifierTable = "DogCell"

class DogsListViewController: UITableViewController {

    var dataSource: [Dog] = []
    var worker: DogsWorkerProtocol = DogsWorker()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()

        //Get data
        fetchDogs()
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let destination = segue.destination as! DogViewController
        destination.theDog = sender as? Dog
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension DogsListViewController {
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }

    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifierTable, for: indexPath)

        let dog = dataSource[indexPath.row]
        cell.textLabel?.text = dog.breed.capitalized

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ShowDog", sender: dataSource[indexPath.row])
    }
}

// MARK: - UI
extension DogsListViewController {

    func setupUI() {
        // Do any additional setup after loading the view.
        self.title = "BREEDS"

        //trick to remove separate lines
        self.tableView.tableFooterView = UIView()

        //Configure EmptyKit
        self.tableView.ept.dataSource = self
        self.tableView.ept.delegate = self
    }
}

// MARK: - Networking
extension DogsListViewController {
    func fetchDogs() {
        startLoading()
        worker.fetchDogs { [weak self] (response) in
            self?.stopLoading()
            do {
                let dogs = try response()
                self?.dataSource = dogs
                self?.tableView.reloadData()
            } catch {
                self?.showError(error)
            }
        }
    }
}

// MARK: - EmptyKit
extension DogsListViewController: EmptyDataSource {
    func imageForEmpty(in view: UIView) -> UIImage? {
        return UIImage(named: "DogApi")
    }

    func titleForEmpty(in view: UIView) -> NSAttributedString? {
        let title = "Cant fetch dogs"
        let font = UIFont.systemFont(ofSize: 14)
        let attributes: [NSAttributedStringKey: Any] = [.foregroundColor: UIColor.black, .font: font]
        return NSAttributedString(string: title, attributes: attributes)
    }

    func buttonTitleForEmpty(forState state: UIControlState, in view: UIView) -> NSAttributedString? {
        let title = "Load Again?"
        let font = UIFont.systemFont(ofSize: 17)
        let attributes: [NSAttributedStringKey: Any] = [.foregroundColor: UIColor.white, .font: font]
        return NSAttributedString(string: title, attributes: attributes)
    }

    func buttonBackgroundColorForEmpty(in view: UIView) -> UIColor {
        return .black
    }

    func customViewForEmpty(in view: UIView) -> UIView? {
        return nil
    }
}

extension DogsListViewController: EmptyDelegate {
    //Lets allow taping and reloading
    func emptyShouldAllowTouch(in view: UIView) -> Bool {
        return true
    }

    //Lets allow gestering
    func emptyShouldEnableTapGesture(in view: UIView) -> Bool {
        return true
    }

    //User taps de dog placeholder it reloads.
    func emptyView(_ emptyView: UIView, tappedIn view: UIView) {
        fetchDogs()
    }

    //User taps the reload button it reloads.
    func emptyButton(_ button: UIButton, tappedIn view: UIView) {
        fetchDogs()
    }

}
