//
//  Cell2.swift
//  WeatherApp
//
//  Created by Vu Nam Ha on 06/08/2022.
//

import UIKit

class Cell2: UICollectionViewCell {

    @IBOutlet weak var collectionViewHorizon: UICollectionView!
    var arrData: [DataHourly] = [] {
        didSet {
            // khi arrData được gán giá trị ( ở Cell 2 HomeVC) thì cho reload lại collectionView nhỏ
            collectionViewHorizon.reloadData()
        }
    }
    
    var handleDidSelectItem: ((_ : Int ) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        configCollectionView2()
    }
    
    func configCollectionView2() {
        collectionViewHorizon.delegate = self
        collectionViewHorizon.dataSource = self
        collectionViewHorizon.register(UINib(nibName: "MiniCell", bundle: nil), forCellWithReuseIdentifier: "minicell")
    }


}

extension Cell2: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let minicell = collectionViewHorizon.dequeueReusableCell(withReuseIdentifier: "minicell", for: indexPath) as! MiniCell
        minicell.bindData(item: arrData[indexPath.row])
        return minicell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       
        return CGSize(width: collectionView.bounds.width/5, height: collectionView.bounds.height)
    }
 
}





