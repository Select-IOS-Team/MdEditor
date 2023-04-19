//
//  FileTableViewCell.swift
//  MdEditor
//
//  Created by Evgeni Meleshin on 18.04.2023.
//

import UIKit

/// Ячейка документа.
final class FileTableViewCell: UITableViewCell {

	// MARK: - Nested types

	private enum Constants {
		static let titleLabelNumberOfLines: Int = 2
		static let contentViewHeight: CGFloat = 56
		static let contentHorizontalInset: CGFloat = 16
		static let contentSpace: CGFloat = 12
		static let fileImageViewSize: CGFloat = 32
		static let additionalTextColor = Palette.additionalText
	}

	typealias ConfigurationModel = OpenDocumentModel.OpenDocumentViewData.FileViewModel

	// MARK: - Internal properties

	var completionCheckboxTapAction: (() -> Void)?

	// MARK: - Private properties

	private lazy var fileImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.isUserInteractionEnabled = true
		return imageView
	}()
	private lazy var fileTitleLabel: UILabel = {
		let label = UILabel()
		label.textColor = Constants.additionalTextColor
		label.numberOfLines = Constants.titleLabelNumberOfLines
		return label
	}()

	// MARK: - Lifecycle

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupUI()
		configureUI()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func prepareForReuse() {
		super.prepareForReuse()
		fileImageView.image = nil
		fileTitleLabel.text = nil
	}

	override func layoutSubviews() {
		super.layoutSubviews()
		setupLayout()
	}

	override func sizeThatFits(_ size: CGSize) -> CGSize {
		setupLayout()
		let height = max(Constants.contentViewHeight, fileTitleLabel.frame.height)
		return CGSize(width: contentView.frame.width, height: height)
	}
}

// MARK: - IConfigurableTableCell

extension FileTableViewCell: IConfigurableTableCell {

	func configure(with model: ConfigurationModel) {
		fileTitleLabel.text = model.fileTitle
		fileImageView.image = ImageAsset(name: model.fileImageName).image
	}
}

// MARK: - Private methods

private extension FileTableViewCell {

	func setupUI() {
		contentView.addSubview(fileImageView)
		contentView.addSubview(fileTitleLabel)

		let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapCell))
		tapGestureRecognizer.isEnabled = true
		contentView.addGestureRecognizer(tapGestureRecognizer)
	}

	func setupLayout() {
		fileImageView.snp.makeConstraints { make -> Void in
			make.width.height.equalTo(Constants.fileImageViewSize)
			make.leading.equalToSuperview().offset(Constants.contentHorizontalInset)
			make.top.equalToSuperview().offset(Constants.contentSpace)
		}
		fileTitleLabel.snp.makeConstraints { make -> Void in
			make.width.height.equalTo(Constants.fileImageViewSize)
			make.leading.equalTo(fileImageView.snp.trailing).offset(Constants.contentHorizontalInset)
			make.trailing.equalToSuperview()
			make.top.equalToSuperview().offset(Constants.contentSpace)
		}
	}

	func configureUI() {
		selectionStyle = .none
	}

	@objc
	func didTapCell() {
	}
}
