import Cocoa

public class TimePicker: NSDatePicker {
    public var onChange: ((Date) -> Void)?
    
    public init(date: Date = .now, showStepper: Bool = true, showSeconds: Bool = true, onChange: ((Date) -> Void)? = nil) {
        self.onChange = onChange

        super.init(frame: .zero)

        self.datePickerStyle = showStepper ? .textFieldAndStepper : .textField
        self.datePickerMode = .single
        self.datePickerElements = showSeconds ? .hourMinuteSecond : .hourMinute

        self.dateValue = date
        
        self.target = self
        self.action = #selector(buttonAction)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public var showStepper: Bool {
        get { datePickerStyle == .textFieldAndStepper }
        set {
            datePickerStyle = newValue ? .textFieldAndStepper : .textField
        }
    }

    public var showSeconds: Bool {
        get { datePickerElements == .hourMinuteSecond }
        set {
            datePickerElements = newValue ? .hourMinuteSecond : .hourMinute
        }
    }
    
    // MARK: - Actions

    @objc func buttonAction(_ datePicker: NSDatePicker) {
        onChange?(datePicker.dateValue)
    }
}
