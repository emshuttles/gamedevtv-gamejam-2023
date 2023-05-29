extends Node


const JOB_NAMES := {
	Enums.Job.ENGINEER: "Engineer",
	Enums.Job.ART_THERAPIST: "Art Therapist",
	Enums.Job.TOY_MAKER: "Toy Maker",
}
const IDEAL_TRAITS := {
	Enums.Job.ENGINEER: {
		Enums.Trait.KIND: 1,
		Enums.Trait.ANALYTICAL: 5,
	},
	Enums.Job.ART_THERAPIST: {
		Enums.Trait.KIND: 5,
		Enums.Trait.ANALYTICAL: 2,
	},
	Enums.Job.TOY_MAKER: {
		Enums.Trait.KIND: 3,
		Enums.Trait.ANALYTICAL: 4,
	},
}
const QUOTAS := {
	1: {
		Enums.Job.ENGINEER: 1,
		Enums.Job.ART_THERAPIST: 1,
		Enums.Job.TOY_MAKER: 0,
	},
	2: {
		Enums.Job.ENGINEER: 0,
		Enums.Job.ART_THERAPIST: 1,
		Enums.Job.TOY_MAKER: 1,
	},
	3: {
		Enums.Job.ENGINEER: 1,
		Enums.Job.ART_THERAPIST: 1,
		Enums.Job.TOY_MAKER: 1,
	},
}
