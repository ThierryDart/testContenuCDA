<?xml version="1.0" encoding="UTF-8"?>

<!--                  -=<<o#%@O[ procedureSteps.sch ]O@%#o>>=-
    
    Teste la conformité de la section "Procedure steps Section" (1.3.6.1.4.1.19376.1.8.1.2.6)
    aux spécifications d'IHE PaLM Suppl.APSR 2.0 (Rev 2.1 – 2018-09-28)
    
    Historique :
    21/12/2018 : NNA : Création
   
    
-->


<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_procedureSteps">


    <title>IHE Palm_Suppl_APSR V2.0 Procedure steps Section</title>

    <rule context="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.8.1.2.6']">
        
        <let name="count_templateId" value="count(cda:templateId)"/>
        
        <!-- Verifier que la section ne contient qu'un seul templateId -->
        <assert test="$count_templateId =1">
            [S_procedureSteps.sch] Erreur de conformité APSR : La section "Procedure steps" doit contenir un seul templateId (cardinalité [1..1])
        </assert>
        
        <!-- Verifier que le templateId est utilisé pour une section -->
        <assert test="../cda:section"> 
            [S_procedureSteps.sch] Erreur de Conformité APSR : Cet élément ne peut être utilisé que comme section.
        </assert>
        
        <!-- Vérifier le code de la section -->
        <assert test='cda:code[@code = "46059-2"]'>
            [S_procedureSteps.sch] Erreur de Conformité APSR : Le code de la section "Procedure steps" doit être 46059-2 </assert>
        <assert test='cda:code[@codeSystem = "2.16.840.1.113883.6.1"]'>
            [S_procedureSteps.sch] Erreur de Conformité APSR : L'élément 'codeSystem' doit être codé à partir de la nomenclature LOINC (2.16.840.1.113883.6.1).
        </assert>
        
        <!--Vérifier que les éléments text et title sont utilisés -->
        <assert test="cda:text">
            [S_procedureSteps.sch] Erreur de conformité APSR : La section "Procedure steps" doit contenir un élément text"</assert>
        <assert test="cda:title">
            [S_procedureSteps.sch] Erreur de conformité APSR : La section "Procedure steps" doit contenir un élément title"</assert>
        
                      
    </rule>
</pattern>
