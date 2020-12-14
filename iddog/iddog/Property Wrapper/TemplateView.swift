//
//  TemplateView.swift
//  iddog
//
//  Created by Cassia Aparecida Barbosa on 14/12/20.
//

import UIKit

/// A `class` created in order to simplify the way to create views using View Code.
@propertyWrapper final class TemplateView<View: UIView> {
	
	private lazy var view: View = {
		let view = View(frame: .zero)
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	
	var wrappedValue: View {
		return view
	}
}
