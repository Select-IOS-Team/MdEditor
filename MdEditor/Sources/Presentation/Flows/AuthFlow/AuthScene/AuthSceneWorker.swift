//
//  AuthSceneWorker.swift
//  MdEditor
//
//  Created by Egor SAUSHKIN on 10.06.2023.
//  Copyright © 2023 Evgeni Meleshin (Personal Team). All rights reserved.
//

import Foundation

/// Данные для ответа.
public struct AuthDTO: Equatable {
	var success: Int
	var login: String
}

protocol IAuthSceneWorker {
	/// Метод для проверки логина и пароля.
	/// - Parameters:
	///   - login: Логин введенный пользователем с клавиатуры.
	///   - password: Пароль введенный пользователем с клавиатуры.
	/// - Returns: Возвращает данные для ответа `AuthDTO`.
	func login(login: String, password: String) -> AuthDTO
}

/// Класс Worker для проверки авторизации пользователя.
class AuthSceneWorker: IAuthSceneWorker {

	func login(login: String, password: String) -> AuthDTO {
		guard login == "1" && password == "1" else {
			return AuthDTO(success: 0, login: login)
		}
		return AuthDTO(success: 1, login: login)
	}
}
