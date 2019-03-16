//
//  ViewController.swift
//  WQStretchHeader
//
//  Created by 王伟奇 on 2019/3/16.
//  Copyright © 2019 王伟奇. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    /// 图片比例
    private let proportion: CGFloat = 3888.00 / 2592.00
    private let navBar = WQStretchNavBar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.navHeight))
    
    private var headerImageV = UIImageView()
    private var headerImageVFrame = CGRect.zero
    private var tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        headerImageVFrame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.width / proportion)
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .red
        headerImageV.frame = headerImageVFrame
        headerImageV.image = UIImage(named: "tree_image")
        
        setupTable()
        view.addSubview(headerImageV)
        view.addSubview(tableView)
        view.addSubview(navBar)
    }
    
    private func setupTable() {
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.estimatedRowHeight = 0;
        tableView.estimatedSectionHeaderHeight = 0;
        tableView.estimatedSectionFooterHeight = 0;
        tableView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        tableView.bounds.origin = CGPoint.zero
        let headerVHeight = (view.bounds.width / proportion)
        let headerV = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: headerVHeight))
        headerV.alpha = 0
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableHeaderView = headerV
        tableView.backgroundColor = .clear
        tableView.register(CustomCell.self, forCellReuseIdentifier: "Cell")
    }

}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        print(offsetY)
        
        if offsetY < 0 {   ///拉出图片高度
            var originFrame = headerImageVFrame
            originFrame.size.height -= offsetY
            originFrame.size.width = originFrame.size.height * proportion
            originFrame.origin.x -= (originFrame.size.width - headerImageVFrame.size.width) / 2
            self.headerImageV.frame = originFrame
            
        }
        /// 图片被完全遮住
        let showImageHeight = headerImageV.frame.height - navBar.frame.height
        
        if offsetY > 0 {
            let alpha = offsetY / showImageHeight
            navBar.backgroundColor = UIColor.white.withAlphaComponent(alpha)
            navBar.titleColor = alpha >= 1 ? .black : .white
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomCell
        cell.title = "第几" + indexPath.row.description + "行"
        cell.backgroundColor = .white
        return cell
    }
}

class CustomCell: UITableViewCell {
    var title: String? {
        didSet {
            lable.text = title
        }
    }
    
    let lable: UILabel = {
        let lb = UILabel(frame: CGRect(x: 20, y: 8, width: 200, height: 30))
        lb.textColor = .black
        return lb
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(lable)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

