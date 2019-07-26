//
//  Networking.swift
//  YPGardens
//
//  Created by Tony Cioara on 7/25/19.
//  Copyright © 2019 Tony Cioara. All rights reserved.
//

import Foundation
import Starscream
import KeychainSwift

enum Sender: String {
    case app = "app"
    case pi = "pi"
    case server = "server"
}

enum Command: String {
    case waterLevelChanged = "water_level_changed"
    case plantFinishedWatering = "plant_finished_watering"
    case waterPlant = "water_plant"
    case dataRequest = "data_request"
    case data = "data"
    case error = "error"
    case register = "register"
}

protocol NetworkingDelegate {
    func didUpdateWaterLevels(waterLevels: [WaterLevelUpdate])
}

class Networking {
    static let shared = Networking()
    let socket = WebSocket(url: URL(string:"ws://52.53.195.201:8080")!)
    let keychain = KeychainSwift()
    var waterLevels = [WaterLevelUpdate]() {
        didSet {
            if let delegate = self.delegate {
                delegate.didUpdateWaterLevels(waterLevels: self.waterLevels)
            }
        }
    }
    var delegate: NetworkingDelegate?
    
    init() {
        socket.delegate = self
    }
    
    func send(sender: Sender, command: Command, value: String? = nil) -> Bool {
        if !socket.isConnected {
            return false
        }
        let sm = formatMessage(sender: sender, command: command, value: value)
        socket.write(string: sm)
        return true
    }
    
    func connect() {
        if !socket.isConnected {
            socket.connect()
        }
    }
    
    func disconnect() {
        if !socket.isConnected {
            socket.disconnect()
        }
    }
    
    private func formatMessage(sender: Sender, command: Command, value: String? = nil) -> String {
        var valueString = ""
        if let value = value {
            valueString += "|" + value
        }
        return sender.rawValue + "|" + command.rawValue + valueString
    }
}

extension Networking: WebSocketDelegate {
    
    func websocketDidConnect(socket: WebSocketClient) {
        print("websocket is connected")
        guard let _ = keychain.getBool("did_register") else {
            keychain.set(true, forKey: "did_register")
            send(sender: .app, command: .register)
            return
        }
        _ = send(sender: .app, command: .dataRequest)
    }
    
    func websocketDidDisconnect(socket: WebSocketClient, error: Error?) {
        print("websocket is disconnected")
    }
    
    func websocketDidReceiveMessage(socket: WebSocketClient, text: String) {
        print("websocket received message: ", text)
        let components = text.split(separator: "|")
        if let sender = Sender(rawValue: String(components[0])),
            let command = Command(rawValue: String(components[1])){
            
            switch command {
            case .error:
                print("error getting data: ", text)
            case .register:
                _ = send(sender: .app, command: .dataRequest)
            case .data:
                if components.count <= 2 {
                    return
                }
                guard let data = String(components[2]).data(using: .utf8) else {
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .millisecondsSince1970
                    let waterLevels = try decoder.decode([WaterLevelUpdate].self, from: data)
                    self.waterLevels = waterLevels
                } catch let error as NSError {
                    print("ERROR: ", error)
                }
            default:
                return
            }
        }
        
    }
    
    func websocketDidReceiveData(socket: WebSocketClient, data: Data) {
        print("websocket received data")
    }
}
