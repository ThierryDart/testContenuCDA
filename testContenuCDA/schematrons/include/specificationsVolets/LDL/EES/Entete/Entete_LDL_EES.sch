<?xml version="1.0" encoding="UTF-8"?>

<!--                  
    Entete_LDL_EES.sch
    Teste la conformité de l'entete du volet LDL_EES au CI-SIS
    
    Historique :
    07/02/2018 :  NMA : Création
    
-->


<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="Entete_LDL_EES">
    
    <rule context='cda:ClinicalDocument'>
        
        <assert test="cda:code[@code='18761-7']">
            [Entete_LDL_EES] Le code du document LDL doit être égal à '18761-7'
        </assert>
        
        <assert test="cda:recordTarget/cda:patientRole/cda:patient/cda:birthTime">
            [Entete_LDL_EES] La date de naissance du patient est obligatoirement présente
        </assert>
        
        <assert test="cda:documentationOf/cda:serviceEvent/cda:code[@code='IMP']">
            [Entete_LDL_EES] L'attribut code de l'élément documentationOf/serviceEvent/code est fixé à 'IMP'
        </assert>
        
        <assert test="cda:documentationOf/cda:serviceEvent/cda:effectiveTime">
            [Entete_LDL_EES] Dans le contexte de la LDL, la date du début d'exécution de l'acte est obligatoire
        </assert>
        
    </rule>
</pattern>