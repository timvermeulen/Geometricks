protocol ConvertibleFromRawRect: RawValueType {
	init(_ rawRect: RawRect<RawValue>)
}

protocol ConvertibleToRawRect: RawValueType {
	func makeRawRect() -> RawRect<RawValue>
}
