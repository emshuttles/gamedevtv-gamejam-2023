extends Node


static func is_fileable(node: Node) -> bool:
	return node is Paper and (node.is_evaluation or node.is_job_request)
