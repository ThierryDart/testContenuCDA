<?xml version="1.0" encoding="UTF-8"?>

<!--  IHE PCC v3.0  Section: 1.2.250.1.213.1.1.2.58 -->

<!--                  -=<<o#%@O[ S_Radiologie_D2LM.sch ]O@%#o>>=-
    
    Teste la conformité de la sur-section "Radiologie" (1.2.250.1.213.1.1.2.58)
    aux spécifications du volet D2LM du CI-SIS de l'ASIP Santé sur le contenu de
    la section.    
    
    Historique :
    23/10/17 : NMA : Création
    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_radiologie_D2LM">
    <title>CI-SIS D2LM Section de Radiologie</title>
    
    <rule context='*[cda:templateId/@root="1.2.250.1.213.1.1.2.58"]'>
        <!-- Présence obligatoire de la section coded results -->
        <assert test='.//cda:templateId[@root = "1.3.6.1.4.1.19376.1.5.3.1.3.28"]'>
            [S_radiologie_D2LM.sch] Erreur de Conformité volet D2LM: La  section 'coded results' est obligatoire dans la sur-section radiologie.
        </assert>  
        <!-- Présence obligatoire de la section active problems -->
        <assert test='.//cda:templateId[@root = "1.3.6.1.4.1.19376.1.5.3.1.3.6"]'>
            [S_radiologie_D2LM.sch] Erreur de Conformité volet D2LM: La  section 'Active problems' est obligatoire dans la sur-section radiologie.
        </assert>  
        <!-- Présence obligatoire de la section coded care plan -->
        <assert test='.//cda:templateId[@root = "1.3.6.1.4.1.19376.1.5.3.1.3.36"]'>
            [S_radiologie_D2LM.sch] Erreur de Conformité volet D2LM: La  section 'coded care plan' est obligatoire dans la sur-section radiologie.
        </assert>
        <!-- Présence obligatoire de la section images illustratives -->
        <assert test='.//cda:templateId[@root = "1.2.250.1.213.1.1.2.37"]'>
            [S_radiologie_D2LM.sch] Erreur de Conformité volet D2LM: La  section 'images illustratives' est obligatoire dans la sur-section radiologie.
        </assert>  
        <assert test='.//cda:code[@code = "22030-1"]'>
            [S_radiologie_D2LM.sch] Erreur de Conformité volet D2LM: Le code de la section 'radiologie' doit être "22030-1"
        </assert>  
        <assert test='.//cda:code[@codeSystem = "2.16.840.1.113883.6.1"]'>
            [S_radiologie_D2LM.sch] Erreur de Conformité volet D2LM: Le code de la section 'radiologie' doit faire partie de la nomenclature LOINC
        </assert>  
        
    </rule>
    
</pattern>