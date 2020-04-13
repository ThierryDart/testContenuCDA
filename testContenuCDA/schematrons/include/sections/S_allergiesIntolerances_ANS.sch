<?xml version="1.0" encoding="UTF-8"?>

<!--                  -=<<o#%@O[ S_allergiesIntolerances_ANS.sch ]O@%#o>>=-
    
    - Teste la conformité de la section " allergies et intolerances ANS" (1.2.250.1.213.1.1.2.8)
    
    Historique :
    
    13/01/2020 : NMA : Création
    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_allergiesIntolerances_ANS">
    <title>Section Allergies et intolérances ANS</title>
    
    <rule context='*[cda:templateId/@root="1.2.250.1.213.1.1.2.8"]'> 
        <let name="count_templateId" value="count(cda:templateId)"/>
        
        <assert test="$count_templateId&gt;0">
            [S_allergiesIntolerances_ANS] Erreur de conformité PCC : Allergies et intolérances doit contenir au moins un templateId
        </assert>
        <!-- Verifier que le templateId est utilisé à bon escient --> 
        <assert test='../cda:section'> 
            [S_allergiesIntolerances_ANS]: Allergies et intolérances ne peut être utilisé que dans une section. 
        </assert> 
        <!-- Vérifier le code de la section --> 
        <assert test='cda:code[@code = "48765-2"]'> 
            [S_allergiesIntolerances_ANS]: Le code de la section Allergies and Intolerance doit être 48765-2
        </assert> 
        <assert test='cda:code[@codeSystem = "2.16.840.1.113883.6.1"]'> 
            [S_allergiesIntolerances_ANS]: L'élément 'codeSystem' doit être codé dans la nomenclature LOINC (2.16.840.1.113883.6.1). 
        </assert> 
    </rule> 
</pattern>

