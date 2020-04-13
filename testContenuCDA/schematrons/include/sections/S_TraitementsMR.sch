<?xml version="1.0" encoding="UTF-8"?>

<!--                  -=<<o#%@O[ S_traitementsMR.sch ]O@%#o>>=-

Teste la conformité de la section "traitementsMR" (1.2.250.1.213.1.1.2.54) aux spécifications du modèle de contenu CDA

Historique :
    24/06/11 : CRI : Création
    04/07/17 : NMA : Ajout de la contrainte sur le nombre des templateIds et renommage du schématron

-->


<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_traitementsMR"> 
    <title>Section S_traitementsMR</title>
    <rule context='*[cda:templateId/@root="1.2.250.1.213.1.1.2.54"]'> 
        <!-- Verifier que le templateId est utilisé pour une section --> 
        <assert test='../cda:section'> 
            [S_traitementsMR] Erreur de Conformité : Le templateId de 'traitementsMR' ne peut être utilisé que pour une section. 
        </assert> 
        
        <!-- Verify the section type code --> 
        <assert test='cda:code[@code = "10160-0"]'> 
            [S_traitementsMR] Erreur de Conformité  : Le code de la section 'traitementsMR doit être '10160-0' 
        </assert> 
        <assert test='cda:code[@codeSystem = "2.16.840.1.113883.6.1"]'> 
            [S_traitementsMR] Erreur de Conformité  : Le code de la section doit être un code LOINC  
            system (2.16.840.1.113883.6.1). 
        </assert> 
        <assert test='.//cda:templateId[@root = "1.2.250.1.213.1.1.3.13"]'> 
            <!-- Vérifier que les entrées sont conformes -->
            [S_traitementsMR] Erreur de Conformité  : La section traitementsMR doit contenir des entrées de type "Traitement Maladie rare" (1.2.250.1.213.1.1.3.13).
        </assert> 
    </rule> 
</pattern>