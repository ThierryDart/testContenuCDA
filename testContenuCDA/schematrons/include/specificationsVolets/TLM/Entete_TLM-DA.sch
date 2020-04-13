<?xml version="1.0" encoding="UTF-8"?>

<!--                  
    Entete_TLM-DA.sch
    Teste la conformité de l'entete du document TLM-DA au CI-SIS
    
    Historique :
    02/09/2019 : Création
    19/12/2019 : Corrections
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="Entete_TLM-DA">

    <rule context='cda:ClinicalDocument'>
        <assert test="cda:code[@code='75496-0']">
            [Entete_TLM-DA] Le code du document TLM-DA doit être égal à '75496-0'
        </assert>
    </rule>
        
    <rule context="cda:ClinicalDocument/cda:documentationOf">
        <assert test="cda:serviceEvent/cda:code and (cda:serviceEvent/cda:code[@code='TCG'])">
            [Entete_TLM-DA] Le code de l'acte documenté est obligatoire et doit être égal à 'TCG' ou 'TC' ou 'TE1' ou 'TE2'.            
        </assert>
    </rule>
    
</pattern>