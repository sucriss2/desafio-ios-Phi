//
//  ViewController.swift
//  Desafio_Somosphi
//
//  Created by Suh on 02/08/22.
//

import UIKit

class ExtractViewController: UIViewController {

    @IBOutlet weak var textBalanceLabel: UILabel!
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var movement: UILabel!
    @IBOutlet weak var tableView: UITableView!

    weak var coordinator: ExtractCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
        // let color = UIColor(named: "action")
    }

}
