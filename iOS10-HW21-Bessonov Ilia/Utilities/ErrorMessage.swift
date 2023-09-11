//
//  ErrorMessage.swift
//  iOS10-HW21-Bessonov Ilia
//
//  Created by i0240 on 30.08.2023.
//

import Foundation

enum ErrorMessage: String, Error {
    case unableToComplete = "Unable to complete your request. Please check your internet connection."
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "The data received from the server was invalid. Please try again."
}
