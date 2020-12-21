(deftemplate Student
    (slot ID (type SYMBOL))
	(multislot Name (type SYMBOL))
    (slot Group (type SYMBOL))
	(multislot DisciplineNames (type SYMBOL))
	(multislot NoAbsLab (type INTEGER))
	(multislot NoAbsProj (type INTEGER))
	(multislot ExamGrades (type FLOAT))
	(multislot LabGrades (type FLOAT))
	(multislot ProjGrades (type FLOAT))
	(multislot FinalGrades (type FLOAT))
	(slot NoDisciplinesFailed (type INTEGER) (default 0))
	(slot AverageFinalGrades (type NUMBER) (default 0.0))
    (slot Scholarship (type SYMBOL) (default none))
	(multislot OptionsGuidingProf (type SYMBOL))
	(slot GuidingProf (type SYMBOL) (default none))
	(slot IndexGuidingProfChoice (type INTEGER) (default 1))
)

(deftemplate Professor
	(slot ID (type SYMBOL))
	(multislot Name (type SYMBOL))
	(multislot Disciplines (type SYMBOL))
	(multislot PrefferedExamDates (type INTEGER))
	(multislot OccupiedPrefferedExamDates (type SYMBOL))
	(slot NoMaxGuidingPositions (type INTEGER))
	(slot NoOccupiedGuidingPositions (type INTEGER) (default 0))
)

(deftemplate Discipline
	(slot Name (type SYMBOL))
	(slot ExamGradeWeight (type INTEGER))
	(slot LabGradeWeight (type INTEGER))
	(slot ProjGradeWeight (type INTEGER))
)

(deftemplate Scholarship
	(slot Name (type SYMBOL))
	(slot MaxNumber (type INTEGER))
	(slot Ratio (type INTEGER))
	(slot AwardedNumber (type INTEGER) (default 0))
    (slot Amount (type NUMBER) (default -1))
)

(deftemplate Group
	(slot Name (type SYMBOL))
	(multislot Disciplines)
	(multislot ExamDatesOptions)
	(multislot ExamDates)
)