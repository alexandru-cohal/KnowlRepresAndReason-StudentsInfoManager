(defrule ChooseExamDateExact_option1
; Choose the first Exam Date option if it is possible

	(declare (salience 10))
	
	(Determine ExamDates)
	?adGroup <-	(Group
					(Name ?groupName)
					(Disciplines ?disciplineName $?groupDisciplineName)
					(ExamDatesOptions ?option1 ?option2 $?groupOptions)
					(ExamDates 0 $?groupExamDates)
				)
	(not (Group
			(Name ?groupName)
			(ExamDates $? ?option1 $?)
		 )
	)
	?adProf <- (Professor
					(Disciplines $? ?disciplineName $?)
					(PrefferedExamDates $?profPrefferedDates1 ?option1 $?)
					(OccupiedPrefferedExamDates $?profOccupiedExamDates)
				)
	(test (eq (nth$ (+ (length$ $?profPrefferedDates1) 1) $?profOccupiedExamDates) no))
	=>
	(modify ?adGroup (Disciplines $?groupDisciplineName ?disciplineName)
					 (ExamDatesOptions $?groupOptions ?option1 ?option2)
					 (ExamDates $?groupExamDates ?option1)
	)
	(modify ?adProf (OccupiedPrefferedExamDates (replace$ $?profOccupiedExamDates (+ (length$ $?profPrefferedDates1) 1) (+ (length$ $?profPrefferedDates1) 1) ?disciplineName)))
)

(defrule ChooseExamDateExact_option2
; Choose the second Exam Date option if it is possible

	(declare (salience 10))

	(Determine ExamDates)
	?adGroup <-	(Group
					(Name ?groupName)
					(Disciplines ?disciplineName $?groupDisciplineName)
					(ExamDatesOptions ?option1 ?option2 $?groupOptions)
					(ExamDates 0 $?groupExamDates)
				)
	(not (Group
			(Name ?groupName)
			(ExamDates $? ?option2 $?)
		 )
	)
	?adProf <- (Professor
					(Disciplines $? ?disciplineName $?)
					(PrefferedExamDates $?profPrefferedDates1 ?option2 $?)
					(OccupiedPrefferedExamDates $?profOccupiedExamDates)
				)
	(test (eq (nth$ (+ (length$ $?profPrefferedDates1) 1) $?profOccupiedExamDates) no))
	=>
	(modify ?adGroup (Disciplines $?groupDisciplineName ?disciplineName)
					 (ExamDatesOptions $?groupOptions ?option1 ?option2)
					 (ExamDates $?groupExamDates ?option2)
	)
	(modify ?adProf (OccupiedPrefferedExamDates (replace$ $?profOccupiedExamDates (+ (length$ $?profPrefferedDates1) 1) (+ (length$ $?profPrefferedDates1) 1) ?disciplineName)))
)

(defrule ChooseExamDateApprox_option1
; Choose the closest Exam Date to the first option

	(Determine ExamDates)
	?adGroup <-	(Group
					(Name ?groupName)
					(Disciplines ?disciplineName $?groupDisciplineName)
					(ExamDatesOptions ?option1 ?option2 $?groupOptions)
					(ExamDates 0 $?groupExamDates)
				)
	?adProf <- (Professor
					(ID ?IDProf)
					(Disciplines $? ?disciplineName $?)
					(PrefferedExamDates $?profPrefferedDates1 ?profOption $?)
					(OccupiedPrefferedExamDates $?profOccupiedExamDates)
				)
	(test (eq (nth$ (+ (length$ $?profPrefferedDates1) 1) $?profOccupiedExamDates) no))
	(not (Group
			(Name ?groupName)
			(ExamDates $? ?profOption $?)
		 )
	)
	(not
		(and (Professor
				(ID ?IDProf)
				(PrefferedExamDates $?profPrefferedDates2 ?profOtherOption &: (< (abs (- ?option1 ?profOtherOption)) (abs (- ?option1 ?profOption))) $?)
				(OccupiedPrefferedExamDates $?profOccupiedExamDates2 &: (eq (nth$ (+ (length$ $?profPrefferedDates2) 1) $?profOccupiedExamDates2) no))
			 )
			 (not (Group
					(Name ?groupName)
					(ExamDates $? ?profOtherOption $?)
				  )
			 )
		)
	)
	=>
	(modify ?adGroup (Disciplines $?groupDisciplineName ?disciplineName)
					 (ExamDatesOptions $?groupOptions ?option1 ?option2)
					 (ExamDates $?groupExamDates ?profOption)
	)
	(modify ?adProf (OccupiedPrefferedExamDates (replace$ $?profOccupiedExamDates (+ (length$ $?profPrefferedDates1) 1) (+ (length$ $?profPrefferedDates1) 1) ?disciplineName)))
)