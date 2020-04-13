<?xml version="1.0" encoding="UTF-8"?>


<!--                  Section Facteurs de risque  ASIP Santé
    
   Teste la conformité de la section facteurs de rique  (1.2.250.1.213.1.1.2.7) créée par l'ANS
    
    
    Historique :
    17/08/2017 : LBE : Création
    
-->


<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_facteursDeRisque_ANS">
    <title>ANS Section Facteurs de risque </title>
    
    <rule context='*[cda:templateId/@root = "1.2.250.1.213.1.1.2.7"]'>
        <let name="count_templateId" value="count(cda:templateId)"/>
        
        <assert test="$count_templateId&gt;0">
            [S_facteursDeRisque_ANS.sch] Erreur de Conformité CI-SIS (Section ANS) : La section doit contenir un templateId (cardinalité [1..*])
        </assert>
        
        <!-- Verifier que le templateId est utilisé pour une section -->
        <assert test="../cda:section"> 
            [S_facteursDeRisque_ANS.sch] Erreur de Conformité CI-SIS (Section ANS) : Cet élément ne peut être utilisé que comme section.
        </assert>
        
        <assert test="count(cda:id)=1">
            [S_facteursDeRisque_ANS.sch] Erreur de Conformité CI-SIS (Section ANS) : La section doit contenir un id (cardinalité [1..1])
        </assert>

        <!-- Vérifier le code de la section -->
        <assert test='cda:code[@code = "57207-3"]'>
            [S_facteursDeRisque_ANS.sch] Erreur de Conformité CI-SIS (Section ANS) : Le code de la section 'Facteurs de risque' doit être '57207-3'
        </assert>
        
        <assert test='cda:code[@codeSystem = "2.16.840.1.113883.6.1"]'>
            [S_facteursDeRisque_ANS.sch] Erreur de Conformité CI-SIS (Section ANS) : L'élément 'codeSystem' doit être codé à partir de la nomenclature LOINC (2.16.840.1.113883.6.1).
        </assert>

    </rule>

</pattern>
