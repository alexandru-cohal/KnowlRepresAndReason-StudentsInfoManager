(defrule ChooseGuidingProfessorFirstStudentValidChoice
; Choose the Guiding Professor for the first student of the ordered list

	(Determine GuidingProf)
	(OrderedStudentsList ?studentID1 $?)
	?adStudentID1 <- (Student
                        (ID ?studentID1)
						(OptionsGuidingProf $?optionsGuidingProf)
						(GuidingProf ?IDGuidingProf)
						(IndexGuidingProfChoice ?indexGuidingProf)
                     )
	(test (and (eq ?IDGuidingProf none)
			   (<= ?indexGuidingProf (length$ $?optionsGuidingProf))
		  )
	)
	?adGuidingProf <- (Professor
						(ID =(nth$ ?indexGuidingProf $?optionsGuidingProf))
						(NoMaxGuidingPositions ?maxPositions)
						(NoOccupiedGuidingPositions ?occupiedPositions)
					  )
	(test (< ?occupiedPositions ?maxPositions))
	=>
	(modify ?adStudentID1 (GuidingProf =(nth$ ?indexGuidingProf $?optionsGuidingProf)))
	(modify ?adGuidingProf (NoOccupiedGuidingPositions =(+ ?occupiedPositions 1)))
)

(defrule ChooseGuidingProfessorFirstStudentWrongChoice
; Move to the next option of Guiding Professor for the first student of the ordered list

	(Determine GuidingProf)
	(OrderedStudentsList ?studentID1 $?)
	?adStudentID1 <- (Student
                        (ID ?studentID1)
						(OptionsGuidingProf $?optionsGuidingProf)
						(GuidingProf ?IDGuidingProf)
						(IndexGuidingProfChoice ?indexGuidingProf)
                     )
	(test (and (eq ?IDGuidingProf none)
			   (<= ?indexGuidingProf (length$ $?optionsGuidingProf))
		  )
	)
	?adGuidingProf <- (Professor
						(ID =(nth$ ?indexGuidingProf $?optionsGuidingProf))
						(NoMaxGuidingPositions ?maxPositions)
						(NoOccupiedGuidingPositions ?occupiedPositions)
					  )
	(test (= ?occupiedPositions ?maxPositions))
	=>
	(modify ?adStudentID1 (IndexGuidingProfChoice =(+ ?indexGuidingProf 1)))
)

(defrule ChooseGuidingProfessorecondaryStudentsValidChoice
; Choose the Guiding Professors for the secondary students of the ordered list

	(Determine GuidingProf)
	(OrderedStudentsList $? ?studentID1 ?studentID2 $?)
	?adStudentID1 <- (Student
                        (ID ?studentID1)
						(GuidingProf ?IDGuidingProfStudentID1)
                     )
	?adStudentID2 <- (Student
                        (ID ?studentID2)
						(OptionsGuidingProf $?optionsGuidingProfStudentID2)
						(GuidingProf ?IDGuidingProfStudentID2)
						(IndexGuidingProfChoice ?indexGuidingProfStudentID2)
                     )
	(test (and (neq ?IDGuidingProfStudentID1 none)
			   (eq ?IDGuidingProfStudentID2 none)
			   (<= ?indexGuidingProfStudentID2 (length$ $?optionsGuidingProfStudentID2))
		  )
	)
	?adGuidingProf <- (Professor
						(ID =(nth$ ?indexGuidingProfStudentID2 $?optionsGuidingProfStudentID2))
						(NoMaxGuidingPositions ?maxPositions)
						(NoOccupiedGuidingPositions ?occupiedPositions)
					  )
	(test (< ?occupiedPositions ?maxPositions))
	=>
	(modify ?adStudentID2 (GuidingProf =(nth$ ?indexGuidingProfStudentID2 $?optionsGuidingProfStudentID2)))
	(modify ?adGuidingProf (NoOccupiedGuidingPositions =(+ ?occupiedPositions 1)))
)

(defrule ChooseGuidingProfessorSecondaryStudentsWrongChoice
; Move to the next option of Guiding Professor for the secondary students of the ordered list

	(Determine GuidingProf)
	(OrderedStudentsList $? ?studentID1 ?studentID2 $?)
	?adStudentID1 <- (Student
                        (ID ?studentID1)
						(GuidingProf ?IDGuidingProfStudentID1)
                     )
	?adStudentID2 <- (Student
                        (ID ?studentID2)
						(OptionsGuidingProf $?optionsGuidingProfStudentID2)
						(GuidingProf ?IDGuidingProfStudentID2)
						(IndexGuidingProfChoice ?indexGuidingProfStudentID2)
                     )
	(test (and (neq ?IDGuidingProfStudentID1 none)
			   (eq ?IDGuidingProfStudentID2 none)
			   (<= ?indexGuidingProfStudentID2 (length$ $?optionsGuidingProfStudentID2))
		  )
	)
	?adGuidingProf <- (Professor
						(ID =(nth$ ?indexGuidingProfStudentID2 $?optionsGuidingProfStudentID2))
						(NoMaxGuidingPositions ?maxPositions)
						(NoOccupiedGuidingPositions ?occupiedPositions)
					  )
	(test (= ?occupiedPositions ?maxPositions))
	=>
	(modify ?adStudentID2 (IndexGuidingProfChoice =(+ ?indexGuidingProfStudentID2 1)))
)

(defrule ChooseGuidingProfessorFail
; Not found a valid option for a Student for the Guiding Professor

	(Determine GuidingProf)
	(OrderedStudentsList $? ?studentID1 $?)
	?adStudentID1 <- (Student
                        (ID ?studentID1)
						(OptionsGuidingProf $?optionsGuidingProf)
						(GuidingProf ?IDGuidingProf)
						(IndexGuidingProfChoice ?indexGuidingProf)
                     )
	(test (and (eq ?IDGuidingProf none)
			   (> ?indexGuidingProf (length$ $?optionsGuidingProf))
		  )
	)
	=>
	(modify ?adStudentID1 (GuidingProf N/A))
)