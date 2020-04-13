<?xml version="1.0" encoding="UTF-8"?>

<!--                  
    Entete_CRTTN.sch
    Teste la conformité de l'entete du CR-BIO au CI-SIS
    
    Historique :
    02/02/2018 :  NMA : Création
    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="Entete_CRTTN">
    
    <rule context='cda:ClinicalDocument'>
        
        <assert test="cda:code[@code='75492-9']">
            [Entete_CRTTN] L'élément code doit être présent et égal à 75492-9
        </assert>
        
    </rule>
    
    <rule context='cda:ClinicalDocument/cda:documentationOf/cda:serviceEvent'>
        
        <assert test="cda:performer/cda:assignedEntity">
            [Entete_CRTTN] L'élément performer et le sous élément assignedEntity sont obligatoires dans le cadre du volet CRTTN
        </assert>
        <assert test="cda:performer/cda:assignedEntity/cda:representedOrganization">
            [Entete_CRTTN] Le lieu d'exercice est obligatoire dans le cadre du volet CRTTN
        </assert>
        
    </rule>
</pattern>