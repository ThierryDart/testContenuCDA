<?xml version="1.0" encoding="UTF-8"?>

<!-- 
    patient.sch :
    Contenu :
        Contrôle du patient dans l'en-tête CDA  
    Paramètres d'appel :
        Néant
    Historique :
    31/05/11 : FMY ASIP/PRAS : Création
    28/07/11 : FMY ASIP/PRAS : Contrôle de la présence d'adresse géographique (addr) et télécom (telecom)
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="recordTarget_fr">
    <rule context="cda:ClinicalDocument/cda:recordTarget/cda:patientRole">
        <let name="count_name_patient" value="count(cda:patient/cda:name)"/>
        <let name="count_name_guardianPerson" value="count(cda:patient/cda:guardian/cda:guardianPerson/cda:name)"/>
        <assert test="not(cda:id[@nullFlavor])">
            [recordTarget_fr.sch] Erreur de conformité CI-SIS : L'élément recordTarget/patientRole/id (obligatoire dans CDAr2), 
            doit être sans nullFlavor. 
        </assert>
        <assert test="cda:addr">
            [recordTarget_fr.sch] Erreur de conformité CI-SIS : l'élément recordTarget/patientRole/addr doit être présent 
            avec une adresse géographique ou un nullFlavor autorisé.
        </assert>
        <assert test="cda:telecom">
            [recordTarget_fr.sch] Erreur de conformité CI-SIS : l'élément recordTarget/patientRole/telecom doit être présent 
            avec une adresse de télécommunication ou un nullFlavor autorisé.
        </assert>
        <assert test="$count_name_patient = 1">
            [recordTarget_fr.sch] Erreur de conformité CI-SIS : L'élément recordTarget/patientRole/patient/name ne doit être présent qu'une fois
        </assert>
        
        <assert test="
            not(cda:patient/cda:religiousAffiliationCode) and
            not(cda:patient/cda:raceCode) and
            not(cda:patient/cda:ethnicGroupCode) 
            ">
            [recordTarget_fr.sch] Erreur de conformité CI-SIS : Un élément recordTarget/patientRole/patient 
            ne doit contenir ni race ni religion ni groupe ethnique.
        </assert>
        <assert test="$count_name_guardianPerson &lt;= 1">
            [recordTarget_fr.sch] Erreur de conformité CI-SIS : L'élément recordTarget/patientRole/patient/guardian/guardianPerson/name ne doit être présent qu'une fois
        </assert>
        <assert test="cda:patient/cda:birthTime">
            [recordTarget_fr.sch] Erreur de conformité CI-SIS : l'élément recordTarget/patientRole/patient/birthTime doit être présent 
            avec une date de naissance ou un nullFlavor autorisé.
        </assert>
       
    </rule>
</pattern>
