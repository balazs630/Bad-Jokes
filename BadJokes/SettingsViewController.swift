//
//  SettingsViewController.swift
//  BadJokes
//
//  Created by Horváth Balázs on 2017. 07. 21..
//  Copyright © 2017. Horváth Balázs. All rights reserved.
//

import UIKit

protocol SettingsViewControllerDelegate: class {
    func startJokeGeneratingProcess()
}

class SettingsViewController: UITableViewController {

    @IBOutlet weak var swGlobalOff: UISwitch!

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

    // For time picker components
    var pckTimeHours = String()
    var pckTimeMinutes = String()
    var lblTimeOptionName = String()

    // Slider IBOutlets and it's UserDefault keys
    var sldCollection: [UISlider: String] {
        return [
            sldAnimal: UserDefaults.Key.Sld.animal,
            sldRough: UserDefaults.Key.Sld.rough,
            sldIT: UserDefaults.Key.Sld.IT,
            sldAnti: UserDefaults.Key.Sld.anti,
            sldTiring: UserDefaults.Key.Sld.tiring,
            sldJean: UserDefaults.Key.Sld.jean,
            sldMoriczka: UserDefaults.Key.Sld.moriczka,
            sldCop: UserDefaults.Key.Sld.cop,
            sldBlonde: UserDefaults.Key.Sld.blonde
        ]
    }

    var preferencesSnapshot = String()
    let defaults = UserDefaults.standard
    weak var delegate: SettingsViewControllerDelegate?

    let dbManager = DBManager()
    let jokeNotificationHelper = JokeNotificationHelper()
    let notificationWarningIndexPath = IndexPath(item: 0, section: 0)
    var isNotificationEnabled: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        loadPreferences()
        updateUIElementsBasedOnGlobalDisablerSwitchState()
        preferencesSnapshot = getActualPreferences()

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(checkNotificationStatus),
                                               name: NSNotification.Name.UIApplicationDidBecomeActive,
                                               object: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        checkNotificationStatus()
    }

    @IBAction func closeSettings(_ sender: Any) {
        if isEligibleForSave() {
            saveJokePreferences()
            delegate?.startJokeGeneratingProcess()
        }

        saveGeneralPreferences()
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func swGlobalOnOffDidChange(_ sender: Any) {
        updateUIElementsBasedOnGlobalDisablerSwitchState()

        if swGlobalOff.isOn {
            jokeNotificationHelper.removeAllPendingNotificationRequests()
        }
    }

    @IBAction func openAppNotificationSettings(_ sender: Any) {
        UIApplication.shared.open(URL(string: "App-Prefs:root=NOTIFICATIONS_ID")!, options: [:], completionHandler: nil)
    }

    private func isEligibleForSave() -> Bool {
        if isGlobalDisablerSwitchOn() {
            return false
        }

        if dbManager.isSchedulesListEmpty() {
            return true
        }

        return isPreferencesChanged()
    }

    private func isPreferencesChanged() -> Bool {
        return preferencesSnapshot != getActualPreferences()
    }

    private func getActualPreferences() -> String {
        return """
        \(String(describing: lblPeriodicity.text)) + \(String(describing: lblRecurrence.text))
        + \(String(describing: lblTime.text)) + \(sldAnimal.value) + \(sldRough.value)
        + \(sldIT.value) \(sldAnti.value) \(sldTiring.value)
        + \(sldJean.value) \(sldMoriczka.value) \(sldCop.value) \(sldBlonde.value)
        """
    }

    private func loadPreferences() {
        swGlobalOff.isOn = defaults.bool(forKey: UserDefaults.Key.Sw.globalOff)

        lblPeriodicity.text = defaults.string(forKey: UserDefaults.Key.Lbl.periodicity)
        lblRecurrence.text = defaults.string(forKey: UserDefaults.Key.Lbl.recurrence)

        if let hours = defaults.string(forKey: UserDefaults.Key.Pck.timeHours),
            let minutes = defaults.string(forKey: UserDefaults.Key.Pck.timeMinutes) {
            pckTimeHours = hours
            pckTimeMinutes = minutes
        }

        if defaults.string(forKey: UserDefaults.Key.Lbl.time) == Time.atGivenTime {
            lblTime.text = "Pontosan \(pckTimeHours):\(pckTimeMinutes)-kor"
            lblTimeOptionName = Time.atGivenTime
        } else {
            lblTime.text = defaults.string(forKey: UserDefaults.Key.Lbl.time)
            if let text = defaults.string(forKey: UserDefaults.Key.Lbl.time) {
                lblTimeOptionName = text
            }
        }

        for item in sldCollection {
            item.key.value = defaults.float(forKey: item.value)
        }
    }

    private func saveGeneralPreferences() {
        defaults.set(swGlobalOff.isOn, forKey: UserDefaults.Key.Sw.globalOff)
        defaults.synchronize()
    }

    private func saveJokePreferences() {
        defaults.set(lblPeriodicity.text, forKey: UserDefaults.Key.Lbl.periodicity)
        defaults.set(lblRecurrence.text, forKey: UserDefaults.Key.Lbl.recurrence)
        defaults.set(lblTimeOptionName, forKey: UserDefaults.Key.Lbl.time)

        defaults.set(pckTimeHours, forKey: UserDefaults.Key.Pck.timeHours)
        defaults.set(pckTimeMinutes, forKey: UserDefaults.Key.Pck.timeMinutes)
        defaults.synchronize()

        for item in sldCollection {
            defaults.set(item.key.value, forKey: item.value)
            defaults.synchronize()
        }
    }

    private func updateUIElementsBasedOnGlobalDisablerSwitchState() {
        // If this switch is on, all settings are disabled
        let swGlobalState = !swGlobalOff.isOn

        lblPeriodicity.isEnabled = swGlobalState
        lblRecurrence.isEnabled = swGlobalState
        lblTime.isEnabled = swGlobalState

        for item in sldCollection {
            item.key.isEnabled = swGlobalState
        }
    }

    private func isGlobalDisablerSwitchOn() -> Bool {
        return swGlobalOff.isOn ? true : false
    }

    @objc private func checkNotificationStatus() {
        jokeNotificationHelper.isNotificationsEnabled { state in
            self.isNotificationEnabled = state
        }

        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // Hide notification warning cell if the notifications are turned on
        if indexPath.section == notificationWarningIndexPath.section
            && indexPath.row == notificationWarningIndexPath.row {
            cell.isHidden = isNotificationEnabled
        }
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // Set notification warning row height to 0 if the notifications are turned on
        if isNotificationEnabled {
            if indexPath.section == notificationWarningIndexPath.section
                && indexPath.row == notificationWarningIndexPath.row {
                return 0
            }
        }

        return super.tableView(tableView, heightForRowAt: indexPath)
    }

    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return isGlobalDisablerSwitchOn() ? false : true
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if tableView.indexPathForSelectedRow != nil {
            if let segueIdentifier = segue.identifier {

                switch segueIdentifier {
                case SegueIdentifier.periodicityDetail:
                    let destVC = segue.destination as! PeriodicityViewController
                    if let lblPeriodicityText = lblPeriodicity.text {
                        destVC.lastSelectedOption = lblPeriodicityText
                    }
                    destVC.delegate = self
                case SegueIdentifier.recurrenceDetail:
                    let destVC = segue.destination as! RecurrenceViewController
                    if let lblRecurrenceText = lblRecurrence.text {
                        destVC.lastSelectedOption = lblRecurrenceText
                    }
                    destVC.delegate = self
                case SegueIdentifier.timeDetail:
                    let destVC = segue.destination as! TimeViewController
                    destVC.lastSelectedOption = lblTimeOptionName

                    let calendar = Calendar(identifier: .gregorian)
                    var timeComponents = calendar.dateComponents([.hour, .minute], from: Date())
                    timeComponents.hour = Int(pckTimeHours)
                    timeComponents.minute = Int(pckTimeMinutes)

                    destVC.lastSelectedTime = calendar.date(from: timeComponents)!
                    destVC.delegate = self
                default:
                    print("Unexpected segue identifier was given in: \(#file), line: \(#line)")
                }
            }
        }
    }

    deinit {
        // Remove the observer when this view controller is dismissed/deallocated
        NotificationCenter.default.removeObserver(self,
                                                  name: NSNotification.Name.UIApplicationDidBecomeActive,
                                                  object: nil)
    }

}

// MARK: Protocol conformances
extension SettingsViewController: PeriodicityViewControllerDelegate {
    func savePeriodicityWith(selectedCellText: String) {
        lblPeriodicity.text = selectedCellText
    }
}

extension SettingsViewController: TimeViewControllerDelegate {
    func saveTimeWithSelected(cellText: String) {
        lblTimeOptionName = cellText
        lblTime.text = cellText
    }

    func saveTimeWithSelected(cellText: String, hours: String, minutes: String) {
        lblTime.text = "Pontosan \(hours):\(minutes)-kor"
        lblTimeOptionName = cellText
        pckTimeHours = hours
        pckTimeMinutes = minutes
    }
}

extension SettingsViewController: RecurrenceViewControllerDelegate {
    func saveRecurrenceWith(selectedCellText: String) {
        lblRecurrence.text = selectedCellText
    }
}
