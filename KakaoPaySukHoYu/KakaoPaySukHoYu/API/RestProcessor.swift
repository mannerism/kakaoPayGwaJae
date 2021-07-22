//
//  RestProcessor.swift
//  KakaoPaySukHoYu
//
//  Created by Yu Juno on 2021/06/24.
//
import UIKit

protocol RestProcessorRequestDelegate: AnyObject {
	func didFailToPrepareRequest(
		_ result: RestProcessor.Results,
		_ usage: RestUsage
	)
	func didReceiveResponseFromDataTask(
		_ result: RestProcessor.Results,
		_ usage: RestUsage
	)
}

class RestProcessor {
	/// Request
	var requestHttpHeaders = RestEntity()
	var urlQueryParameters = RestEntity()
	var httpBodyParameters = RestEntity()
	
	/// Optional
	var httpBody: Data?
	
	/// Delegate
	weak var requestDelegate: RestProcessorRequestDelegate?
	
	/// Image Loading
	private var loadedImages = LimitedDictionary<URL, UIImage>(limit: 20)
	private var runningRequests = [UUID: URLSessionDataTask]()
	
	/// Mockable
	let urlSession: URLSession
	
	init(
		_ session: URLSession = URLSession(configuration: .default)
	) {
		urlSession = session
	}
	
	// MARK: - Preparing Requests
	func prepareRequest(
		withURL url: URL?,
		httpBody: Data?,
		httpMethod: HttpMethod
	) -> URLRequest? {
		guard let url = url else { return nil }
		var request = URLRequest(url: url)
		
		request.httpMethod = httpMethod.rawValue
		for (header, value) in requestHttpHeaders.allValues() {
			request.setValue( (value as! String), forHTTPHeaderField: header)
		}
		request.httpBody = httpBody
		return request
	}
	
	// MARK: - Making Requests
	func makeRequest(
		toURL url: URL,
		withHttpMethod httpMethod: HttpMethod,
		usage: RestUsage,
		callBack: (() -> Void)? = nil
	) {
		let targetURL = self.addURLQueryParameters(toURL: url)
		let httpBody = (httpMethod == .get)
			? nil
			: self.getHttpBody()
		guard let request = self.prepareRequest(
						withURL: targetURL,
						httpBody: httpBody,
						httpMethod: httpMethod) else {
			/// Case 1: Failed
			let error = Results(withError: CustomError.failedToCreateRequest)
			self.requestDelegate?.didFailToPrepareRequest(error, usage)
			callBack?()
			return
		}
		let task = urlSession.dataTask(with: request) { (data, response, error) in
			/// Case 2: Success
			let result = Results(
				withData: data,
				response: Response(fromURLResponse: response),
				error: error)
			self.requestDelegate?.didReceiveResponseFromDataTask(result, usage)
			callBack?()
		}
		task.resume()
	}
	
	// MARK: - Fetching Image
	func getImage(
		_ url: URL,
		_ completion: @escaping (Result<UIImage, Error>) -> Void
	) -> UUID? {
		
		if let image = loadedImages[url] {
			completion(.success(image))
			return nil
		}
		
		let uuid = UUID()
		let task = urlSession.dataTask(with: url) { (data, response, error) in
			
			// Defer until removing a value from running requests
			defer { self.runningRequests.removeValue(forKey: uuid) }
			
			if let data = data,
				 let image = UIImage(data: data) {
				self.loadedImages[url] = image
				completion(.success(image))
				return
			}
			
			guard let error = error else {
				// Without an image or an error case.
				return
			}
			
			//If the error is anything other than canceling the task, we forward that to the caller of `loadImage(_:completion:)`.
			guard (error as NSError).code == NSURLErrorCancelled else {
				completion( .failure(error) )
				return
			}
			// The request is cancelled, no need to send a callback
		}
		task.resume()
		
		runningRequests[uuid] = task
		return uuid
	}
	
	// MARK: - Clean up
	func cancelLoad(_ uuid: UUID) {
		runningRequests[uuid]?.cancel()
		runningRequests.removeValue(forKey: uuid)
	}
	
	func cleanUpCache() {
		loadedImages.removeAll()
	}
	
	func reset() {
		requestHttpHeaders.reset()
		urlQueryParameters.reset()
		httpBodyParameters.reset()
		httpBody = nil
	}
	
	// MARK: - Helpers
	private func addURLQueryParameters(toURL url: URL) -> URL {
		if urlQueryParameters.totalItems() > 0 {
			guard var urlComponents = URLComponents(
				url: url,
				resolvingAgainstBaseURL: false
			) else { return url }
			var queryItems = [URLQueryItem]()
			for (key, value) in urlQueryParameters.allValues() {
				let item = URLQueryItem(name: key, value: (value as! String).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
				)
				queryItems.append(item)
			}
			urlComponents.queryItems = queryItems
			guard let updatedURL = urlComponents.url else { return url }
			return updatedURL
		}
		return url
	}
	
	private func getHttpBody() -> Data? {
		guard let contentType = requestHttpHeaders.value(forKey: "Content-Type") as? String else { return nil }
		if contentType.contains("application/json") {
			return try? JSONSerialization.data(
				withJSONObject: httpBodyParameters.allValues(),
				options: [.prettyPrinted, .sortedKeys]
			)
		} else if contentType.contains("application/x-www-form-urlencoded") {
			let bodyString = httpBodyParameters.allValues().map {
				"\($0)=\(String(describing: ($1 as! String).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)))"
			}.joined(separator: "&")
			return bodyString.data(using: .utf8)
		} else {
			return httpBody
		}
	}
}
