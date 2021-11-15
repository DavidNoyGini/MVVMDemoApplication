//
//  ThirdVC.swift
//  MVVMDemoApplication
//
//  Created by David Noy on 07/11/2021.
//

import UIKit
import Reusable

class ThirdVC: UIViewController {
      
    // MARK: - Privtae @IBOutlet
    @IBOutlet private weak var collectionViewOutlet: UICollectionView!

    // MARK: - Privtae var
    private var choosenNumber: String?
    private var viewModel: ThirdVM
    
    // MARK: - Init
    init(viewModel: ThirdVM)
    {
        self.viewModel = viewModel
        super.init(nibName: "ThirdVC", bundle: nil)
    }
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - lifecycle
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupCollectionView()
        setupLongGestureRecognizerOnCollection()
    }
    
    // MARK: - Privtae methods
    private func setupCollectionView()
    {
        collectionViewOutlet.register(cellType: ThirdVCCollectionViewCell.self)
        collectionViewOutlet.delegate = self
        collectionViewOutlet.dataSource = self
    }
}

// MARK: - UICollectionView Methods
extension ThirdVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        viewModel.userDidSelectItemAt(indexPath: indexPath)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return viewModel.getNumberOfItemsInSection(numberOfItemsInSection: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        
        let collectionViewCellModel = viewModel.thirdCellViewModels[indexPath.row]
        
        let cell = collectionViewOutlet.dequeueReusableCell(for: indexPath) as ThirdVCCollectionViewCell
        
        cell.configure(with: collectionViewCellModel)
        
        return cell
    }

}

// MARK: - UIGestureRecognizerDelegate
extension ThirdVC: UIGestureRecognizerDelegate{
    
    private func setupLongGestureRecognizerOnCollection()
    {
        let longPressedGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(gestureRecognizer:)))
        longPressedGesture.minimumPressDuration = 1.0
        longPressedGesture.delegate = self
        longPressedGesture.delaysTouchesBegan = true
        collectionViewOutlet?.addGestureRecognizer(longPressedGesture)
    }
    
    @objc func handleLongPress(gestureRecognizer: UILongPressGestureRecognizer)
    {
        if (gestureRecognizer.state != .began)
        {
            return
        }

        let point = gestureRecognizer.location(in: collectionViewOutlet)

        if let indexPath = collectionViewOutlet?.indexPathForItem(at: point)
        {
            collectionViewOutlet.deleteItems(at: [indexPath])
            viewModel.thirdCellViewModels.remove(at: indexPath.item)
            self.view.layoutIfNeeded()
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ThirdVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: collectionViewOutlet.frame.size.width / 2, height: collectionViewOutlet.frame.size.width / 2)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat
    {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat
    {
        return 0
    }
    
}
