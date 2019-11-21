//
//  DetailViewController.swift
//  MovieDBViewer
//
//  Created by Ian McDonald on 01/10/19.
//  Copyright © 2019 Ian McDonald. All rights reserved.
//

import UIKit

final class DetailViewController: UIViewController {
    //MARK: Outlets
    @IBOutlet weak var TitleLabel: UILabel!
    @IBOutlet weak var MainImageView: UIImageView!
    @IBOutlet weak var OverviewTitle: UILocalizedLabel!
    @IBOutlet weak var OverviewLabel: UILabel!
    @IBOutlet weak var DateTitle: UILocalizedLabel!
    @IBOutlet weak var DateLabel: UILabel!
    @IBOutlet weak var GenreTitle: UILocalizedLabel!
    @IBOutlet weak var GenreLabel: UILabel!
    @IBOutlet weak var LanguageTitle: UILocalizedLabel!
    @IBOutlet weak var LanguageLabel: UILabel!
    @IBOutlet weak var AverageVoteTitle: UILocalizedLabel!
    @IBOutlet weak var AverageVoteLabel: UILabel!
    @IBOutlet weak var BackButton: UILocalizedButton!
    @IBOutlet weak var BackButtonHeightConstraint: NSLayoutConstraint!
    
    //MARK: Public Vars
    var movie: Show?
    var genres = [Int:String]()
    var languages = [String:String]()
    var tabBarHeight: CGFloat = 0
    
    //MARK: Override Funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupImageShadow()
    }
    
    //MARK: Actions
    @IBAction func onBackButtonPushed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
