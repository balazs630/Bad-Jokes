//
//  SettingsViewController.swift
//  BadJokes
//
//  Created by Horváth Balázs on 2017. 07. 21..
//  Copyright © 2017. Horváth Balázs. All rights reserved.
//

import UIKit

protocol SettingsViewControllerDelegate: class {
    func settingsDidClose()
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

    let defaults = UserDefaults.standard

    weak var delegate: SettingsViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        loadPreferences()
    }

    @IBAction func closeSettings(_ sender: Any) {
        savePreferences()
        delegate?.settingsDidClose()
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

    func loadPreferences() {
        swGlobalOnOff.isOn = defaults.bool(forKey: "swGlobalOnOff")
        swNotificationSound.isOn = defaults.bool(forKey: "swNotificationSound")

        lblPeriodicity.text = defaults.string(forKey: "lblPeriodicity")
        lblRecurrence.text = defaults.string(forKey: "lblRecurrence")
        lblTime.text = defaults.string(forKey: "lblTime")

        sldAnimal.value = defaults.float(forKey: "sldAnimal")
        sldRough.value = defaults.float(forKey: "sldRough")
        sldIT.value = defaults.float(forKey: "sldIT")
        sldAnti.value = defaults.float(forKey: "sldAnti")
        sldTiring.value = defaults.float(forKey: "sldTiring")
        sldJean.value = defaults.float(forKey: "sldJean")
        sldMoriczka.value = defaults.float(forKey: "sldMoriczka")
        sldCop.value = defaults.float(forKey: "sldCop")
        sldBlonde.value = defaults.float(forKey: "sldBlonde")
    }

    func savePreferences() {
        defaults.set(swGlobalOnOff.isOn, forKey: "swGlobalOnOff")
        defaults.set(swNotificationSound.isOn, forKey: "swNotificationSound")

        defaults.set(lblPeriodicity.text, forKey: "lblPeriodicity")
        defaults.set(lblRecurrence.text, forKey: "lblRecurrence")
        defaults.set(lblTime.text, forKey: "lblTime")

        defaults.set(sldAnimal.value, forKey: "sldAnimal")
        defaults.set(sldRough.value, forKey: "sldRough")
        defaults.set(sldIT.value, forKey: "sldIT")
        defaults.set(sldAnti.value, forKey: "sldAnti")
        defaults.set(sldTiring.value, forKey: "sldTiring")
        defaults.set(sldJean.value, forKey: "sldJean")
        defaults.set(sldMoriczka.value, forKey: "sldMoriczka")
        defaults.set(sldCop.value, forKey: "sldCop")
        defaults.set(sldBlonde.value, forKey: "sldBlonde")

        defaults.synchronize()
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
