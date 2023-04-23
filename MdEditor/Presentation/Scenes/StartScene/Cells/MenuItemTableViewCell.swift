//
//  MenuItemTableViewCell.swift
//  MdEditor
//
//  Created by Evgeniy Novgorodov on 19.04.2023.
//

import SnapKit
import UIKit

final class MenuItemTableViewCell: UITableViewCell {

	// MARK: - Nested types

	private enum Constants {
		static let titleLabelNumberOfLines: Int = 2
		static let contentViewMinimumHeight: CGFloat = 56
		static let contentVerticalInset: CGFloat = 12
		static let contentHorizontalInset: CGFloat = 16
		static let contentSpace: CGFloat = 12
		static let iconImageViewSize: CGFloat = 32
	}

	typealias ConfigurationModel = StartSceneModel.ViewData.MenuItem

	// MARK: - Private properties

	private lazy var iconImageView = UIImageView()
	private lazy var titleLabel: UILabel = {
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
		iconImageView.image = nil
		titleLabel.text = nil
	}

	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
		if selected {
			UIView.animate(withDuration: 0.15, animations: {
				self.transform = CGAffineTransform(scaleX: 0.98, y: 0.98)
			}, completion: { _ in
				UIView.animate(withDuration: 0.15) {
					self.transform = .identity
				}
			})
		}
	}
}

// MARK: - IConfigurableTableCell

extension MenuItemTableViewCell: IConfigurableTableCell {

	func configure(with model: ConfigurationModel) {
		titleLabel.text = model.title
		iconImageView.image = model.icon.image
	}
}

// MARK: - Private methods

private extension MenuItemTableViewCell {

	func setupUI() {
		contentView.addSubview(iconImageView)
		contentView.addSubview(titleLabel)
	}

	func setupLayout() {
		contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: Constants.contentViewMinimumHeight).isActive = true

		iconImageView.snp.makeConstraints {
			$0.centerY.equalToSuperview()
			$0.leading.equalToSuperview().inset(Constants.contentHorizontalInset)
			$0.size.equalTo(Constants.iconImageViewSize)
		}
		titleLabel.snp.makeConstraints {
			$0.centerY.equalToSuperview()
			$0.top.bottom.equalToSuperview().inset(Constants.contentVerticalInset)
			$0.leading.equalTo(iconImageView.snp.trailing).offset(Constants.contentSpace)
			$0.trailing.equalToSuperview().inset(Constants.contentHorizontalInset)
		}
	}

	func configureUI() {
		selectionStyle = .none
	}
}
