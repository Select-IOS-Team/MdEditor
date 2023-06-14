//
//  AuthSceneModel.swift
//  MdEditor
//
//  Created by Egor SAUSHKIN on 10.06.2023.
//  Copyright © 2023 Evgeni Meleshin (Personal Team). All rights reserved.
//

import Foundation

/// Модель сцены авторизации.
enum AuthSceneModels {
	struct Request {
		var login: String
		var password: String
	}
	struct Response {
		var success: Bool
		var login: String
	}
	struct ViewModel {
		var success: Bool
		var userName: String
	}
}
