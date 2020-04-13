<?xml version="1.0" encoding="UTF-8"?>

<!--                  
    Entete_VAC.sch
    Teste la conformité de l'entete du volet Vaccination au CI-SIS
    
    Historique :
    02/02/2018 : Création
    02/09/2019 : Remplacement du code de l'acte principal "P0-00120" ("Certificat médical" - SNOMED 3.5) par "87273-9" ("Note de vaccination" - LOINC)
-->


<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="Entete_VAC">
    
    <rule context='cda:ClinicalDocument/cda:recordTarget/cda:patientRole/cda:patient'>
        <assert test="cda:birthTime">
            [Entete_VAC] La date de naissance du patient est obligatoirement présente 
        </assert>
    </rule>
    
    <rule context="cda:ClinicalDocument/cda:documentationOf/cda:serviceEvent">
        <assert test="cda:code[@code='87273-9']">
            [Entete_VAC] Le code de l'acte principal est codé et est fixé à code ="87273-9" 
        </assert>
    </rule>
    
</pattern>