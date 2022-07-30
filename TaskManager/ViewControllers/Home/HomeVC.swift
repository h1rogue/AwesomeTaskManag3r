//
//  ViewController.swift
//  TaskManager
//
//  Created by Hirak Jyoti Borah on 05/07/22.
//

import UIKit

class HomeVC: UIViewController, UICollectionViewDelegate {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var bottomBar: CustomBottomBar!
    private lazy var dataSource = makeDataSource()
    
    var viewModel: HomeVM?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = HomeVM(delegate: self)
        bottomBar.delegate = self
        collectionView.layer.cornerRadius = 5
        collectionView.dataSource = dataSource
        collectionView.register(UINib(nibName: TaskCollectionCVC.identifier, bundle: .main), forCellWithReuseIdentifier: TaskCollectionCVC.identifier)
        collectionView.delegate = self
        viewModel?.retrieveData()
    }
    
    private func makeDataSource() -> HomeDataSource {
        let dataSource = HomeDataSource(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TaskCollectionCVC.identifier, for: indexPath) as? TaskCollectionCVC else { return UICollectionViewCell() }
            cell.configure(model: itemIdentifier)
            return cell
        }
        return dataSource
    }
    
    private func reloadSnapShot() {
        var snapShot = HomeSnapshot()
        if snapShot.numberOfSections == 0 {
            snapShot.appendSections([.home])
        }
        snapShot.appendItems(viewModel?.getTaskList() ?? [], toSection: .home)
        DispatchQueue.main.async {
            self.dataSource.apply(snapShot, animatingDifferences: true)
        }
    }
}

extension HomeVC: HomeVMDelegate {
    func reloadData() {
        reloadSnapShot()
    }
}

extension HomeVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.frame.width, height: 200)
    }
}

extension HomeVC: CustomBottomBarDelegate {
    func onAddButtonClick() {
        let mainStory = UIStoryboard.init(name: "Main", bundle: .main)
      
        if let vc = UIStoryboard.instantiateViewController(mainStory)(withIdentifier: "AddNewTaskVC") as? AddNewTaskVC {
            vc.delegate = self
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension HomeVC: AddNewTaskVCDelegate {
    func saveData(data: [AddNewTaskVM.TaskSections : AddNewTaskVM.Items], view: UIViewController) {
        self.navigationController?.popViewController(animated: true)
        viewModel?.modifyTaskList(data: data)
    }
}

 

 

