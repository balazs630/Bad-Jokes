//
//  SettingsViewController.swift
//  BadJokes
//
//  Created by Horváth Balázs on 2017. 07. 21..
//  Copyright © 2017. Horváth Balázs. All rights reserved.
//

import UIKit

protocol SettingsViewControllerDelegate: class {
    func updateSettings()
}

class SettingsViewController: UITableViewController, PeriodicityViewControllerDelegate, RecurrenceViewControllerDelegate, TimeViewControllerDelegate {

    @IBOutlet weak var swGlobalOnOff: UISwitch!
    @IBOutlet weak var swNotificationSound: UISwitch!

    @IBOutlet weak var lblPeriodicity: UILabel!
    @IBOutlet weak var lblRecurrence: UILabel!
    @IBOutlet weak var lblTime: UILabel!

    @IBOutlet weak var sldAnimal: UISlider!
    @IBOutlet weak var sldRough: UISlider!
    @IBOutlet weak var sldIT: UISlider!
    @IBOutlet weak var sldAnti: UISlider!
    @IBOutlet weak var sldTiring: UISlider!
    @IBOutlet weak var sldJean: UISlider!
    @IBOutlet weak var sldMoriczka: UISlider!
    @IBOutlet weak var sldCop: UISlider!
    @IBOutlet weak var sldBlonde: UISlider!

    weak var delegate: SettingsViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
    }

    @IBAction func closeSettings(_ sender: Any) {
        delegate?.updateSettings()
        self.navigationController?.popViewController(animated: true)
    }

    func savePeriodicityWith(selectedCellText: String) {
        lblPeriodicity.text = selectedCellText
    }

    func saveRecurrenceWith(selectedCellText: String) {
        lblRecurrence.text = selectedCellText
    }

    func saveTimeWith(selectedCellText: String) {
        lblTime.text = selectedCellText
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if tableView.indexPathForSelectedRow != nil {
            if let segueIdentifier = segue.identifier {

                switch segueIdentifier {
                case "periodityDetailSegue":
                    let destVC = segue.destination as! PeriodicityViewController
                    destVC.lastSelectedIndexPath = IndexPath(item: 0, section: 0)
                    destVC.delegate = self
                case "recurrenceDetailSegue":
                    let destVC = segue.destination as! RecurrenceViewController
                    destVC.lastSelectedIndexPath = IndexPath(item: 0, section: 0)
                    destVC.delegate = self
                case "timeDetailSegue":
                    let destVC = segue.destination as! TimeViewController
                    destVC.lastSelectedIndexPath = IndexPath(item: 0, section: 0)
                    destVC.delegate = self
                default:
                    print("Unexpected segue identifier was given in: \(#file), line: \(#line)")
                }
            }
        }
    }

}
