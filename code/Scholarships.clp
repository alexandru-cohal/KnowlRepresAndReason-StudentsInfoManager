; ------------------------------- Meritorious ------------------
(defrule AwardMeritoriousScholarshipFirstStudent
; Award Meritorious Scholarship for the first student in the list

	(Determine Scholarships)
    (OrderedStudentsList ?ID1 $?)
    ?StudentID1 <- (Student
                        (ID ?ID1)
                        (NoDisciplinesFailed ?NoDisciplinesFailedID1)
                        (Scholarship ?scholarshipTypeID1)
                    )
    (test (and (eq ?scholarshipTypeID1 none)
               (eq ?NoDisciplinesFailedID1 0)
          )
    )
    ?adScholarship <- (Scholarship 
                            (Name Meritorious)
                            (MaxNumber ?MaxNumber)
                            (AwardedNumber ?AwardedNumber)
                      )
    (test (< ?AwardedNumber ?MaxNumber))
    =>
    (modify ?adScholarship (AwardedNumber =(+ ?AwardedNumber 1)))
	(modify ?StudentID1 (Scholarship Meritorious))
)

(defrule AwardMeritoriousScholarshipSecondaryStudents
; Award Meritorious Scholarship for the following students after the first one

	(Determine Scholarships)
    (OrderedStudentsList $? ?ID1 ?ID2 $?)
    ?StudentID1 <- (Student
                        (ID ?ID1)
                        (Scholarship ?scholarshipTypeID1)
                    )
    ?StudentID2 <- (Student
                        (ID ?ID2)
                        (NoDisciplinesFailed ?NoDisciplinesFailedID2)
                        (Scholarship ?scholarshipTypeID2)
                    )
    (test (and (neq ?scholarshipTypeID1 none)
               (eq ?scholarshipTypeID2 none)
               (eq ?NoDisciplinesFailedID2 0)
          )
    )
    ?adScholarship <- (Scholarship 
                            (Name Meritorious)
                            (MaxNumber ?MaxNumber)
                            (AwardedNumber ?AwardedNumber)
                      )
    (test (< ?AwardedNumber ?MaxNumber))
    =>
    (modify ?adScholarship (AwardedNumber =(+ ?AwardedNumber 1)))
	(modify ?StudentID2 (Scholarship Meritorious))
)

; ------------------------------- Integral ------------------
(defrule AwardIntegralScholarshipFirstStudent
; Award Integral Scholarship for the first student in the list

	(Determine Scholarships)
    (OrderedStudentsList ?ID1 $?)
    ?StudentID1 <- (Student
                        (ID ?ID1)
                        (NoDisciplinesFailed ?NoDisciplinesFailedID1)
                        (Scholarship ?scholarshipTypeID1)
                    )
    (test (and (eq ?scholarshipTypeID1 none)
               (eq ?NoDisciplinesFailedID1 0)
          )
    )
	(Scholarship 
		(Name Meritorious)
        (MaxNumber ?MaxNumberMerit)
        (AwardedNumber ?AwardedNumberMerit)
    )
    ?adScholarshipIntegral <- (Scholarship 
									(Name Integral)
									(MaxNumber ?MaxNumberIntegral)
									(AwardedNumber ?AwardedNumberIntegral)
							  )
    (test (and (eq ?MaxNumberMerit 0)
			   (< ?AwardedNumberIntegral ?MaxNumberIntegral)
		  )
	)
    =>
    (modify ?adScholarshipIntegral (AwardedNumber =(+ ?AwardedNumberIntegral 1)))
	(modify ?StudentID1 (Scholarship Integral))
)

(defrule AwardIntegralScholarshipSecondaryStudents
; Award Integral Scholarship for the following students after the first one

	(Determine Scholarships)
    (OrderedStudentsList $? ?ID1 ?ID2 $?)
    ?StudentID1 <- (Student
                        (ID ?ID1)
                        (Scholarship ?scholarshipTypeID1)
                    )
    ?StudentID2 <- (Student
                        (ID ?ID2)
                        (NoDisciplinesFailed ?NoDisciplinesFailedID2)
                        (Scholarship ?scholarshipTypeID2)
                    )
    (test (and (neq ?scholarshipTypeID1 none)
               (eq ?scholarshipTypeID2 none)
               (eq ?NoDisciplinesFailedID2 0)
          )
    )
    (Scholarship 
		(Name Meritorious)
        (MaxNumber ?MaxNumberMerit)
        (AwardedNumber ?AwardedNumberMerit)
    )
    ?adScholarshipIntegral <- (Scholarship 
									(Name Integral)
									(MaxNumber ?MaxNumberIntegral)
									(AwardedNumber ?AwardedNumberIntegral)
							  )
    (test (and (eq ?MaxNumberMerit ?AwardedNumberMerit)
			   (< ?AwardedNumberIntegral ?MaxNumberIntegral)
		  )
	)
    =>
    (modify ?adScholarshipIntegral (AwardedNumber =(+ ?AwardedNumberIntegral 1)))
	(modify ?StudentID2 (Scholarship Integral))
)

; ------------------------------- Partial ------------------
(defrule AwardPartialScholarshipFirstStudent
; Award Partial Scholarship for the first student in the list

	(Determine Scholarships)
    (OrderedStudentsList ?ID1 $?)
    ?StudentID1 <- (Student
                        (ID ?ID1)
                        (Scholarship ?scholarshipTypeID1)
                    )
    (test (eq ?scholarshipTypeID1 none))
	(Scholarship 
		(Name Meritorious)
        (MaxNumber ?MaxNumberMerit)
        (AwardedNumber ?AwardedNumberMerit)
    )
	(Scholarship 
		(Name Integral)
        (MaxNumber ?MaxNumberIntegral)
        (AwardedNumber ?AwardedNumberIntegral)
    )
    ?adScholarshipPartial <- (Scholarship 
									(Name Partial)
									(MaxNumber ?MaxNumberPartial)
									(AwardedNumber ?AwardedNumberPartial)
							  )
    (test (and (eq ?MaxNumberMerit 0)
			   (eq ?MaxNumberIntegral 0)
			   (< ?AwardedNumberPartial ?MaxNumberPartial)
		  )
	)
    =>
    (modify ?adScholarshipPartial (AwardedNumber =(+ ?AwardedNumberPartial 1)))
	(modify ?StudentID1 (Scholarship Partial))
)

(defrule AwardPartialScholarshipSecondaryStudents
; Award Partial Scholarship for the following students after the first one

	(Determine Scholarships)
    (OrderedStudentsList $? ?ID1 ?ID2 $?)
    ?StudentID1 <- (Student
                        (ID ?ID1)
                        (Scholarship ?scholarshipTypeID1)
                    )
    ?StudentID2 <- (Student
                        (ID ?ID2)
						(NoDisciplinesFailed ?NoDisciplinesFailedID2)
                        (Scholarship ?scholarshipTypeID2)
                    )
    (test (and (neq ?scholarshipTypeID1 none)
               (eq ?scholarshipTypeID2 none)
          )
    )
	(Scholarship 
		(Name Meritorious)
        (MaxNumber ?MaxNumberMerit)
        (AwardedNumber ?AwardedNumberMerit)
    )
	(Scholarship 
		(Name Integral)
        (MaxNumber ?MaxNumberIntegral)
        (AwardedNumber ?AwardedNumberIntegral)
    )
    ?adScholarshipPartial <- (Scholarship 
									(Name Partial)
									(MaxNumber ?MaxNumberPartial)
									(AwardedNumber ?AwardedNumberPartial)
							  )
    (test (and (or (and (eq ?MaxNumberMerit ?AwardedNumberMerit)
						(eq ?MaxNumberIntegral ?AwardedNumberIntegral)
				   )
				   (> ?NoDisciplinesFailedID2 0)
			   )
			   (< ?AwardedNumberPartial ?MaxNumberPartial)
		  )
	)
    =>
    (modify ?adScholarshipPartial (AwardedNumber =(+ ?AwardedNumberPartial 1)))
	(modify ?StudentID2 (Scholarship Partial))
)

; ------------------------------- Compute Values ------------------
(defrule ComputeValueMeritoriousScholarship
; Compute the value of the Meritorious Scholarship

	(Determine ValuesScholarships)
	(ScholarshipsTotalSum ?scholarshipsSum)
	?adScholarship <- (Scholarship 
							(Name Meritorious)
							(AwardedNumber ?AwardedNumber)
							(Ratio ?ratio)
							(Amount ?amount)
					  )
	(test (eq ?amount -1))
	=>
	(if (neq ?AwardedNumber 0)
		then (modify ?adScholarship (Amount =(/ (/ (* ?ratio ?scholarshipsSum) 100) ?AwardedNumber)))
		else (modify ?adScholarship (Amount 0.0))
	)
)

(defrule ComputeValueIntegralScholarship
; Compute the value of the Integral Scholarship

	(Determine ValuesScholarships)
	(ScholarshipsTotalSum ?scholarshipsSum)
	?adScholarship <- (Scholarship 
							(Name Integral)
							(AwardedNumber ?AwardedNumber)
							(Ratio ?ratio)
							(Amount ?amount)
					  )
	(test (eq ?amount -1))
	=>
	(if (neq ?AwardedNumber 0)
		then (modify ?adScholarship (Amount =(/ (/ (* ?ratio ?scholarshipsSum) 100) ?AwardedNumber)))
		else (modify ?adScholarship (Amount 0.0))
	)
)

(defrule ComputeValuePartialScholarship
; Compute the value of the Partial Scholarship

	(Determine ValuesScholarships)
	(ScholarshipsTotalSum ?scholarshipsSum)
	?adScholarship <- (Scholarship 
							(Name Partial)
							(AwardedNumber ?AwardedNumber)
							(Ratio ?ratio)
							(Amount ?amount)
					  )
	(test (eq ?amount -1))
	=>
	(if (neq ?AwardedNumber 0)
		then (modify ?adScholarship (Amount =(/ (/ (* ?ratio ?scholarshipsSum) 100) ?AwardedNumber)))
		else (modify ?adScholarship (Amount 0.0))
	)
)