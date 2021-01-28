//
//  MainController.swift
//  FB2019_lbta
//
//  Created by 低调 on 12/24/20.
//  Copyright © 2020 Kaiyuan Zhao. All rights reserved.
//

import UIKit
import LBTATools

class PostCell: LBTAListCell<String> {
    let imageView = UIImageView(backgroundColor: .red)
    let nameLabel = UILabel(text: "Name Label")
    let dateLabel = UILabel(text: "Friday at 11:11am")
    let postTextLabel = UILabel(text: "HERE IS MY POST EXT")
//    let imageViewGrid = UIView(backgroundColor: .yellow)
    let photosGridController = PhotosGridContoller()
    
    override func setupViews() {
        backgroundColor = .white
        stack(hstack(imageView.withHeight(40).withWidth(40), stack(nameLabel, dateLabel), spacing: 8).padLeft(12).padRight(12).padTop(12), postTextLabel, photosGridController.view, spacing: 8)
    }
}

class MainController: LBTAListController<PostCell, String>, UICollectionViewDelegateFlowLayout {
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .init(white: 0.9, alpha: 1)
        self.items = ["hello", "world", "1", "2"]
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 250)
    }
}

import SwiftUI
struct MainPreviews: PreviewProvider {
    static var previews: some View {
//        Text("Main preview")
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        func makeUIViewController(context: UIViewControllerRepresentableContext<MainPreviews.ContainerView>) -> UIViewController {
            return MainController()
        }
        func updateUIViewController(_ uiViewController: MainPreviews.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<MainPreviews.ContainerView>) {
            
        }
    }
}
