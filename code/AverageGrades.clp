(defrule ComputeAverageGradeFail
; Compute the Final Grade if the discipline is Failed - too many absences

	(Determine FinalGrades)
	?adrStudent <- (Student
						(DisciplineNames ?DisciplineName $?otherDisciplines)
						(NoAbsLab ?NoAbsLab $?otherNoAbsLab)
						(NoAbsProj ?NoAbsProj $?otherNoAbsProj)
						(ExamGrades ?ExamGrade $?otherExamGrades)
						(LabGrades ?LabGrade $?otherLabGrades)
						(ProjGrades ?ProjGrade $?otherProjGrades)
						(FinalGrades ?FinalGrade $?otherFinalGrades)
						(NoDisciplinesFailed ?NoDisciplinesFailed)
						(AverageFinalGrades ?AverageFinalGrades)
				   )
	(test (and (eq ?FinalGrade -1.0)
			   (or (> ?NoAbsLab 2)
				   (> ?NoAbsProj 2)
			   )
		  )
	)	
	=>
	(modify ?adrStudent (DisciplineNames $?otherDisciplines ?DisciplineName)
						(NoAbsLab $?otherNoAbsLab ?NoAbsLab)
						(NoAbsProj $?otherNoAbsProj ?NoAbsProj)
						(ExamGrades $?otherExamGrades ?ExamGrade)
						(LabGrades $?otherLabGrades ?LabGrade)
						(ProjGrades $?otherProjGrades ?ProjGrade)
						(FinalGrades $?otherFinalGrades 0.0)
						(NoDisciplinesFailed =(+ ?NoDisciplinesFailed 1))
						(AverageFinalGrades =(+ ?AverageFinalGrades 0))
	)
)

(defrule ComputeAverageGradeWithoutProject
; Compute the Final Grade if the discipline is passed and it doesn't have project

	(Determine FinalGrades)
	?adrStudent <- (Student
						(DisciplineNames ?DisciplineName $?otherDisciplines)
						(NoAbsLab ?NoAbsLab $?otherNoAbsLab)
						(NoAbsProj ?NoAbsProj $?otherNoAbsProj)
						(ExamGrades ?ExamGrade $?otherExamGrades)
						(LabGrades ?LabGrade $?otherLabGrades)
						(ProjGrades ?ProjGrade $?otherProjGrades)
						(FinalGrades ?FinalGrade $?otherFinalGrades)
						(AverageFinalGrades ?AverageFinalGrades)
				   )
	(test (and (eq ?FinalGrade -1.0)
			   (eq ?ProjGrade -1)
			   (<= ?NoAbsLab 2)
			   (<= ?NoAbsProj 2)
		  )
	)	
	(Discipline
		(Name ?DisciplineName)
		(ExamGradeWeight ?ExamGradeWeight)
		(LabGradeWeight ?LabGradeWeight)
		(ProjGradeWeight ?ProjGradeWeight)
	)	
	=>
	(bind ?ComputedFinalGrade ( / (+ (* ?ExamGrade ?ExamGradeWeight) (* (- ?LabGrade (* 0.5 ?NoAbsLab)) ?LabGradeWeight)) 100 ))
    (modify ?adrStudent (DisciplineNames $?otherDisciplines ?DisciplineName)
						(NoAbsLab $?otherNoAbsLab ?NoAbsLab)
						(NoAbsProj $?otherNoAbsProj ?NoAbsProj)
						(ExamGrades $?otherExamGrades ?ExamGrade)
						(LabGrades $?otherLabGrades ?LabGrade)
						(ProjGrades $?otherProjGrades ?ProjGrade)
						(FinalGrades $?otherFinalGrades ?ComputedFinalGrade)
						(AverageFinalGrades =(+ ?AverageFinalGrades ( / ?ComputedFinalGrade (+ (length$ $?otherDisciplines) 1)) ))
						
	)
)

(defrule ComputeAverageGradeWithProject
; Compute the Final Grade if the discipline is passed and it has project

	(Determine FinalGrades)
	?adrStudent <- (Student
						(DisciplineNames ?DisciplineName $?otherDisciplines)
						(NoAbsLab ?NoAbsLab $?otherNoAbsLab)
						(NoAbsProj ?NoAbsProj $?otherNoAbsProj)
						(ExamGrades ?ExamGrade $?otherExamGrades)
						(LabGrades ?LabGrade $?otherLabGrades)
						(ProjGrades ?ProjGrade $?otherProjGrades)
						(FinalGrades ?FinalGrade $?otherFinalGrades)
						(AverageFinalGrades ?AverageFinalGrades)
				   )
	(test (and (eq ?FinalGrade -1.0)
			   (neq ?ProjGrade -1)
			   (<= ?NoAbsLab 2)
			   (<= ?NoAbsProj 2)
		  )
	)	
	(Discipline
		(Name ?DisciplineName)
		(ExamGradeWeight ?ExamGradeWeight)
		(LabGradeWeight ?LabGradeWeight)
		(ProjGradeWeight ?ProjGradeWeight)
	)	
	=>
    (bind ?ComputedFinalGrade ( / (+ (* ?ExamGrade ?ExamGradeWeight) (* (- ?LabGrade (* 0.5 ?NoAbsLab)) ?LabGradeWeight) (* (- ?ProjGrade (* 0.5 ?NoAbsProj)) ?ProjGradeWeight)) 100 ) )
	(modify ?adrStudent (DisciplineNames $?otherDisciplines ?DisciplineName)
						(NoAbsLab $?otherNoAbsLab ?NoAbsLab)
						(NoAbsProj $?otherNoAbsProj ?NoAbsProj)
						(ExamGrades $?otherExamGrades ?ExamGrade)
						(LabGrades $?otherLabGrades ?LabGrade)
						(ProjGrades $?otherProjGrades ?ProjGrade)
						(FinalGrades $?otherFinalGrades ?ComputedFinalGrade)
						(AverageFinalGrades =(+ ?AverageFinalGrades ( / ?ComputedFinalGrade (+ (length$ $?otherDisciplines) 1) )))
	)
)

(defrule FinishAverageGrade
; Retract from the WM the fact which triggers the computation of the Avearage Grades

	?adr <- (Determine FinalGrades)
	(not (Student
			  (FinalGrades -1.0 $?)
		 )
	)
	=>
	(retract ?adr)
)