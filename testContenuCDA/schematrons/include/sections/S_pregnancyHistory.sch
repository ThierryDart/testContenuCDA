<?xml version="1.0" encoding="UTF-8"?>

<!--                  -=<<o#%@O[ pregnancyHistorySection.sch ]O@%#o>>=-
    
    Teste la conformité de la section "Pregnancy History Section" (1.3.6.1.4.1.19376.1.5.3.1.1.5.3.4)
    aux spécifications d'IHE PCC v3.0
    
    Historique :
    25/07/11 : CRI : Création
    03/07/17 : NMA : Ajout de la contrainte sur le nombre des templateIds et renommage du schématron
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_pregnancyHistory">
    <title>IHE PCC v3.0 Pregnancy History Section</title>
    
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.1.5.3.4"]'> 
        <!-- Verifier que le templateId est utilisé pour une section --> 
        <assert test='../cda:section'> 
            [S_pregnancyHistory] Erreur de conformité PCC: Le templateId de 'Pregnancy History' ne peut être utilisé que pour une section. 
        </assert>
        
        <assert test='count(cda:templateId)=1'> 
            [S_pregnancyHistory] Erreur de conformité PCC: Un seul templateId doit être présent pour cette section
        </assert>
        
        <!-- Vérifier le code de la section --> 
        <assert test='cda:code[@code = "10162-6"]'> 
            [S_pregnancyHistory] Erreur de conformité PCC: Le code utilisé pour la section "Pregnancy History" doit être "10162-6" 
        </assert> 
        
        <assert test='cda:code[@codeSystem = "2.16.840.1.113883.6.1"]'> 
            [S_pregnancyHistory] Erreur de conformité PCC: La nomenclature LOINC doit être utilisée pour coder la section "Pregnancy History"  
            system (2.16.840.1.113883.6.1). 
        </assert> 
        <!-- vérifier que les entrées utilisées dans cette sectionb sont de type Pregnancy Observation" -->
        <assert test='.//cda:templateId[@root ="1.3.6.1.4.1.19376.1.5.3.1.4.13.5"]'>
            [S_pregnancyHistory] Erreur de conformité PCC: Une section Pregnancy History doit comporter des entrées de type Pregnancy Observation</assert> 
    </rule>
</pattern>