//
//  Response.swift
//  Edge
//
//  Created by Tyler Fleming Cloutier on 6/26/16.
//
//

public struct Response: Serializable {
    
    public var version: Version
    public var status: Status
    public var rawHeaders: [String]
    public var body: [UInt8]
    public var storage: [String: Any] = [:]
    
    public var serialized: [UInt8] {
        var headerString = ""
        headerString += "HTTP/\(version.major).\(version.minor)"
        headerString += " \(status.statusCode) \(status.reasonPhrase)"
        headerString += "\n"
        
        let headerPairs: [(String, String)] = stride(from: 0, to: rawHeaders.count, by: 2).map {
            let chunk = rawHeaders[$0..<min($0 + 2, rawHeaders.count)]
            return (chunk.first!, chunk.last!)
        }
        
        for (name, value) in headerPairs {
            headerString += "\(name): \(value)"
            headerString += "\n"
        }
        
        headerString += "\n"
        return headerString.utf8 + body
    }
    
    public init(
        version: Version = Version(major: 1, minor: 1),
        status: Status,
        rawHeaders: [String] = [],
        body: [UInt8] = []
    ) {
        self.version = version
        self.status = status
        self.rawHeaders = rawHeaders
        self.body = body
    }
    
}
