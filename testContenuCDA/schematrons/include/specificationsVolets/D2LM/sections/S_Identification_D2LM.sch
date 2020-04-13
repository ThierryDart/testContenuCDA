<?xml version="1.0" encoding="UTF-8"?>

<!--  IHE PCC v3.0  Section: 1.2.250.1.213.1.1.2.56 -->

<!--                  -=<<o#%@O[ S_Identification_D2LM.sch ]O@%#o>>=-
    
    Teste la conformité de la sur-section "Identification" (1.2.250.1.213.1.1.2.56)
    aux spécifications du volet D2LM du CI-SIS de l'ASIP Santé sur le contenu de
    la section.    
    
    Historique :
    23/10/17 : NMA : Création
    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_identification_D2LM">
    <title>CI-SIS D2LM Section Identification</title>
    
    <rule context='*[cda:templateId/@root="1.2.250.1.213.1.1.2.56"]'>
        <!-- Présence obligatoire de la section Procédures et interventions -->
        <assert test='.//cda:templateId[@root = "1.3.6.1.4.1.19376.1.5.3.1.1.13.2.11"]'>
            [S_Identification_D2LM.sch] Erreur de Conformité volet D2LM: La  section 'Procedures et interventions' est obligatoire dans la sur-section Identification.
        </assert>  
        <assert test='.//cda:code[@code = "45964-4"]'>
            [S_Identification_D2LM.sch] Erreur de Conformité volet D2LM: Le code de la section 'Identification' doit être "45964-4"
        </assert>  
        <assert test='.//cda:code[@codeSystem = "2.16.840.1.113883.6.1"]'>
            [S_Identification_D2LM.sch] Erreur de Conformité volet D2LM: Le code de la section 'Identification' doit faire partie de la nomenclature LOINC
        </assert>  
        
    </rule>
    
</pattern>