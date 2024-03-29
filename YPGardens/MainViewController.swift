//
//  ViewController.swift
//  YPGardens
//
//  Created by Tony Cioara on 7/24/19.
//  Copyright © 2019 Tony Cioara. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    private var plantData: [Plant] = [
        Plant(name: "Planty", description: "Succulent", waterLevel: 0.1, waterLimit: 0.1, image: #imageLiteral(resourceName: "planty")),
        Plant(name: "Steve", description: "Secretly Planty", waterLevel: 1, waterLimit: 0.2, image: #imageLiteral(resourceName: "planty")),
        Plant(name: "Planty", description: "Succulent", waterLevel: 0.5, waterLimit: 0.3, image: #imageLiteral(resourceName: "planty")),
        Plant(name: "Steve", description: "The best plant in the name of all plants this plant is the absolute greatest", waterLevel: 0.7, waterLimit: 0.5, image: #imageLiteral(resourceName: "planty")),
        Plant(name: "Planty", description: "Succulent", waterLevel: 0.9, waterLimit: 0.3, image: #imageLiteral(resourceName: "planty")),
        Plant(name: "Steve", description: "Secretly Planty", waterLevel: 1, waterLimit: 0.3, image: #imageLiteral(resourceName: "planty")),
    ]
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.scrollDirection = .horizontal
        let collectionView =  UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.isPagingEnabled = true
        return collectionView
    }()
    
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(PlantCollectionViewCell.self, forCellWithReuseIdentifier: PlantCollectionViewCell.id)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Your Garden"
        view.backgroundColor = .white
        setupCollectionView()
        setupViews()
        Networking.shared.connect()
    }

    private func setupViews() {
        self.view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
        }
    }

}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return plantData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlantCollectionViewCell.id, for: indexPath) as! PlantCollectionViewCell
        cell.setup(plant: plantData[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.bounds.width - 40, height: collectionView.bounds.height - 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let vc = PlantDetailsViewController(plant: plantData[indexPath.item])
//        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension MainViewController: UIScrollViewDelegate {

    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        targetContentOffset.pointee = scrollView.contentOffset
        var factor: CGFloat = 0.5
        if velocity.x < 0 {
            factor = -factor
        }
        let indexPath = IndexPath(row: (Int(scrollView.contentOffset.x/(self.view.bounds.width - 40) + factor)), section: 0)
        collectionView.scrollToItem(at: indexPath, at: .left, animated: true)
    }
}
