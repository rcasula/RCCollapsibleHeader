//
//  ViewController.swift
//  RCCollapsibleHeader
//
//  Created by Roberto Casula on 11/10/2018.
//  Copyright (c) 2018 Roberto Casula. All rights reserved.
//

import UIKit
import RCCollapsibleHeader
import SwifterSwift


class ViewController: UIViewController {
    
    @IBOutlet weak var todaysDateLabel: UILabel!
    @IBOutlet weak var welcomeUserLabel: UILabel!
    
    @IBOutlet var bottomHeaderView: CollapsingHeaderView!
    @IBOutlet weak var bottomStackView: UIStackView!
    @IBOutlet weak var todayLabel: UILabel!
    @IBOutlet weak var deadlinesButton: UIButton!
    

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var headerView: CollapsingHeaderView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        self.bottomHeaderView.maxHeight = 0
        
        setupViews()
        
        SwifterSwift.delay(milliseconds: 2000) {
            self.todayLabel.text = "Lorem ipsum\nCiao\nCiao\nCiao"
            self.animateUserContentAppearance()
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func setupViews() {
//        guard let user = Persistence.loggedUser
//            else { return }
        let date = Date()
        todaysDateLabel.text = date.dateString(ofStyle: .full)
        welcomeUserLabel.text = "Ciao Roberto"
    }
    
    
    func animateUserContentAppearance() {
        UIView.animate(withDuration: 0.25, animations: { [weak self] in
            self?.bottomStackView.isHidden = false
            self?.todayLabel.isHidden = self?.todayLabel.text == nil
            self?.deadlinesButton.isHidden = false
            
            self?.todayLabel.sizeToFit()
            self?.bottomStackView.layoutIfNeeded()
            
            let minHeight = self?.deadlinesButton.bounds.height ?? 0
            let bottomHeight = self?.bottomStackView.bounds.height ?? 0
            self?.bottomHeaderView.minHeight = minHeight + 16
            self?.bottomHeaderView.maxHeight = bottomHeight + 16
            
        }, completion: { [weak self] _ in
            
            UIView.animate(withDuration: 0.25, animations: { [weak self] in
                self?.deadlinesButton.alpha = 1
                self?.todayLabel.alpha = 1
            })
        })
    }
}

extension ViewController: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        bottomHeaderView?.collapseHeaderView(using: scrollView)
        
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }
}
