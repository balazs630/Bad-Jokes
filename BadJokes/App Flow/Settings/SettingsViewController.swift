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

    // MARK: Properties
    var pckTimeHours = String()
    var pckTimeMinutes = String()
    var lblTimeOptionName = String()

    let defaults = UserDefaults.standard
    var preferencesSnapshot = String()
    weak var delegate: SettingsViewControllerDelegate?

    let jokeNotificationService = JokeNotificationService()
    let notificationSettingsIndexPath = IndexPath(item: 0, section: 0)
    var isNotificationEnabled: Bool = false

    // MARK: Outlets
    @IBOutlet weak var notificationWarningImage: UIImageView!
    @IBOutlet weak var swGlobalOff: UISwitch!

    @IBOutlet weak var lblPeriodicity: UILabel!
    @IBOutlet weak var lblRecurrence: UILabel!
    @IBOutlet weak var lblTime: UILabel!

    @IBOutlet var sldJokeTypeCollection: [UISlider]!

    // MARK: Initializers
    deinit {
        NotificationCenter.default.removeObserver(self,
                                                  name: UIApplication.didBecomeActiveNotification,
                                                  object: nil)
    }

    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        loadPreferences()
        updateUIElementsBasedOnGlobalDisablerSwitchState()
        preferencesSnapshot = getActualPreferences()
        setObserverForUIApplicationDidBecomeActive()
        updateTableHeaderView()
    }

    override func viewWillAppear(_ animated: Bool) {
        checkAppNotificationEnabledStatus()
    }

    // MARK: - Actions
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
            jokeNotificationService.removeAllScheduledNotification()
        }
    }
}

// MARK: - Setup
extension SettingsViewController {
    private func updateUIElementsBasedOnGlobalDisablerSwitchState() {
        // If this switch is on, all settings are disabled
        let swGlobalState = !swGlobalOff.isOn
        tableView.allowsSelection = !swGlobalOff.isOn

        lblPeriodicity.isEnabled = swGlobalState
        lblRecurrence.isEnabled = swGlobalState
        lblTime.isEnabled = swGlobalState

        sldJokeTypeCollection.forEach {
            $0.isEnabled = swGlobalState
        }
    }

    private func setObserverForUIApplicationDidBecomeActive() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(checkAppNotificationEnabledStatus),
                                               name: UIApplication.didBecomeActiveNotification,
                                               object: nil)
    }

    @objc private func checkAppNotificationEnabledStatus() {
        jokeNotificationService.isNotificationsEnabled { state in
            self.isNotificationEnabled = state
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    private func updateTableHeaderView() {
        if DBService.shared.unusedJokesCount() == 0 {
            tableView.tableHeaderView = UIView.loadFromNib(named: UIView.warningTableHeaderView)
        }
    }
}

// MARK: Application preferences read/write
extension SettingsViewController {
    private func isEligibleForSave() -> Bool {
        if swGlobalOff.isOn {
            return false
        }

        if DBService.shared.isSchedulesListEmpty() {
            return true
        }

        return isPreferencesChanged()
    }

    private func isPreferencesChanged() -> Bool {
        return preferencesSnapshot != getActualPreferences()
    }

    private func getActualPreferences() -> String {
        var sliderValues  = ""
        sldJokeTypeCollection.forEach {
            sliderValues.append(String($0.value))
        }

        return """
        \(String(describing: lblPeriodicity.text)) + \(String(describing: lblRecurrence.text))
        + \(String(describing: lblTime.text)) + \(sliderValues)
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

        sldJokeTypeCollection.forEach {
            $0.value = defaults.float(forKey: Constant.sliders[$0.tag]!)
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

        sldJokeTypeCollection.forEach {
            defaults.set($0.value, forKey: Constant.sliders[$0.tag]!)
            defaults.synchronize()
        }
    }
}

// MARK: - Navigation
extension SettingsViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard tableView.indexPathForSelectedRow != nil else { return }
        guard segue.identifier != nil else { return }

        switch segue.identifier {
        case SegueIdentifier.periodicityDetail:
            guard let destVC = segue.destination as? PeriodicityViewController else { return }
            if let lblPeriodicityText = lblPeriodicity.text {
                destVC.lastSelectedOption = lblPeriodicityText
            }
            destVC.delegate = self
        case SegueIdentifier.recurrenceDetail:
            guard let destVC = segue.destination as? RecurrenceViewController else { return }
            if let lblRecurrenceText = lblRecurrence.text {
                destVC.lastSelectedOption = lblRecurrenceText
            }
            destVC.delegate = self
        case SegueIdentifier.timeDetail:
            guard let destVC = segue.destination as? TimeViewController else { return }
            destVC.lastSelectedOption = lblTimeOptionName

            let calendar = Calendar(identifier: .gregorian)
            var timeComponents = calendar.dateComponents([.hour, .minute], from: Date())
            timeComponents.hour = Int(pckTimeHours)
            timeComponents.minute = Int(pckTimeMinutes)

            destVC.lastSelectedTime = calendar.date(from: timeComponents)!
            destVC.delegate = self
        default:
            debugPrint("Unexpected segue identifier was given in: \(#file), line: \(#line)")
        }
    }

    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return !swGlobalOff.isOn
    }
}

// MARK: TableViewDelegate
extension SettingsViewController {
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell,
                            forRowAt indexPath: IndexPath) {
        if indexPath.section == notificationSettingsIndexPath.section
            && indexPath.row == notificationSettingsIndexPath.row {
            notificationWarningImage.isHidden = isNotificationEnabled
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath == notificationSettingsIndexPath {
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
        }
    }
}

// MARK: PeriodicityViewControllerDelegate
extension SettingsViewController: PeriodicityViewControllerDelegate {
    func savePeriodicityWith(selectedCellText: String) {
        lblPeriodicity.text = selectedCellText
    }
}

// MARK: TimeViewControllerDelegate
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

// MARK: RecurrenceViewControllerDelegate
extension SettingsViewController: RecurrenceViewControllerDelegate {
    func saveRecurrenceWith(selectedCellText: String) {
        lblRecurrence.text = selectedCellText
    }
}
