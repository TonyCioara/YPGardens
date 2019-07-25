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
        Plant(name: "Steve", description: "Secretly Planty", waterLevel: 0.3, waterLimit: 0.2, image: #imageLiteral(resourceName: "planty")),
        Plant(name: "Planty", description: "Succulent", waterLevel: 0.5, waterLimit: 0.3, image: #imageLiteral(resourceName: "planty")),
        Plant(name: "Steve", description: "The best plant in the business of the best plants ever", waterLevel: 0.7, waterLimit: 0.5, image: #imageLiteral(resourceName: "planty")),
        Plant(name: "Planty", description: "Succulent", waterLevel: 0.9, waterLimit: 0.3, image: #imageLiteral(resourceName: "planty")),
        Plant(name: "Steve", description: "Secretly Planty", waterLevel: 1, waterLimit: 0.3, image: #imageLiteral(resourceName: "planty")),
    ]
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let collectionView =  UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
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
    }

    private func setupViews() {
        self.view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.left.right.bottom.top.equalToSuperview()
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
        return CGSize(width: self.view.bounds.width / 2, height: self.view.bounds.width / 2 + 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = PlantDetailsViewController(plant: plantData[indexPath.item])
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
