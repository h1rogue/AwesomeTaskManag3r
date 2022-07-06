//
//  ViewController.swift
//  TaskManager
//
//  Created by Hirak Jyoti Borah on 05/07/22.
//

import UIKit

class HomeVC: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var bottomBar: CustomBottomBar!
    
    var viewModel: HomeVM?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = HomeVM(delegate: self)
        bottomBar.delegate = self
        collectionView.layer.cornerRadius = 5
    }
}

extension HomeVC: HomeVMDelegate {
    func doSomething() {
        //MARK: todo
    }
}

extension HomeVC: CustomBottomBarDelegate {
    func onAddButtonClick() {
        let mainStory = UIStoryboard.init(name: "Main", bundle: .main)
      
        if let vc = UIStoryboard.instantiateViewController(mainStory)(withIdentifier: "AddNewTaskVC") as? AddNewTaskVC {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

