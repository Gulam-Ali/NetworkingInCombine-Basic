//
//  ViewController.swift
//  Networking-Combine
//
//  Created by apple on 30/03/23.
//

import UIKit
import Combine

class ViewController: UIViewController {

    @IBOutlet weak var tblview: UITableView!
    
    private let service = webservice()
    private var cancellable : AnyCancellable?
    private var posts = [Posts](){
        didSet{
            self.tblview.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tblview.delegate = self
        tblview.dataSource = self
        tblview.tableFooterView = UIView()
        
        self.cancellable = self.service.getPosts()
            .catch{ _ in Just([Posts]())}
            .assign(to: \.posts, on: self)
    }
    
}

extension ViewController : UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell") as! postCell
        cell.textLabel?.text = posts[indexPath.row].title   
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
}

