//
//  StudentInformationModel.swift
//  On the Map
//
//  Created by leanne on 7/1/16.
//  Copyright © 2016 leanne63. All rights reserved.
//

import Foundation

struct StudentInformationModel {
	
	// MARK: - Constants
	
	/// Key for data representing the date when the student location was created.
	static let createdAtKey = "createdAt"
	/// Key for data representing the first name of the student which matches their Udacity profile first name.
	static let firstNameKey = "firstName"
	/// Key for data representing the last name of the student which matches their Udacity profile last name.
	static let lastNameKey = "lastName"
	/// Key for data representing the latitude of the student location (ranges from -90 to 90).
	static let latitudeKey = "latitude"
	/// Key for data representing the longitude of the student location (ranges from -180 to 180).
	static let longitudeKey = "longitude"
	/// Key for data representing the location string used for geocoding the student location.
	static let mapStringKey = "mapString"
	/// Key for data representing the URL provided by the student.
	static let mediaURLKey = "mediaURL"
	/// Key for data representing an auto-generated id/key generated by Parse which uniquely identifies a StudentLocation.
	static let objectIDKey = "objectID"
	/// Key for data representing an extra (optional) key used to uniquely identify a StudentLocation (fill with Udacity User ID).
	static let uniqueKeyKey = "uniqueKey"
	/// Key for data representing the date when the student location was last updated.
	static let updatedAtKey = "updatedAt"
	
	
	// MARK: - Properties
	
	/// Shared property to hold all student instances
	static var students = [StudentInformation]()
	
	static func addStudent(student: StudentInformation) {
		
		StudentInformationModel.students.append(student)

	}
	
	
	static func convertStudentInfoToParseDict(student: StudentInformation) -> [String: AnyObject] {
		
		var studentInfoDict = [String: AnyObject]()
		studentInfoDict[firstNameKey] = student.firstName
		studentInfoDict[lastNameKey] = student.lastName
		studentInfoDict[latitudeKey] = student.latitude
		studentInfoDict[longitudeKey] = student.longitude
		studentInfoDict[mapStringKey] = student.mapString
		studentInfoDict[mediaURLKey] = student.mediaURL
		studentInfoDict[uniqueKeyKey] = student.uniqueKey
		
		return studentInfoDict
	}
}