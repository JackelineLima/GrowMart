//
//  MartStrings.swift
//  Mart
//
//  Created by Jackeline Pires De Lima on 27/09/22.
//

import Foundation

public enum MartStrings {

    public enum Localizable {

        ///  ENTRAR COM O FACEBOOK
        public static let loginWithFacebook = MartStrings.tr("Localizable", "login-with-facebook")
        ///  ENTRAR COM O GOOGLE
        public static let loginWithGoogle = MartStrings.trs("Localizable", "login-with-google")
    }
}

extension MartStrings {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
      let format = MartResources.bundle.localizedString(forKey: key, value: nil, table: table)
      return String(format: format, locale: Locale.current, arguments: args)
  }

    private static func trs(_ table: String, _ key: String, _ args: CVarArg...) -> String {
        let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
            return String(format: format, locale: Locale.current, arguments: args)
    }
}

private final class BundleToken {}
