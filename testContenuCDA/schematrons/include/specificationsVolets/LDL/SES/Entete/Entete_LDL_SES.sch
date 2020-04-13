<?xml version="1.0" encoding="UTF-8"?>

<!--                  
    Entete_LDL_SES.sch
    Teste la conformité de l'entete du volet LDL_SES au CI-SIS
    
    Historique :
    07/02/2018 :  NMA : Création
    
-->


<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="Entete_LDL_SES">
    
    <rule context='cda:ClinicalDocument'>
        
        <assert test="cda:code[@code='11490-0']">
            [Entete_LDL_SES] Le code du document LDL doit être égal à '11490-0'
        </assert>
        
        <assert test="cda:recordTarget/cda:patientRole/cda:patient/cda:birthTime">
            [Entete_LDL_SES] La date de naissance du patient est obligatoirement présente
        </assert>
        
        <assert test="cda:documentationOf/cda:serviceEvent/cda:code[@code='IMP']">
            [Entete_LDL_SES] L'attribut code de l'élément documentationOf/serviceEvent/code est fixé à 'IMP'
        </assert>
        
        <assert test="cda:documentationOf/cda:serviceEvent/cda:effectiveTime">
            [Entete_LDL_SES] Dans le contexte de la LDL, la date du début d'exécution de l'acte est obligatoire
        </assert>
        
    </rule>
</pattern>