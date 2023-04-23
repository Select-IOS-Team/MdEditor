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
	}

	typealias ConfigurationModel = OpenDocumentModel.OpenDocumentViewData.DirectoryObjectViewModel

	// MARK: - Private properties

	private lazy var fileImageView: UIImageView = {
		let imageView = UIImageView()
		return imageView
	}()
	private lazy var fileTitleLabel: UILabel = {
		let label = UILabel()
		label.numberOfLines = Constants.titleLabelNumberOfLines
		return label
	}()

	// MARK: - Lifecycle

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupUI()
		setupLayout()
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
}

// MARK: - IConfigurableTableCell

extension FileTableViewCell: IConfigurableTableCell {

	func configure(with model: ConfigurationModel) {
		fileTitleLabel.text = model.title
		fileImageView.image = ImageAsset(name: model.imageName).image
	}
}

// MARK: - Private methods

private extension FileTableViewCell {

	func setupUI() {
		contentView.addSubview(fileImageView)
		contentView.addSubview(fileTitleLabel)
		contentView.isUserInteractionEnabled = false
	}

	func setupLayout() {

		contentView.snp.makeConstraints {
			$0.edges.equalToSuperview()
			$0.height.lessThanOrEqualTo(Constants.contentViewHeight)
		}

		fileImageView.snp.makeConstraints {
			$0.width.height.equalTo(Constants.fileImageViewSize)
			$0.leading.equalToSuperview().offset(Constants.contentHorizontalInset)
			$0.centerY.equalToSuperview()
		}
		fileTitleLabel.snp.makeConstraints {
			$0.leading.equalTo(fileImageView.snp.trailing).offset(Constants.contentSpace)
			$0.trailing.equalToSuperview().inset(Constants.contentHorizontalInset)
			$0.centerY.equalToSuperview()
		}
	}

	func configureUI() {
		selectionStyle = .none
	}
}
