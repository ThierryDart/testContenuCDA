<?xml version="1.0" encoding="UTF-8"?>


<!--                  Section score Evaluation clinique ANS
    
   Teste la conformité de la score Evaluation Clinique ANS (1.2.250.1.213.1.1.2.41) créée par l'ANS
    
    
    Historique :
    17/08/2017 : LBE : Création
    
-->


<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_scoreEvaluationClinique_ANS">
    <title>Section score Evaluation Clinique ANS </title>
    
    <rule context='*[cda:templateId/@root = "1.2.250.1.213.1.1.2.41"]'>
        <let name="count_templateId" value="count(cda:templateId)"/>
        
        <assert test="$count_templateId &gt; 0">
            [S_scoreEvaluationClinique_ANS.sch] Erreur de Conformité CI-SIS : La section doit contenir un templateId
        </assert>
        
        <!-- Verifier que le templateId est utilisé pour une section -->
        <assert test="../cda:section"> 
            [S_scoreEvaluationClinique_ANS.sch]  Erreur de Conformité CI-SIS : Cet élément ne peut être utilisé que comme section.
        </assert>
        
        <assert test="count(cda:id)=1">
            [S_scoreEvaluationClinique_ANS.sch]  Erreur de Conformité CI-SIS : La section doit contenir un id (cardinalité [1..1])
        </assert>
        
        <assert test="cda:text">
            [S_scoreEvaluationClinique_ANS.sch]  Erreur de Conformité CI-SIS : La section doit contenir un élément text
        </assert>        
        
        <!-- Vérifier le code de la section -->
        <assert test='cda:code[@code = "47420-5"]'>
            [S_scoreEvaluationClinique_ANS.sch]  Erreur de Conformité CI-SIS : Le code de la section Abdomen doit être 47420-5
        </assert>
        
        <assert test='cda:code[@codeSystem = "2.16.840.1.113883.6.1"]'>
            [S_scoreEvaluationClinique_ANS.sch]  Erreur de Conformité CI-SIS : L'élément 'codeSystem' doit être codé à partir de la nomenclature LOINC (2.16.840.1.113883.6.1).
        </assert>
        
        <!-- Vérification des entrées obligatoires -->
        <assert test="//cda:templateId/@root='1.2.250.1.213.1.1.2.40' and //cda:templateId/@root='1.2.250.1.213.1.1.2.40' and //cda:templateId/@root='1.2.250.1.213.1.1.2.36'">
            [S_scoreEvaluationClinique_ANS.sch]  Erreur de Conformité CI-SIS : Les entrées optionnelles autorisées sont : 
            score de rankin (1.2.250.1.213.1.1.2.39)
            score de glasgow (1.2.250.1.213.1.1.2.40)
            score NIHSS (1.2.250.1.213.1.1.2.36)
        </assert>
        
    </rule>

</pattern>
