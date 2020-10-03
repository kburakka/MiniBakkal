//
//  MyDataResponse.swift
//  MiniBakkal
//
//  Created by Burak KAYA on 3.10.2020.
//  Copyright © 2020 Burak KAYA. All rights reserved.
//

import Alamofire

/// Type used to store all values associated with a serialized response of a `DataRequest` or `UploadRequest`.
public struct MyDataResponse<Success, Failure: Error> {
    /// The URL request sent to the server.
    public let request: URLRequest?

    /// The server's response to the URL request.
    public let response: HTTPURLResponse?

    /// The data returned by the server.
    public let data: Data?

    /// The final metrics of the response.
    ///
    /// - Note: Due to `FB7624529`, collection of `URLSessionTaskMetrics` on watchOS is currently disabled.`
    ///
    public let metrics: URLSessionTaskMetrics?

    /// The time taken to serialize the response.
    public let serializationDuration: TimeInterval

    /// The result of response serialization.
    public let result: Result<Success, Failure>

    /// Returns the associated value of the result if it is a success, `nil` otherwise.
    public var value: Success? { return result.success }

    /// Returns the associated error value if the result if it is a failure, `nil` otherwise.
    public var error: Failure? { return result.failure }

    /// Creates a `DataResponse` instance with the specified parameters derived from the response serialization.
    ///
    /// - Parameters:
    ///   - request:               The `URLRequest` sent to the server.
    ///   - response:              The `HTTPURLResponse` from the server.
    ///   - data:                  The `Data` returned by the server.
    ///   - metrics:               The `URLSessionTaskMetrics` of the `DataRequest` or `UploadRequest`.
    ///   - serializationDuration: The duration taken by serialization.
    ///   - result:                The `Result` of response serialization.
    public init(request: URLRequest?,
                response: HTTPURLResponse?,
                data: Data?,
                metrics: URLSessionTaskMetrics?,
                serializationDuration: TimeInterval,
                result: Result<Success, Failure>) {
        self.request = request
        self.response = response
        self.data = data
        self.metrics = metrics
        self.serializationDuration = serializationDuration
        self.result = result
    }
}
