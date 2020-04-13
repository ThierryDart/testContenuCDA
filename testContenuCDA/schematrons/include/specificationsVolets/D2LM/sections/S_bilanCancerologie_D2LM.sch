<?xml version="1.0" encoding="UTF-8"?>
<!--  IHE PCC v3.0  Section: 1.2.250.1.213.1.1.2.59 -->

<!--                  -=<<o#%@O[ S_bilanCancerologie_D2LM.sch ]O@%#o>>=-
    
    Teste la conformité de la sur-section "Bilan Cancérologie" (1.2.250.1.213.1.1.2.59)
    aux spécifications du volet D2LM du CI-SIS de l'ASIP Santé sur le contenu de
    la section.    
    
    Historique :
    23/10/17 : NMA : Création
    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_bilanCancerologie_D2LM">
    <title>CI-SIS D2LM Section Bilan Cancérologie</title>
    
    <rule context='*[cda:templateId/@root="1.2.250.1.213.1.1.2.59"]'>
        <!-- Présence obligatoire de la section coded results -->
        <assert test='.//cda:templateId[@root = "1.3.6.1.4.1.19376.1.5.3.1.3.28"]'>
            [S_bilanCancerologie_D2LM.sch] Erreur de Conformité volet D2LM: La  section 'coded results' est obligatoire dans la sur-section Bilan Cancérologie.
        </assert>
        <!-- Présence obligatoire de la section coded care plan -->
        <assert test='.//cda:templateId[@root = "1.3.6.1.4.1.19376.1.5.3.1.3.36"]'>
            [S_bilanCancerologie_D2LM.sch] Erreur de Conformité volet D2LM: La  section 'coded care plan' est obligatoire dans la sur-section Bilan Cancérologie.
        </assert>  
        <!-- Présence obligatoire de la section coded event outcomes -->
        <assert test='.//cda:templateId[@root = "1.3.6.1.4.1.19376.1.5.3.1.1.21.2.9"]'>
            [S_bilanCancerologie_D2LM.sch] Erreur de Conformité volet D2LM: La  section 'coded event outcomes' est obligatoire dans la sur-section Bilan Cancérologie.
        </assert>  
       
        <assert test='.//cda:code[@code = "72135-7"]'>
            [S_bilanCancerologie_D2LM.sch] Erreur de Conformité volet D2LM: Le code de la section 'Bilan Cancérologie' doit être "72135-7"
        </assert>  
        <assert test='.//cda:code[@codeSystem = "2.16.840.1.113883.6.1"]'>
            [S_bilanCancerologie_D2LM.sch] Erreur de Conformité volet D2LM: Le code de la section 'Bilan Cancérologie' doit faire partie de la nomenclature LOINC
        </assert>  
        
    </rule>
    
</pattern>