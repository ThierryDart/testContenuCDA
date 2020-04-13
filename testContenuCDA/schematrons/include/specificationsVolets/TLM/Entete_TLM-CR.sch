<?xml version="1.0" encoding="UTF-8"?>

<!--                  
    Entete_TLM-CR.sch
    Teste la conformité de l'entete du volet TLM-CR au CI-SIS
    
    Historique :
    19/12/2019 :  ASIP : Création
    
-->


<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="Entete_TLM-CR">

    <rule context='cda:ClinicalDocument'>
        <assert test="cda:code[@code='85208-7']">
            [Entete_TLM] Le code du document TLM-CR doit être égal à '85208-7'
        </assert>
    </rule>
        
    <rule context="cda:ClinicalDocument/cda:documentationOf">
        <assert test="cda:serviceEvent/cda:code and (cda:serviceEvent/cda:code[@code='TCG' or @code = 'TC' or @code = 'TE1' or @code = 'TE2'])">
            [Entete_TLM] Le code de l'acte documenté est obligatoire et doit être égal à :	
            ‘TCG’ Consultation à distance réalisée entre un patient et un médecin généraliste ou spécialiste en médecine générale dit « téléconsultant », ou
            ‘TC’ Consultation à distance réalisée entre un patient et un médecin non généraliste ou non spécialiste en médecine générale dit « téléconsultant », ou
            ‘TE1’ Acte de téléexpertise de niveau 1 d’un médecin sollicité par un autre médecin, ou
            ‘TE2’ Acte de téléexpertise de niveau 2 d’un médecin sollicité par un autre médecin.
            
        </assert>
    </rule>
    
</pattern>