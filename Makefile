test:
	@swift test

preview_docs:
	@swift package --disable-sandbox preview-documentation --product Capture
