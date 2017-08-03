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

    // Slider variables and it's UserDefaults keys
    var sldCollection: [UISlider:String] {
        return [
            sldAnimal: "sldAnimal",
            sldRough: "sldRough",
            sldIT: "sldIT",
            sldAnti: "sldAnti",
            sldTiring: "sldTiring",
            sldJean: "sldJean",
            sldMoriczka: "sldMoriczka",
            sldCop: "sldCop",
            sldBlonde: "sldBlonde"
        ]
    }

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

    @IBAction func swGlobalOnOffDidChange(_ sender: Any) {
        disablePreferencesOnGlobalSwitchOffState()
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

        for item in sldCollection {
            item.key.value = defaults.float(forKey: item.value)
        }

        disablePreferencesOnGlobalSwitchOffState()
    }

    func savePreferences() {
        defaults.set(swGlobalOnOff.isOn, forKey: "swGlobalOnOff")
        defaults.set(swNotificationSound.isOn, forKey: "swNotificationSound")

        defaults.set(lblPeriodicity.text, forKey: "lblPeriodicity")
        defaults.set(lblRecurrence.text, forKey: "lblRecurrence")
        defaults.set(lblTime.text, forKey: "lblTime")

        for item in sldCollection {
            defaults.set(item.key.value, forKey: item.value)
        }
        defaults.synchronize()
    }

    func disablePreferencesOnGlobalSwitchOffState() {
        // If this switch is off, no other preferences can be changed
        let swGlobalState = swGlobalOnOff.isOn

        swNotificationSound.isEnabled = swGlobalState

        lblPeriodicity.isEnabled = swGlobalState
        lblRecurrence.isEnabled = swGlobalState
        lblTime.isEnabled = swGlobalState

        for item in sldCollection {
            item.key.isEnabled = swGlobalState
        }
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
