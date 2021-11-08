//
//  ThirdViewController.swift
//  MVVMDemoApplication
//
//  Created by David Noy on 07/11/2021.
//

import UIKit

class ThirdViewController: UIViewController {

    var choosenNumber: String?
    var thirdDataSource: [CollectionViewCellModel] = []
    @IBOutlet weak var collectionViewOutlet: UICollectionView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupMethod()
    }
    
    private func setupMethod()
    {
        addNavigationItem()
        collectionViewOutlet.register(UINib(nibName: "ThirdVCCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "thirdCell")
        collectionViewOutlet.delegate = self
        collectionViewOutlet.dataSource = self
        setupLongGestureRecognizerOnCollection()
    }

    private func addNavigationItem()
    {
        navigationItem.leftBarButtonItem =
        UIBarButtonItem(image: UIImage(systemName: "arrow.backward"),
                        style: .plain,
                        target: self,
                        action: #selector(backToHome))
    }
    
    @objc private func backToHome()
    {
        dismiss(animated: true, completion: nil)
    }
    
}

extension ThirdViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {

     }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        thirdDataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        
        let collectionViewCellModel = thirdDataSource[indexPath.row]
        
        if let cell = collectionViewOutlet.dequeueReusableCell(withReuseIdentifier: "thirdCell", for: indexPath) as? ThirdVCCollectionViewCell
        {
            cell.configure(with: collectionViewCellModel)
            return cell
        }
        else
        {
            let cell = collectionViewOutlet.dequeueReusableCell(withReuseIdentifier: "thirdCell", for: indexPath)
            return cell
        }
        
    }

}

extension ThirdViewController: UIGestureRecognizerDelegate{
    
    private func setupLongGestureRecognizerOnCollection() {
        let longPressedGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(gestureRecognizer:)))
        longPressedGesture.minimumPressDuration = 1.0
        longPressedGesture.delegate = self
        longPressedGesture.delaysTouchesBegan = true
        collectionViewOutlet?.addGestureRecognizer(longPressedGesture)
    }
    
    @objc func handleLongPress(gestureRecognizer: UILongPressGestureRecognizer) {
        if (gestureRecognizer.state != .began) {
            return
        }

        let p = gestureRecognizer.location(in: collectionViewOutlet)

        if let indexPath = collectionViewOutlet?.indexPathForItem(at: p) {
            collectionViewOutlet.deleteItems(at: [indexPath])
            thirdDataSource.remove(at: indexPath.item)
            self.view.layoutIfNeeded()
        }
    }
}

extension ThirdViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
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
