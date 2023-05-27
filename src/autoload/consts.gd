extends Node


const JOB_NAMES := {
	Enums.Job.ENGINEER: "Engineer",
	Enums.Job.ART_THERAPIST: "Art Therapist",
	Enums.Job.TOY_MAKER: "Toy Maker",
}
const IDEAL_TRAITS := {
	Enums.Job.ENGINEER: {
		Enums.Trait.ANALYTICAL: 5,
		Enums.Trait.KIND: 1,
	},
	Enums.Job.ART_THERAPIST: {
		Enums.Trait.ANALYTICAL: 1,
		Enums.Trait.KIND: 5,
	},
	Enums.Job.TOY_MAKER: {
		Enums.Trait.ANALYTICAL: 4,
		Enums.Trait.KIND: 4,
	},
}
