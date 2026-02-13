func uncurryMethod<
	Object: AnyObject,
	each Args,
	Output
>(
	_ f: @escaping (Object) -> (repeat each Args) -> Output
) -> (Object, repeat each Args) -> Output {
	{ (object, args: repeat each Args) in
		return f(object)(repeat each args)
	}
}
