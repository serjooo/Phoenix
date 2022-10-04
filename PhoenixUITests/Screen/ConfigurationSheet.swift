import AccessibilityIdentifiers
import XCTest

class ConfigurationSheet: Screen {
    var addNewButton: XCUIElement {
        Screen.app.buttons[AccessibilityIdentifiers.ConfigurationSheet.addNewButton.identifier]
    }
    
    var closeButton: XCUIElement {
        Screen.app.buttons[AccessibilityIdentifiers.ConfigurationSheet.closeButton.identifier]
    }
    
    func textField(column: Int, row: Int) -> XCUIElement {
        Screen.app.textFields[
            AccessibilityIdentifiers.ConfigurationSheet.textField(
                column: column,
                row: row
            ).identifier
        ]
    }
    
    @discardableResult
    func addNew() -> ConfigurationSheet {
        addNewButton.click()
        return self
    }
    
    @discardableResult
    func close() -> Screen {
        closeButton.click()
        return Screen()
    }
    
    @discardableResult
    func type(text: String, column: Int, row: Int) -> ConfigurationSheet {
        let cell = textField(column: column, row: row)
        cell.click()
        cell.typeKey("a", modifierFlags: .command)
        cell.typeText(text)
        return self
    }
}
