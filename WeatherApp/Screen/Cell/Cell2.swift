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
        let item = arrData[indexPath.row]
        minicell.hourLabel.text = localTimeToHour(time: item.timestampLocal!)
        minicell.iconImage.image = .init(named: item.weather!.icon!)
        minicell.tempLabel.text = "\(Int(item.temp ?? 0))°"
        minicell.humidityLabel.text = "\(item.rh ?? 0)%"
        return minicell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       
        return CGSize(width: collectionView.bounds.width/5, height: collectionView.bounds.height)
    }
}


extension Cell2 {
    func localTimeToHour(time: String) -> String {
        let a = time.suffix(8)
        let b = a.prefix(2)
        return String(b)
    }
    
}


