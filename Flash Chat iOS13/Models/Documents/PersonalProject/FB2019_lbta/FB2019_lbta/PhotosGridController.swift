//
//  PhotogRIDcoNTROLLER.swift
//  FB2019_lbta
//
//  Created by 低调 on 12/24/20.
//  Copyright © 2020 Kaiyuan Zhao. All rights reserved.
//

import UIKit
import SwiftUI
import LBTATools

class PhotoGridCell: LBTAListCell<String> {
    override func setupViews() {
        backgroundColor = .yellow
    }
}

class PhotosGridContoller: LBTAListController<PhotoGridCell, String>, UICollectionViewDelegateFlowLayout {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .lightGray
        self.items = ["1", "2", "3" ]
    }
    
    let cellSpacing: CGFloat = 4
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width =  (view.frame.width - 4 * cellSpacing) / 3
        
        return .init(width: width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: cellSpacing, bottom: 0, right: cellSpacing)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

struct PhotoGridPreview: PreviewProvider {
    static var previews: some View{
        ContainerView()
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        func makeUIViewController(context: UIViewControllerRepresentableContext<PhotoGridPreview.ContainerView>) -> UIViewController {
            return PhotosGridContoller()
        }
        func updateUIViewController(_ uiViewController: PhotoGridPreview.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<PhotoGridPreview.ContainerView>) {
            
        }
    }
}
