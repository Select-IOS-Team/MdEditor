// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable all

public enum L10n {

  public enum AlertController {

    public enum Action {

      public enum Cancel {
        /// Cancel
        public static let title = L10n.tr("Localizable", "AlertController.Action.Cancel.Title")
      }

      public enum Create {
        /// Create
        public static let title = L10n.tr("Localizable", "AlertController.Action.Create.Title")
      }
    }
  }

  public enum AuthScene {
    /// Enter login
    public static let loginTextFieldPlaceholder = L10n.tr("Localizable", "AuthScene.loginTextFieldPlaceholder")
    /// Enter password
    public static let passwordTextFieldPlaceholder = L10n.tr("Localizable", "AuthScene.passwordTextFieldPlaceholder")
    /// Sign in
    public static let signInButtonTitle = L10n.tr("Localizable", "AuthScene.signInButtonTitle")

    public enum AlertActions {
      /// Error
      public static let error = L10n.tr("Localizable", "AuthScene.AlertActions.Error")
      /// OK
      public static let ok = L10n.tr("Localizable", "AuthScene.AlertActions.OK")
    }
  }

  public enum StartScene {
    /// Main
    public static let title = L10n.tr("Localizable", "StartScene.Title")

    public enum MenuItem {

      public enum AboutApp {
        /// About Markdown Editor
        public static let title = L10n.tr("Localizable", "StartScene.MenuItem.AboutApp.Title")
      }

      public enum NewFile {
        /// New file
        public static let title = L10n.tr("Localizable", "StartScene.MenuItem.NewFile.Title")
      }

      public enum OpenFile {
        /// Open file
        public static let title = L10n.tr("Localizable", "StartScene.MenuItem.OpenFile.Title")
      }
    }

    public enum NewFileAlert {
      /// New file
      public static let title = L10n.tr("Localizable", "StartScene.NewFileAlert.Title")

      public enum TextField {
        /// Enter file name
        public static let placeholder = L10n.tr("Localizable", "StartScene.NewFileAlert.TextField.Placeholder")
      }
    }
  }
}

extension L10n {
private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
return String(format: format, locale: Locale.current, arguments: args)
}
}

private final class BundleToken {}
// swiftlint:enable all
