//
//  DetailViewController.swift
//  MovieTec
//
//  Created by Furry Ruiz on 26/02/23.
//

import UIKit

class DetailViewController: UIViewController {

    var id: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func loadView() {
        self.view = DetailView(viewModel: DetailViewModel(), id: id!)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
