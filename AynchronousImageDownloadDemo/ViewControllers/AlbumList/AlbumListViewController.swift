//
//  AlbumListViewController.swift
//  AynchronousImageDownloadDemo
//
//  Created by Prajakta on 27/04/23.
//

import UIKit

class AlbumListViewController: UIViewController {
    
    @IBOutlet weak var albumListTblView: UITableView!
    var albumViewModel = AlbumViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpViewController()
        self.getAlbumList(urlString: Application.URLs.getAlbumList)
    }
    
    init(model: AlbumViewModel) {
        self.albumViewModel = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setUpViewController() {
        self.navigationItem.title = AppStrings.albumList
        albumListTblView.register(UINib.init(nibName: "AlbumListTableViewCell",                             bundle: nil),
                                  forCellReuseIdentifier: "AlbumListTableViewCell")
    }
    
    func getAlbumList(urlString: String) {
        self.albumViewModel.callAlbumListAPI(urlString: urlString) {
            DispatchQueue.main.async {
                self.albumListTblView.reloadData()
            }
        }
    }
}

extension AlbumListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return self.albumViewModel.arrAlbum.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath)  -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumListTableViewCell") as! AlbumListTableViewCell
        let album = self.albumViewModel.arrAlbum[indexPath.row]
        cell.setUpCell(album: album)
        return cell
    }
}
