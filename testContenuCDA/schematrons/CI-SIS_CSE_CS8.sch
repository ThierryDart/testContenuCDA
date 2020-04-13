<?xml version="1.0" encoding="UTF-8"?>
<!-- 
                 -=-=-=-=-=-=<<ox#%@O[ CI-SIS_CertificatSanteCS8.sch - ASIP/PRAS ]O@%#xo>>=-=-=-=-=-=-
   
    Vérification de la conformité sémantique au volet Certificats de Santé de l'Enfant du CI-SIS.
   
    Historique :
        24/06/11 : CRI : Adaptation du module initial CI-SIS_StructurationCommuneCDAr2.sch pour le volet "Certificats de Santé de l'Enfant" (composant CS8) du CI-SIS de l'ASIP
        06/03/12 : CRI : Supression des références à SNOMED CT
        19/04/13 : CRI : Adaptation modifications vocabulaires et intégration des fichiers inclus
        27/05/15 : JDS : Ajout du schématron sections/abdomenPhysicalExam20110627.sch
                         Mise à jour du schématron CSEgeneralAppEnt20120306.sch -> CSEgeneralAppEnt20150522.sch
                         Maj des include telecom20110728.sch                        -> telecom20150317.sch
        10/10/17 : NMA : Mise à jour par rapport au testContenuCDA V2
        23/10/17 : NMA : Correction des schématrons codedSocialHistory et immunization
        14/03/18 : NMA : MAJ du pattern variables
        14/02/18 : APE : MAJ des contrôles du JDV Activité professionnelle                 .
-->

<schema xmlns="http://purl.oclc.org/dsdl/schematron" defaultPhase="CS8-20130326"
    xmlns:cda="urn:hl7-org:v3" queryBinding="xslt2"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" schemaVersion="CI-SIS_CSE_CS8.sch">
    <title>Rapport de conformité du document aux spécifications du volet Certificat de santé de l'enfant (modèle CS8)</title>
    <ns prefix="cda" uri="urn:hl7-org:v3"/>
    <ns prefix="xsi" uri="http://www.w3.org/2001/XMLSchema-instance"/>
    <ns prefix="jdv" uri="http://esante.gouv.fr"/>
    <ns prefix="svs" uri="urn:ihe:iti:svs:2008"/>

                                    <!--=<<o#%@O[ Abstract patterns ]O@%#o>>=-->
    <include href="abstract/dansJeuDeValeurs.sch"/>
    <include href="abstract/IVL_TS.sch"/>   
    <include href="abstract/personName20110627.sch"/>

    
                                <!--=<<o#%@O[ Sections spécifiques au volet ]O@%#o>>=-->
    <include href="include/specificationsVolets/CSE/S_CS8codedPhysicalExam.sch"/>
    
     
                                 <!--=<<o#%@O[ Entrées spécifiques au volet ]O@%#o>>=-->

    <include href="include/specificationsVolets/CSE/E_CodedVitalSigns_CSE.sch"/>
    <include href="include/specificationsVolets/CSE/E_CodedAntenatalTestingAndSurveillance_CSE.sch"/>
    <include href="include/specificationsVolets/CSE/E_codedResultsEntries_CSE.sch"/>
    <include href="include/specificationsVolets/CSE/E_codedSocialHistory_CSE.sch"/>
    <include href="include/specificationsVolets/CSE/E_ears_CSE.sch"/>
    <include href="include/specificationsVolets/CSE/E_generalApp_CSE.sch"/>
    <include href="include/specificationsVolets/CSE/E_Genitalia_CSE.sch"/>
    <include href="include/specificationsVolets/CSE/E_Heart_CSE.sch"/>
    <include href="include/specificationsVolets/CSE/E_Neurologic_CSE.sch"/>
    <include href="include/specificationsVolets/CSE/E_abdomen_CSE.sch"/>
    <include href="include/specificationsVolets/CSE/E_immunizations_CSE.sch"/>
    <include href="include/specificationsVolets/CSE/E_laborAndDelivery_CSE.sch"/>
    <include href="include/specificationsVolets/CSE/E_RechHbs_CSE.sch"/>
    <include href="include/specificationsVolets/CSE/E_pregnancyHistory_CSE.sch"/>
    <include href="include/specificationsVolets/CSE/E_historyOfPastIllness_CSE.sch"/>
    <include href="include/specificationsVolets/CSE/E_musculo_CSE.sch"/>
    
                                     <!--=<<o#%@O[ Value sets ]O@%#o>>=-->
    <include href="include/jeuxDeValeurs/CSE/JDV_Activite_CSE.sch"/>
    <include href="include/jeuxDeValeurs/CSE/JDV_dateCons_CSE.sch"/>
    <include href="include/jeuxDeValeurs/CSE/JDV_demConsult_CSE.sch"/>
    <include href="include/jeuxDeValeurs/CSE/JDV_nivEtude_CSE.sch"/>
    <include href="include/jeuxDeValeurs/CSE/JDV_typPres_CSE.sch"/>    
    <include href="include/jeuxDeValeurs/CSE/JDV_AntecedentsObstetricaux_CSE.sch"/>
    
    <!--Entete-->
    <include href="include/specificationsVolets/CSE/Entete/Entete_CSE.sch"/>
    
    <!-- ::::::::::::::::::::::::::::::::::::: -->
    <!--           Phase en vigueur            -->    
    <!-- ::::::::::::::::::::::::::::::::::::: -->
    
    <phase id="CS8-20130326">
        <active pattern="variables"/>
        
        <!--=<<o#%@O[ activation section spécifique ]O@%#o>>=-->
        
        <active pattern="S_CS8codedPhysicalExam"/>

                                 <!--=<<o#%@O[ activation entrées spécifiques ]O@%#o>>=-->

        <active pattern="E_CodedVitalSigns_CSE"/>
        <active pattern="E_abdomen_CSE"/>
        <active pattern="E_CodedAntenatalTestingAndSurveillance_CSE"/>
        <active pattern="E_codedResultsEntries_CSE"/>
        <active pattern="E_codedSocialHistory_CSE"/>
        <active pattern="E_RechHbs_CSE"/>
        <active pattern="E_ears_CSE"/>
        <active pattern="E_generalApp_CSE"/>
        <active pattern="E_Genitalia_CSE"/>
        <active pattern="E_Heart_CSE"/>
        <active pattern="E_historyOfPastIllness_CSE"/>
        <active pattern="E_immunizations_CSE"/>
        <active pattern="E_laborAndDelivery_CSE"/>
        <active pattern="E_musculo_CSE"/>
        <active pattern="E_Neurologic_CSE"/>
        <active pattern="E_pregnancyHistory_CSE"/>

                                        <!--=<<o#%@O[ activation value sets ]O@%#o>>=-->
        <active pattern="JDV_nivEtude_CSE"/>
        <active pattern="JDV_Activite_CSE"/>        
        <active pattern="JDV_demConsult_CSE"/>
        <active pattern="JDV_dateCons_CSE"/>
        <active pattern="JDV_typPres_CSE"/>
        <active pattern="JDV_AntecedentsObstetricaux_CSE"/>
        
        <!--Entete-->
        <active pattern="Entete_CSE"/>
        
    </phase>
                                        <!--=<<o#%@O[ variables globales ]O@%#o>>=-->
    
    <pattern id="variables">

        <!-- chemins relatifs des fichiers jeux de valeurs -->
        <let name="jdv_Activite" value="'../jeuxDeValeurs/JDV_Activité-CISIS.xml'"/>
        <let name="jdv_nivEtude" value="'../jeuxDeValeurs/JDV_niveauEtude-CISIS.xml'"/> 
        <let name="jdv_demConsult" value="'../jeuxDeValeurs/JDV_demConsult-CISIS.xml'"/>
        <let name="jdv_dateCons" value="'../jeuxDeValeurs/JDV_DateCons-CISIS.xml'"/>
        <let name="jdv_typPres" value="'../jeuxDeValeurs/JDV_TypePres-CISIS.xml'"/>
        <let name="jdv_AntecedentsObstetricaux_CSE" value="'../jeuxDeValeurs/JDV_AntecedentsObstetricaux_CSE-CISIS.xml'"/>
        
        <rule context="cda:ClinicalDocument">
            <assert test="./cda:templateId[@root='1.2.250.1.213.1.1.1.5.1']"> 
                [CI-SIS_CertificatSanteCS8] Erreur de conformité CS8 :
                L'élément ClinicalDocument/templateId doit être présent 
                avec @root="1.2.250.1.213.1.1.1.5.1".</assert>
            <assert test="cda:templateId[@root='1.3.6.1.4.1.19376.1.7.3.1.1.13.1']"> 
                [CI-SIS_CertificatSanteCS8] Erreur: Le template parent "QRPH Health birth summary" (1.3.6.1.4.1.19376.1.7.3.1.1.13.1) doit être présent.
            </assert>
            <assert test="cda:templateId[@root='1.2.250.1.213.1.1.1.5']"> 
                [CI-SIS_CertificatSanteCS8] Erreur: Le template parent "Certificat de Santé de l'Enfant" (1.2.250.1.213.1.1.1.5) doit être présent.
            </assert>
            
            <assert test="./cda:code[@code='CERT_DECL' and @codeSystem='1.2.250.1.213.1.1.4.12']"> 
                [CI-SIS_CertificatSanteCS8] Erreur de conformité CS8 : 
                L'élément code doit avoir @code ="CERT_DECL" et @codeSystem = "1.2.250.1.213.1.1.4.12"/>. </assert>
        </rule>
    </pattern>
</schema>
