//
//  DogViewController.swift
//  dog-api
//
//  Created by Magno C. Heck on 1/19/18.
//  Copyright © 2018 none. All rights reserved.
//

import UIKit
import Kingfisher
import Agrume
import EmptyKit

private let reuseIdentifierCol = "ImageCell"

class DogViewController: UICollectionViewController {
    //the selected dog
    var theDog: Dog?

    var dataSource: [URL] = []
    var worker: DogsWorkerProtocol = DogsWorker()

    //handle empty colletionview
    var displayEmpty = false

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()

        //get data
        fetchBreeds()
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension DogViewController {
    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }

    // MARK: UICollectionViewDelegate

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifierCol, for: indexPath) as! ImageCollectionViewCell
        // Configure the cell
        return configureCell(for: cell, indexPath: indexPath)
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! ImageCollectionViewCell
        self.previewImage(for: cell)
    }
}

// MARK: - UI
extension DogViewController {

    func setupUI() {
        self.title = theDog?.breed.uppercased()

        //Configure EmptyKit
        self.collectionView?.ept.dataSource = self
        self.collectionView?.ept.delegate = self
    }

    func configureCell(for cell: ImageCollectionViewCell, indexPath: IndexPath) -> ImageCollectionViewCell {
        //Download the images async
        let url = dataSource[indexPath.row]
        let resource = ImageResource(downloadURL: url, cacheKey: url.path)
        cell.imageView.kf.indicatorType = .activity
        cell.imageView.kf.setImage(with: resource)
        return cell
    }
}

// MARK: - Networking
extension DogViewController {
    func fetchBreeds() {
        guard let dog = theDog else {
            assertionFailure("Trying to fetch breed images without an instance of theDog")
            return
        }

        startLoading()
        worker.fetchImages(for: dog) { [weak self] (response) in
            self?.stopLoading()
            do {
                let images = try response()
                self?.dataSource = images.flatMap { URL(string: $0.imageUrl) }

                //Set title with total count.
                self?.title = "\(dog.breed) (\(images.count))".uppercased()
            } catch {
                self?.showError(error)
            }
            self?.displayEmpty = true
            self?.collectionView?.reloadData()
        }
    }
}

// MARK: - Helpers
extension DogViewController {
    func previewImage(for cell: ImageCollectionViewCell) {
        //wait till the image is loaded then we open the previewer
        if let image = cell.imageView.image {
            let agrume = Agrume(image: image, backgroundColor: .black)
            agrume.hideStatusBar = false
            agrume.showFrom(self)
        }
    }
}

// MARK: - EmptyKit
extension DogViewController: EmptyDataSource {
    func imageForEmpty(in view: UIView) -> UIImage? {
        return UIImage(named: "DogApi")
    }

    func titleForEmpty(in view: UIView) -> NSAttributedString? {
        let title = "Cant fetch breed images"
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

extension DogViewController: EmptyDelegate {
    //Display empty after fetching data
    func emptyShouldDisplay(in view: UIView) -> Bool {
        return displayEmpty
    }

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
        fetchBreeds()
    }

    //User taps the reload button it reloads.
    func emptyButton(_ button: UIButton, tappedIn view: UIView) {
        fetchBreeds()
    }
}
