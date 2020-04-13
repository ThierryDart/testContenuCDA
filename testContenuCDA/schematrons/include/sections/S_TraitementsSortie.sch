<?xml version="1.0" encoding="UTF-8"?>

<!--                  -=<<o#%@O[ S_TraitementsSortie.sch ]O@%#o>>=-

Teste la conformité de la section "Traitements à la sortie" (1.2.250.1.213.1.1.2.4) aux spécifications du modèle de contenu CDA

Historique :
    13/01/2020 : NMA : Création

-->


<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_TraitementsSortie"> 
    <title>Section Traitements à la sortie</title>
    <rule context='*[cda:templateId/@root="1.2.250.1.213.1.1.2.4"]'> 
        
        <!-- Verifier que le templateId est utilisé pour une section --> 
        <assert test='../cda:section'> 
            [S_TraitementsSortie] Erreur de Conformité : Le templateId de 'Traitements à la sortie' ne peut être utilisé que pour une section. 
        </assert> 
        
        <!-- Verify the section type code --> 
        <assert test='cda:code[@code = "10183-2"]'> 
            [S_TraitementsSortie] Erreur de Conformité  : Le code de la section 'Traitements à la sortie doit être '10160-0' 
        </assert> 
        
        <assert test='cda:code[@codeSystem = "2.16.840.1.113883.6.1"]'> 
            [S_TraitementsSortie] Erreur de Conformité  : Le code de la section doit être un code LOINC  
            system (2.16.840.1.113883.6.1). 
        </assert> 
        
    </rule> 
</pattern>