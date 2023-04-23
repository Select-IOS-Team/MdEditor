//
//  RecentFileCollectionViewCell.swift
//  MdEditor
//
//  Created by Evgeniy Novgorodov on 19.04.2023.
//

import SnapKit
import UIKit

final class RecentFileCollectionViewCell: UICollectionViewCell, IZoomingPressStateAnimatable {

	// MARK: - Nested types

	private enum Constants {
		static let containerViewCornerRadius: CGFloat = 8
		static let contentInset: CGFloat = 10
	}

	typealias ConfigurationModel = StartSceneModel.ViewData.RecentFileItem

	// MARK: - Private properties

	private lazy var containerView: UIView = {
		let view = UIView()
		view.layer.cornerRadius = Constants.containerViewCornerRadius
		return view
	}()
	private lazy var textView: UITextView = {
		let textView = UITextView()
		textView.backgroundColor = .clear
		textView.isUserInteractionEnabled = false
		return textView
	}()
	private lazy var fileNameLabel: UILabel = {
		let textView = UILabel()
		textView.textAlignment = .center
		return textView
	}()

	// MARK: - Lifecycle

	override init(frame: CGRect) {
		super.init(frame: frame)
		setupUI()
		setupLayout()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func prepareForReuse() {
		super.prepareForReuse()
		containerView.backgroundColor = .clear
		textView.text = nil
		fileNameLabel.text = nil
	}
}

// MARK: - IConfigurableCollectionCell

extension RecentFileCollectionViewCell: IConfigurableCollectionCell {

	func configure(with model: ConfigurationModel) {
		containerView.backgroundColor = model.color
		textView.text = model.text
		fileNameLabel.text = model.fileName
	}
}

// MARK: - Private methods

private extension RecentFileCollectionViewCell {

	func setupUI() {
		contentView.addSubview(containerView)
		containerView.addSubview(textView)
		containerView.addSubview(fileNameLabel)
	}

	func setupLayout() {
		containerView.snp.makeConstraints {
			$0.edges.equalToSuperview()
		}
		textView.snp.makeConstraints {
			$0.top.leading.trailing.equalToSuperview().inset(Constants.contentInset)
		}
		fileNameLabel.snp.makeConstraints {
			$0.top.equalTo(textView.snp.bottom).offset(Constants.contentInset)
			$0.leading.trailing.bottom.equalToSuperview().inset(Constants.contentInset)
		}
	}
}
