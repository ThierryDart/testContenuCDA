<?xml version="1.0" encoding="UTF-8"?>

<!--                  -=<<o#%@O[hospital Stadies Summary Section ]O@%#o>>=-
    
    Teste la conformité de la section "hospital Stadies Summary Section" (1.3.6.1.4.1.19376.1.5.3.1.3.29)
    aux spécifications d'IHE PCC v3.0
    
    Historique :
    13/01/2020 : NMA : Création
    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_hospitalStadiesSummary">
    
    
    <title>IHE PCC v3.0 Hospital Stadies Summary Section</title>
    
    <rule context="*[cda:templateId/@root=&quot;1.3.6.1.4.1.19376.1.5.3.1.3.29&quot;]">
        <let name="count_templateId" value="count(cda:templateId)"/>
        
        <assert test="$count_templateId &gt;0">
            [S_hospitalStadiesSummary.sch] : Erreur de conformité PCC : 'hospital Stadies Summary' doit contenir au moins un templateId
        </assert>
        
        <!-- Verifier que le templateId est utilisé correctement -->
        <assert test="../cda:section"> 
            [S_hospitalStadiesSummary.sch] : Erreur de conformité PCC : 'hospital Stadies Summary' ne peut être utilisé que comme section.
        </assert>
        
        <!-- Vérifier le code de la section -->
        <assert test="cda:code[@code = &quot;11493-4&quot;]"> 
            [S_hospitalStadiesSummary.sch] : Erreur de conformité PCC : Le code de la section 'hospital Stadies Summary Section' doit être '11493-4'
        </assert>
        
        <assert test="cda:code[@codeSystem = &quot;2.16.840.1.113883.6.1&quot;]"> 
            [S_hospitalStadiesSummary.sch] : Erreur de conformité PCC : L'élément 'codeSystem' de la section 
            'Hospital Stadies Summary Section' doit être codé dans la nomenclature LOINC (2.16.840.1.113883.6.1)
        </assert>
        
         
    </rule>
</pattern>
