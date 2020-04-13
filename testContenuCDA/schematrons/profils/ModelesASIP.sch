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
        21/08/2017 : Creation
        10/10/2019 : Mise à jour pour l'entrée Dispositif médical ASIP
        
-->
<schema xmlns="http://purl.oclc.org/dsdl/schematron" defaultPhase="modelesASIP"
    xmlns:cda="urn:hl7-org:v3" queryBinding="xslt2" xmlns:lab="urn:oid:1.3.6.1.4.1.19376.1.3.2"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" schemaVersion="ModelesASIP.sch">
    
    <title>Rapport de conformité du document aux spécifications françaises (corps – sections, entrées, jeux de valeurs ASIP)</title>

    <ns prefix="cda" uri="urn:hl7-org:v3"/>
    <ns prefix="xsi" uri="http://www.w3.org/2001/XMLSchema-instance"/>
    <ns prefix="jdv" uri="http://esante.gouv.fr"/>
    <ns prefix="svs" uri="urn:ihe:iti:svs:2008"/>
    <ns prefix="lab" uri="urn:oid:1.3.6.1.4.1.19376.1.3.2"/>

    <!-- Inclusions d'abstract patterns : -->

    <!-- sections relatives à l'ASIP Santé-->
    
    <include href="../include/sections/S_allergiesIntolerances_ANS.sch"/>
    <include href="../include/sections/S_bilanCancerologie_ANS.sch"/>
    <include href="../include/sections/S_bilanPre-therapeutique_ASIP.sch"/>
    <include href="../include/sections/S_cadrePropositionTherapeutique_ANS.sch"/>
    <include href="../include/sections/S_citationDocuments_ASIP.sch"/>
    <include href="../include/sections/S_comment.sch"/>
    <include href="../include/sections/S_conclusionCR-ACP_ASIP.sch"/>
    <include href="../include/sections/S_conclusionCRO_ASIP.sch"/>
    <include href="../include/sections/S_diagnosticSortie_ANS.sch"/>
    <include href="../include/sections/S_dischargeDiagnosis.sch"/>
    <include href="../include/sections/S_dispositifs_medicaux_ASIP.sch"/>
    <include href="../include/sections/S_dispositionsMedicoSociales_ASIP.sch"/>
    <include href="../include/sections/S_documentsAjoutes_ANS.sch"/>
    <include href="../include/sections/S_documentsReference_ANS.sch"/>
    <include href="../include/sections/S_dossier_ANS.sch"/>
    <include href="../include/sections/S_elementsCliniquesRapportes_ASIP.sch"/>
    <include href="../include/sections/S_facteursDeRisqueCode_ASIP.sch"/>
    <include href="../include/sections/S_facteursDeRisque_ANS.sch"/>
    <include href="../include/sections/S_historiqueExamensBiologiques_ASIP.sch"/>
    <include href="../include/sections/S_informationsAssure_ASIP.sch"/>
    <include href="../include/sections/S_interpretation_ANS.sch"/>
    <include href="../include/sections/S_laborAndDelivery_ASIP.sch"/>
    <include href="../include/sections/S_MotifHospitalisation_ANS.sch"/>
    <include href="../include/sections/S_noteProgression_ANS.sch"/>
    <include href="../include/sections/S_pathologieAntecedentsAllergiesFacteursDeRisques_ASIP.sch"/>
    <include href="../include/sections/S_pathologieEnCoursAntecedentsAllergies_ASIP.sch"/>
    <include href="../include/sections/S_protheseEtObjetPersonnel_ASIP.sch"/>
    <include href="../include/sections/S_resultatExamenBiologique_ANS.sch"/>
    <include href="../include/sections/S_resultatLaboBioSeconde_ANS.sch"/>
    <include href="../include/sections/S_scoreEvaluationClinique_ANS.sch"/>
    <include href="../include/sections/S_scoreGlasgow_ASIP.sch"/>
    <include href="../include/sections/S_scoreNIHSS_ASIP.sch"/>
    <include href="../include/sections/S_scoreRankin_ASIP.sch"/>
    <include href="../include/sections/S_statutCasPresenteEtQuorum_ASIP.sch"/>
    <include href="../include/sections/S_statutDocument_ASIP.sch"/>
    <include href="../include/sections/S_statutDossPresenteRCP_ANS.sch"/>
    <include href="../include/sections/S_traitementAuLongCours_ASIP.sch"/>
    <include href="../include/sections/S_TraitementsMR.sch"/>
    <include href="../include/sections/S_TraitementsSortie.sch"/>

    <!-- Entrées relatives à l'ASIP Santé -->
    
    <include href="../include/entrees/E_dispositifMedical-2_ASIP.sch"/>
    <include href="../include/entrees/E_dispositifMedicalComplement_fr.sch"/>
    <include href="../include/entrees/E_dispositifMedicalImplante_fr.sch"/>
    <include href="../include/entrees/E_observationNIHSSComponent_ASIP.sch"/>
    <include href="../include/entrees/E_observationScoreNIHSS_ASIP.sch"/>
    <include href="../include/entrees/E_organizerDocumentAttach%C3%A9_ASIP.sch"/>
    <include href="../include/entrees/E_organizerRCP_ASIP.sch"/>
    <include href="../include/entrees/E_organizerTraitementInitialAVC_ASIP.sch"/>


    <!-- ::::::::::::::::::::::::::::::::::::: -->
    <!--           Phase en vigueur            -->
    <!-- ::::::::::::::::::::::::::::::::::::: -->

    <phase id="modelesASIP">

        <!-- Activition des sections -->
        <active pattern="S_allergiesIntolerances_ANS"/>
        <active pattern="S_BilanCancérologie_ANS"/>
        <active pattern="S_bilanPre-therapeutique_ASIP"/>
        <active pattern="S_cadrePropositionTherapeutique_ANS"/>
        <active pattern="S_citationDocuments"/>
        <active pattern="S_comment"/>
        <active pattern="S_conclusionCR-ACP_ASIP"/>
        <active pattern="S_conclusionCRO_ASIP"/>
        <active pattern="S_conclusionCR-ACP_ASIP"/>
        <active pattern="S_diagnosticSortie_ANS"/>
        <active pattern="S_dischargeDiagnosis"/>
        <active pattern="S_dispositifs_medicaux_ASIP"/>
        <active pattern="S_dispositionsMedicoSociales_ASIP"/>
        <active pattern="S_documentsAjoutes_ANS"/>
        <active pattern="S_documentsReferences_ANS"/>
        <active pattern="S_dossier_ANS"/>
        <active pattern="S_elementsCliniquesRapportes_ASIP"/>
        <active pattern="S_facteursDeRisque_ANS"/>
        <active pattern="S_facteursDeRisqueCode_ASIP"/>
        <active pattern="S_historiqueExamensBiologiques_ASIP"/>
        <active pattern="S_historiqueExamensBiologiques_ASIP"/>
        <active pattern="S_informationAssure_ASIP"/>
        <active pattern="S_Interpretation_ANS"/>
        <active pattern="S_laborAndDelivery_ASIP"/>
        <active pattern="S_MotifHospitalisation_ANS"/>
        <active pattern="S_noteProgression_ANS"/>
        <active pattern="S_pathologieAntecedentsAllergiesFacteursDeRiques_ASIP"/>
        <active pattern="S_pathologieAntecedentsAllergies_ASIP"/>
        <active pattern="S_protheseEtObjetPersonnel_ASIP"/>
        <active pattern="S_resultatExamBio_ANS"/>
        <active pattern="S_resultatLaboBioSeconde_ANS"/>
        <active pattern="S_scoreEvaluationClinique_ANS"/>
        <active pattern="S_scoreGlasgow_ASIP"/>
        <active pattern="S_scoreNIHSS_ASIP"/>
        <active pattern="S_scoreRankin_ASIP"/>
        <active pattern="S_statutCasPresenteQuorum_ASIP"/>
        <active pattern="S_statutDoc"/>
        <active pattern="S_statutDossPresenteRCP_ANS"/>
        <active pattern="S_traitementLongCours_ASIP"/>
        <active pattern="S_traitementsMR"/>
        <active pattern="S_TraitementsSortie"/>

        <!-- Activation des entrées  -->
        <active pattern="E_dispositifMedical-2_ASIP"/>
        <active pattern="E_dispositifMedicalComplement_fr"/>
        <active pattern="E_dispositifMedicalImplante_fr"/>
        <active pattern="E_observationNIHSSComponent_ASIP"/>
        <active pattern="E_observationScoreNIHSS_ASIP"/>
        <active pattern="E_organizerDocumentAttache_ASIP"/>
        <active pattern="E_organizerRCP_ASIP"/>
        <active pattern="E_organizerTraitementInitialAVC_ASIP"/>

    </phase>
</schema>
