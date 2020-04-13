<?xml version="1.0" encoding="UTF-8"?>


<!--                  Section note de progression ANS
    
   Teste la conformité de la section note de progression ANS (1.2.250.1.213.1.1.2.25) créée par l'ANS
    
    
    Historique :
    13/01/2020 : NMA : Création
    
-->


<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_noteProgression_ANS">
    <title>Section note de progression ANS </title>
    
    <rule context='*[cda:templateId/@root = "1.2.250.1.213.1.1.2.25"]'>
        <let name="count_templateId" value="count(cda:templateId)"/>
        
        <assert test="$count_templateId &gt; 0">
            [S_noteProgression_ANS.sch] Erreur de Conformité CI-SIS : La section doit contenir un templateId (cardinalité [1..*])
        </assert>
        
        <!-- Verifier que le templateId est utilisé pour une section -->
        <assert test="../cda:section"> 
            [S_noteProgression_ANS.sch]  Erreur de Conformité CI-SIS : Cet élément ne peut être utilisé que comme section.
        </assert>
        
        <assert test="count(cda:id)=1">
            [S_noteProgression_ANS.sch]  Erreur de Conformité CI-SIS : La section doit contenir un id (cardinalité [1..1])
        </assert>
        
        <assert test="cda:text">
            [S_noteProgression_ANS.sch]  Erreur de Conformité CI-SIS : La section doit contenir un élément text
        </assert>        
        
        <!-- Vérifier le code de la section -->
        <assert test='cda:code[@code = "18733-6"]'>
            [S_noteProgression_ANS.sch]  Erreur de Conformité CI-SIS : Le code de la section Abdomen doit être 18733-6
        </assert>
        
        <assert test='cda:code[@codeSystem = "2.16.840.1.113883.6.1"]'>
            [S_noteProgression_ANS.sch]  Erreur de Conformité CI-SIS : L'élément 'codeSystem' doit être codé à partir de la nomenclature LOINC (2.16.840.1.113883.6.1).
        </assert>
        
        <!-- Vérification des entrées obligatoires -->
        <assert test="//cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.13'">
            [S_noteProgression_ANS.sch]  Erreur de Conformité CI-SIS : L'entrée Simple observation est obligatoire (1.3.6.1.4.1.19376.1.5.3.1.4.13)
        </assert>
        
    </rule>

</pattern>
