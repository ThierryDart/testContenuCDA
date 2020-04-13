<?xml version="1.0" encoding="UTF-8"?>

<!--                  
    Corps_CRGM.sch
    Teste la conformité du Corps du volet CR-GM au CI-SIS (Présence obligatoire de 5 sections)
    
    Historique :
    10/01/2019 :  NNA : Création
    
-->


<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="Corps_CRGM">

    <rule context='cda:ClinicalDocument'>
        
        <!-- Présence obligatoire de Clinical Informations section / Informations cliniques (1.3.6.1.4.1.19376.1.8.1.2.1) -->
        <assert test='.//cda:templateId[@root = "1.3.6.1.4.1.19376.1.8.1.2.1"]'>
            [Corps_CRGM.sch] Erreur de Conformité au volet CRGM: La section Informations cliniques (1.3.6.1.4.1.19376.1.8.1.2.1)est obligatoire  
        </assert>
        
        <!-- Présence obligatoire de Procedure Steps Section / Section Prélèvment (1.3.6.1.4.1.19376.1.8.1.2.6) -->
        <assert test='.//cda:templateId[@root = "1.3.6.1.4.1.19376.1.8.1.2.6"]'>
            [Corps_CRGM.sch] Erreur de Conformité au volet CRGM: La section Prélèvment (1.3.6.1.4.1.19376.1.8.1.2.6) est obligatoire  
        </assert>
        
        <!-- Présence obligatoire de Macroscopic Observation Section / Section Observation macroscopique (1.3.6.1.4.1.19376.1.8.1.2.3) -->
        <assert test='.//cda:templateId[@root = "1.3.6.1.4.1.19376.1.8.1.2.3"]'>
            [Corps_CRGM.sch] Erreur de Conformité au volet CRGM: La section Observation macroscopique (1.3.6.1.4.1.19376.1.8.1.2.3) est obligatoire  
        </assert>
        
        <!-- Présence obligatoire de Diagnostic Conclusion section / Section Conclusion du diagnostic (1.3.6.1.4.1.19376.1.8.1.2.5) -->
        <assert test='.//cda:templateId[@root = "1.3.6.1.4.1.19376.1.8.1.2.5"]'>
            [Corps_CRGM.sch] Erreur de Conformité au volet CRGM: La section Conclusion du diagnostic (1.3.6.1.4.1.19376.1.8.1.2.5) est obligatoire  
        </assert>
        
        <!-- Présence obligatoire de Additional Specified Section / Section Constatation(s) pathologique(s) complémentaire(s) (1.3.6.1.4.1.19376.1.3.10.3.1) -->
        <assert test='.//cda:templateId[@root = "1.3.6.1.4.1.19376.1.3.10.3.1"]'>
            [Corps_CRGM.sch] Erreur de Conformité au volet CRGM: La section Constatation(s) pathologique(s) complémentaire(s) (1.3.6.1.4.1.19376.1.3.10.3.1) est obligatoire  
        </assert>
        
    </rule>      
       
</pattern>