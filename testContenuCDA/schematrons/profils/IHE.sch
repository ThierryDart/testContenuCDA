<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    CI-SIS_StructurationCommuneCDAr2.sch - ASIP/PRAS
    ......................................................................................................................................................
    Vérification de la conformité sémantique au volet Structuration Commune des Documents Médicaux du CI-SIS.
    ......................................................................................................................................................
    Utilisation des répertoires sous testContenuCDA :
    - testContenuCDA : les documents CDA d'exemples conformes au CI-SIS, ainsi que la feuille de style par défaut cda_asip.xsl pour la visualisation
    - - documentsAnnexes : Des documents annexes liés aux exemples et des documents de référence
    - - infrastructure/cda : Le schéma XML CDA.xsd
    - - jeuxDeValeurs : les jeux de valeurs du CI-SIS dans le format SVS.xsd
    - - processable/coreschemas : Les sous-schémas XML de CDA.xsd (de l'édition normative HL7 v3 de 2005, correspondant à CDAr2)
    - - schematrons : les schématrons des volets du CI-SIS sous la forme source (<CI-SIS_<nom>.sch) et sous la forme compilée en xslt2 (<CI-SIS_<nom>.xsl)
    - - - abstract : les sous-schématrons de patterns abstraits (un fichier par abstract pattern)
    - - - include : les sous-schématrons de patterns concrets (un fichier par pattern)
    - - - - sections : les sous-schématrons de patterns pour la vérification de conformité des sections du corps CDA
    - - - - - entries : les sous-schématrons de patterns pour la vérification de conformité des entries du corps CDA
    - - - moteur : le moteur xslt2 de vérification de conformité sémantique d'un document d'exemple, 
                   avec ses différents composants : saxon9he.jar, script verif.bat et feuilles de transformation xslt2 intermédiaires
    - - - rapports : les rapports de vérification de conformité produits, et la feuille de style qui sert à leur visualisation
    ......................................................................................................................................................
    Pour réaliser le schematron d'un volet de contenu du CI-SIS :
        1) Recopier le présent schématron sous le nom CI-SIS_<nom du volet>.sch, dans le répertoire courant (schematrons)
        2) conserver les include, pattern existants, à l'exception du pattern et de l'include nonXMLBody inutiles pour un volet structuré.
        3) Créer dans le répertoire include les patterns concrets supplémentaires requis par le volet (ou réutiliser ceux qui sont réutilisables)
        4) le cas échéant créer dans le répertoire abstract les paterns abstraits supplémentaires requis par le volet
        5) Inclure tous les patterns supplémentaires dans le schématron CI-SIS_<nom du volet>.sch
        6) Activer dans la phase "latotale<aaaammjj>" les patterns concrets supplémentaires.
        7) La première opération de validation de conformité d'un document au volet compilera le schematron en xslt2 : CI-SIS_<nom du volet>.xsl
    ......................................................................................................................................................    
    Historique :
        27/05/11 : FMY : Création
        31/05/11 : FMY : Compléments
        15/06/11 : FMY : Compléments
        27/06/11 : FMY : publication dans la version 1.0.1 du CI-SIS
        22/07/11 : FMY : Mise à jour des commentaires ci-dessus (retirer le pattern et l'include nonXMLBody), ajout variable OIDLOINC
                         ajout pattern observationInterpretation
        27/07/11 : FMY : Ajout des patterns de sections et d'entries de PCC et du CI-SIS, transversaux à tous types de documents       
        19/12/11 : FMY : Ajout du contrôle / jeu de valeurs confidentialityCode
        08/10/12 : FMY : CI-SIS 1.3 => retrait des include assignedAuthor, confidentialityCode et custodianOrganization. 
                         Maj des include assignedEntity (addr & telecom optionnels) et addr (contrôle structure des adresses)
                         Actualisation nom de fichiers include problemEntry, concernentry, procedureentry 
        24/01/13 : FMY : Ajout de contrôle de encompassingEncounter/code par rapport au jeu de valeurs CI-SIS_jdv_encompassingEncounterCode
        08/04/13 : FMA : Ajout du préfixe lab (pour CR de biologie et CR-ACP, et appel nouveau pattern serviceEventLabStatusCode
        05/12/13 : FMA : Désactivation du contrôle de l'adresse pour livraison au groupement DMP (qui n'a pas implémenté l'évolution addr)
        10/03/15 : JDS : Réactivation du contrôle de l'élément addr (spécifié dans la version du CI-SIS v1.2.0 de 2012 )
                         Maj des include serviceEventLabStatusCode20130408.sch      -> serviceEventLabStatusCode20150317.sch
                         Maj des include telecom20110728.sch                        -> telecom20150317.sch
        17/08/17 : LBE : Suppression de l'include de la section S_statutDoc.sch        
        08/01/19: NNA: Ajout des sections et entrées relatives au profil IHE APSR pour tester la conformité d’un document CDAr2
                         Activations des sections et entrées relatives au profil IHE APSR
        
        
-->
<schema xmlns="http://purl.oclc.org/dsdl/schematron" defaultPhase="ihe"
    xmlns:cda="urn:hl7-org:v3" queryBinding="xslt2" xmlns:lab="urn:oid:1.3.6.1.4.1.19376.1.3.2"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" schemaVersion="IHE.sch">
    <title>Rapport de conformité du document aux spécifications IHE (corps)</title>

   <ns prefix="cda" uri="urn:hl7-org:v3"/>
    <ns prefix="xsi" uri="http://www.w3.org/2001/XMLSchema-instance" />
    <ns prefix="jdv" uri="http://esante.gouv.fr"/>
    <ns prefix="svs" uri="urn:ihe:iti:svs:2008"/>
    <ns prefix="lab" uri="urn:oid:1.3.6.1.4.1.19376.1.3.2"/>


    <!-- sections relatives à PCC -->

    <include href="../include/sections/S_abdomen.sch"/>
    <include href="../include/sections/S_activeProblem.sch"/>
    <include href="../include/sections/S_admissionMedicationHistory.sch"/>
    <include href="../include/sections/S_advanceDirectives.sch"/>
    <include href="../include/sections/S_allergiesAndOtherAdverseReaction.sch"/>
    <include href="../include/sections/S_assessmentAndPlan.sch"/>
    <include href="../include/sections/S_cancerDiagnosis.sch"/>
    <include href="../include/sections/S_carePlan.sch"/>
    <include href="../include/sections/S_childFunctionalStatusAssessment.sch"/>
    <include href="../include/sections/S_childFunctionalStatusEatingSleeping.sch"/>
    <include href="../include/sections/S_codedAdvanceDirectives.sch"/>
    <include href="../include/sections/S_codedAntenatalTestingAndSurveillance.sch"/>
    <include href="../include/sections/S_codedCarePlan.sch"/>
    <include href="../include/sections/S_codedDetailedPhysicalExamination.sch"/>
    <include href="../include/sections/S_codedEventOutcome.sch"/>
    <include href="../include/sections/S_codedFamilyMedicalHistory.sch"/>
    <include href="../include/sections/S_codedFunctionalStatus.sch"/>
    <include href="../include/sections/S_codedhospitalCourse.sch"/>
    <include href="../include/sections/S_codedHospitalStadiesSummary.sch"/>
    <include href="../include/sections/S_codedListOfSurgeries.sch"/>
    <include href="../include/sections/S_codedReasonForReferral.sch"/>
    <include href="../include/sections/S_codedResults.sch"/>
    <include href="../include/sections/S_codedSocialHistory.sch"/>
    <include href="../include/sections/S_codedVitalSigns.sch"/>
    <include href="../include/sections/S_comment.sch"/>
    <include href="../include/sections/S_currentAlcoholSubstanceAbuse.sch"/>
    <include href="../include/sections/S_detailedPhysicalExamination.sch"/>
    <include href="../include/sections/S_dischargeDiagnosis.sch"/>
    <include href="../include/sections/S_dischargeDiet.sch"/>
    <include href="../include/sections/S_documentSummary.sch"/>
    <include href="../include/sections/S_ears.sch"/>
    <include href="../include/sections/S_eatingAndSleepingAssessment.sch"/>
    <include href="../include/sections/S_EDDiagnosis.sch"/>
    <include href="../include/sections/S_encounterHistories.sch"/>
    <include href="../include/sections/S_endocrine.sch"/>
    <include href="../include/sections/S_eyes.sch"/>
    <include href="../include/sections/S_FamilyMedicalHistory.sch"/>
    <include href="../include/sections/S_functionnalStatus.sch"/>
    <include href="../include/sections/S_generalAppearance.sch"/>
    <include href="../include/sections/S_genitalia.sch"/>
    <include href="../include/sections/S_healthMaintenanceCarePlan.sch"/>
    <include href="../include/sections/S_heart.sch"/>
    <include href="../include/sections/S_historyOfPastIllness.sch"/>
    <include href="../include/sections/S_historyOfTobaccoUse.sch"/>
    <include href="../include/sections/S_hospitalAdmissionDiagnosis.sch"/>
    <include href="../include/sections/S_hospitalCourse.sch"/>
    <include href="../include/sections/S_hospitalDischargeMedication.sch"/>
    <include href="../include/sections/S_hospitalStadiesSummary.sch"/>
    <include href="../include/sections/S_immunizationRecommendations.sch"/>
    <include href="../include/sections/S_immunizations.sch"/>
    <include href="../include/sections/S_integumentary.sch"/>
    <include href="../include/sections/S_intravenousFluidsAdministered.sch"/>
    <include href="../include/sections/S_laboratorySpecialty.sch"/>
    <include href="../include/sections/S_listOfSurgeries.sch"/>
    <include href="../include/sections/S_lymphaticPhysicalExam.sch"/>
    <include href="../include/sections/S_medicalDevices.sch"/>
    <include href="../include/sections/S_medicationAdministered.sch"/>
    <include href="../include/sections/S_medications.sch"/>
    <include href="../include/sections/S_musculo.sch"/>
    <include href="../include/sections/S_neurologic.sch"/>
    <include href="../include/sections/S_newbornDelivryInformation.sch"/>
    <include href="../include/sections/S_occupationalDataForHealth.sch"/>
    <include href="../include/sections/S_patientEducationAndConsents.sch"/>
    <include href="../include/sections/S_payers.sch"/>
    <include href="../include/sections/S_PhysicalFunction.sch"/>
    <include href="../include/sections/S_pregnancyHistory.sch"/>
    <include href="../include/sections/S_prenatalEvents.sch"/>
    <include href="../include/sections/S_procedureCarePlan.sch"/>
    <include href="../include/sections/S_proceduresIntervention.sch"/>
    <include href="../include/sections/S_progressNote.sch"/>
    <include href="../include/sections/S_prothesesEtObjetsPerso.sch"/>
    <include href="../include/sections/S_psychomotorDevelopment.sch"/>
    <include href="../include/sections/S_reasonForReferral.sch"/>
    <include href="../include/sections/S_rectum.sch"/>
    <include href="../include/sections/S_respiratoryPhysicalExam.sch"/>
    <include href="../include/sections/S_results.sch"/>
    <include href="../include/sections/S_socialHistory.sch"/>
    <include href="../include/sections/S_teethPhysicalExam.sch"/>
    <include href="../include/sections/S_thoraxAndLungs.sch"/>
    <include href="../include/sections/S_transfusionHistory.sch"/>
    <include href="../include/sections/S_transportMode.sch"/>
    <include href="../include/sections/S_VitalSigns.sch"/>
    
    
    <!--Sections relatives à IHE-APSR-->
    <include href="../include/sections/S_clinicalInformation.sch"/>
    <include href="../include/sections/S_intraoperativeObservation.sch"/>
    <include href="../include/sections/S_macroscopicObservation.sch"/>
    <include href="../include/sections/S_microscopicObservation.sch"/>
    <include href="../include/sections/S_additionalSpecifiedObservation.sch"/>
    <include href="../include/sections/S_procedureSteps.sch"/>
    <include href="../include/sections/S_diagnosticConclusion.sch"/>
    
    

    <!-- Entrées relatives à IHE-PCC -->
    <include href="../include/entrees/E_allergiesAndIntoleranceConcern_int.sch"/>
    <include href="../include/entrees/E_allergiesAndIntolerances_int.sch"/>
    <include href="../include/entrees/E_birthEventOrganizer_int.sch"/>
    <include href="../include/entrees/E_bloodTypeObservation_int.sch"/>
    <include href="../include/entrees/E_codedAntenatalTestingAndSurveillanceOrg_int.sch"/>
    <include href="../include/entrees/E_concernEntry_int.sch"/>
    <include href="../include/entrees/E_encounter_int.sch"/>
    <include href="../include/entrees/E_familyHistoryObservation_int.sch"/>
    <include href="../include/entrees/E_familyHistoryOrganizer_int.sch"/>
    <include href="../include/entrees/E_immunizations_int.sch"/>
    <include href="../include/entrees/E_laboratoryBatteryOrganizer_int.sch"/>
    <include href="../include/entrees/E_laboratoryReportDataProcessing_int.sch"/>
    <include href="../include/entrees/E_medications_int.sch"/>
    <include href="../include/entrees/E_observationRequest_int.sch"/>
    <include href="../include/entrees/E_patientTransfer_int.sch"/>
    <include href="../include/entrees/E_pregnancyHistoryOrganizer_int.sch"/>
    <include href="../include/entrees/E_pregnancyObservation_int.sch"/>
    <include href="../include/entrees/E_problemConcernEntry_int.sch"/>
    <include href="../include/entrees/E_problemEntry_int.sch"/>
    <include href="../include/entrees/E_procedureEntry_int.sch"/>
    <include href="../include/entrees/E_simpleObservation_int.sch"/>
    <include href="../include/entrees/E_socialHistoryObservation_int.sch"/>
    <include href="../include/entrees/E_specimenCollection_int.sch"/>
    <include href="../include/entrees/E_supplyEntry_int.sch"/>
    <include href="../include/entrees/E_surveyObservation_int.sch"/>
    <include href="../include/entrees/E_transport_int.sch"/>
    <include href="../include/entrees/E_vitalSignsObservation_int.sch"/>
    <include href="../include/entrees/E_vitalSignsOrganizer_int.sch"/>
    <include href="../include/entrees/ER_healthStatusObservation_int.sch"/>
    <include href="../include/entrees/ER_problemStatusObservation_int.sch"/>
    <include href="../include/entrees/ER_severity_int.sch"/>
    <include href="../include/entrees/ER_comments_int.sch"/>
    <include href="../include/entrees/E_product_int.sch"/>
    
    <!-- Entrées relatives à IHE-APSR -->
    
    <include href="../include/entrees/E_problemOrganizer_int.sch"/>
    <include href="../include/entrees/E_specimenProcedureStep_int.sch"/>
    <include href="../include/entrees/E_updateInformationOrganizer_int.sch"/>
    
    <!-- ::::::::::::::::::::::::::::::::::::: -->
    <!--           Phase en vigueur            -->
    <!-- ::::::::::::::::::::::::::::::::::::: -->

    <phase id="ihe">

        <!-- activation des sections -->
        <active pattern="S_abdomen"/>
        <active pattern="S_activeProblem"/>
        <active pattern="S_admissionMedicationHistory"/>
        <active pattern="S_advanceDirectives"/>
        <active pattern="S_allergiesAndOtherAdverseReactions"/>
        <active pattern="S_assessmentAndPlan"/>
        <active pattern="S_cancerDiagnosis"/>
        <active pattern="S_carePlan"/>
        <active pattern="S_childFunctionalStatusAssessment"/>
        <active pattern="S_childFunctionalStatusEatingSleeping"/>
        <active pattern="S_codedAdvanceDirectives"/>
        <active pattern="S_CodedAntenatalTestingAndSurveillance"/>
        <active pattern="S_codedCarePlan"/>
        <active pattern="S_codedDetailedPhysicalExamination"/>
        <active pattern="S_codedEventOutcome"/>
        <active pattern="S_codedFamilyMedicalHistory"/>
        <active pattern="S_codedFunctionalStatus"/>
        <active pattern="S_codedHospitalCourse"/>
        <active pattern="S_CodedHospitalStadiesSummary"/>
        <active pattern="S_codedListOfSurgeries"/>
        <active pattern="S_codedReasonForReferral"/>
        <active pattern="S_codedResults"/>
        <active pattern="S_codedSocialHistory"/>
        <active pattern="S_codedVitalSigns"/>
        <active pattern="S_comment"/>
        <active pattern="S_currentAlcoholSubstanceAbuse"/>
        <active pattern="S_detailedPhysicalExamination"/>
        <active pattern="S_dischargeDiagnosis"/>
        <active pattern="S_dischargeDiet"/>
        <active pattern="S_documentSummary"/>
        <active pattern="S_ears"/>
        <active pattern="S_eatingAndSleepingAssessment"/>
        <active pattern="S_EDDiagnosis"/>
        <active pattern="S_encounterHistories"/>
        <active pattern="S_endocrine"/>
        <active pattern="S_eyes"/>
        <active pattern="S_familyMedicalHistory"/>
        <active pattern="S_FunctionnalStatus"/>
        <active pattern="S_generalAppearance"/>
        <active pattern="S_genitalia"/>
        <active pattern="S_healthMaintenanceCarePlan"/>
        <active pattern="S_heart"/>
        <active pattern="S_historyOfPastIllness"/>
        <active pattern="S_historyOfTobaccoUse"/>
        <active pattern="S_hospitalAdmissionDiagnosisSection"/>
        <active pattern="S_hospitalCourse"/>
        <active pattern="S_HospitalDischargeMedication"/>
        <active pattern="S_hospitalStadiesSummary"/>
        <active pattern="S_integumentary"/>
        <active pattern="S_intravenousFluidsAdministered"/>
        <active pattern="S_immunizationRecommendations"/>
        <active pattern="S_immunizations"/>
        <active pattern="S_laboratorySpecialty"/>
        <active pattern="S_listOfSurgeries"/>
        <active pattern="S_lymphaticPhysicalExam"/>
        <active pattern="S_medicalDevices"/>
        <active pattern="S_medicationAdministered"/>
        <active pattern="S_medications"/>
        <active pattern="S_musculo"/>
        <active pattern="S_neurologic"/>
        <active pattern="S_newbornDelivryInformation"/>
        <active pattern="S_occupationalDataForHealth"/>
        <active pattern="S_patientEducationAndConsents"/>
        <active pattern="S_payers"/>
        <active pattern="S_PhysicalFunction"/>
        <active pattern="S_pregnancyHistory"/>
        <active pattern="S_prenatalEvents"/>
        <active pattern="S_procedureCarePlan"/>
        <active pattern="S_proceduresIntervention"/>
        <active pattern="S_progressNote"/>
        <active pattern="S_prothesesEtObjetsPerso"/>
        <active pattern="S_psychomotorDevelopment"/>
        <active pattern="S_reasonForReferral"/>
        <active pattern="S_rectum"/>
        <active pattern="S_respiratoryPhysicalExam"/>
        <active pattern="S_Results"/>
        <active pattern="S_socialHistory"/>
        <active pattern="S_teethPhysicalExam"/>
        <active pattern="S_thoraxAndLungs"/>
        <active pattern="S_transfusionHistory"/>
        <active pattern="S_transportMode"/>
        <active pattern="S_VitalSigns"/>
        
        <!-- Activation des entrées -->
        <active pattern="E_allergiesAndIntolerances_int"/>
        <active pattern="E_allergiesAndIntoleranceConcern_int"/>
        <active pattern="E_birthEventOrganizer_int"/>
        <active pattern="E_bloodTypeObservation_int"/>
        <active pattern="E_concernEntry_int"/>
        <active pattern="E_codedAntenatalTestingAndSurveillanceOrg_int"/>
        <active pattern="E_encounter_int"/>
        <active pattern="E_familyHistoryObservation_int"/>
        <active pattern="E_familyHistoryOrganizer_int"/>
        <active pattern="E_immunizations_int"/>
        <active pattern="E_laboratoryBatteryOrganizer_int"/>
        <active pattern="E_laboratoryReportDataProcessing_int"/>
        <active pattern="E_medications_int"/>
        <active pattern="E_ObservationRequest_int"/>
        <active pattern="E_patientTransfer_int"/>
        <active pattern="E_pregnancyHistoryOrganizer_int"/>
        <active pattern="E_problemConcernEntry_int"/>
        <active pattern="E_problemEntry_int"/>
        <active pattern="E_procedureEntry_int"/>
        <active pattern="E_simpleObservation_int"/>
        <active pattern="E_socialHistoryObservation_int"/>
        <active pattern="E_specimenCollection_int"/>
        <active pattern="E_supplyEntry_int"/>
        <active pattern="E_surveyObservation_int"/>
        <active pattern="E_transport_int"/>
        <active pattern="E_vitalSignsObservation_int.sch"/>
        <active pattern="E_vitalSignsOrganizer_int"/>
        <active pattern="ER_healthStatusObservation_int"/>
        <active pattern="ER_problemStatusObservation_int"/>
        <active pattern="ER_severity_int"/>
        <active pattern="ER_comments_int"/>
        <active pattern="E_product_int"/>
 
        <!-- Activition des sections APSR -->
        <active pattern="S_clinicalInformation"/>
        <active pattern="S_intraoperativeObservation"/>
        <active pattern="S_macroscopicObservation"/>
        <active pattern="S_microscopicObservation"/>
        <active pattern="S_additionalSpecifiedObservation"/>
        <active pattern="S_procedureSteps"/>
        <active pattern="S_diagnosticConclusion"/>
        
        <!-- Activation des entrées APSR  -->
        <active pattern="E_problemOrganizer_int"/>
        <active pattern="E_specimenProcedureStep_int"/>
        <active pattern="E_updateInformationOrganizer_int"/>
                
    </phase>

</schema>
