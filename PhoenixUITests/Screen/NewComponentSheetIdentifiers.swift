import AccessibilityIdentifiers
import XCTest

class NewComponentSheet: Screen {
    var givenNameTextField: XCUIElement {
        Screen.app.textFields[NewComponentSheetIdentifiers.givenNameTextField.identifier]
    }
    var familyNameTextField: XCUIElement {
        Screen.app.textFields[NewComponentSheetIdentifiers.familyNameTextField.identifier]
    }
    var cancelButton: XCUIElement {
        Screen.app.buttons[NewComponentSheetIdentifiers.cancelButton.identifier]
    }
    var createButton: XCUIElement {
        Screen.app.buttons[NewComponentSheetIdentifiers.createButton.identifier]
    }
    
    @discardableResult
    func type(givenName: String) -> NewComponentSheet {
        givenNameTextField.click()
        givenNameTextField.typeText(givenName)
        return NewComponentSheet()
    }
    
    @discardableResult
    func type(familyName: String) -> NewComponentSheet {
        familyNameTextField.click()
        familyNameTextField.typeText(familyName)
        return NewComponentSheet()
    }
    
    @discardableResult
    func type(givenName: String, familyName: String) -> NewComponentSheet {
        self
            .type(givenName: givenName)
            .type(familyName: familyName)
        return self
    }
    
    @discardableResult
    func clickCreate() -> Screen {
        createButton.click()
        return Screen()
    }
    
    func clickCancel() -> Screen {
        cancelButton.click()
        return Screen()
    }
}