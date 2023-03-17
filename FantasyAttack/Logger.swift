//
//  Logger.swift
//  FantasyAttack
//
//  Created by oussama Hichri on 17/3/2023.
//

import Foundation


class Logger {
    enum LogLevel {
        case debug
        case info
        case warning
        case error
    }

    private static func log(level: LogLevel, message: String) {
        let levelString: String
        switch level {
        case .debug:
            levelString = "DEBUG"
        case .info:
            levelString = "INFO"
        case .warning:
            levelString = "WARNING"
        case .error:
            levelString = "ERROR"
        }
        print("[\(levelString)] \(message)")
    }

    static func debug(_ message: String) {
        log(level: .debug, message: message)
    }

    static func info(_ message: String) {
        log(level: .info, message: message)
    }

    static func warning(_ message: String) {
        log(level: .warning, message: message)
    }

    static func error(_ message: String) {
        log(level: .error, message: message)
    }
}
