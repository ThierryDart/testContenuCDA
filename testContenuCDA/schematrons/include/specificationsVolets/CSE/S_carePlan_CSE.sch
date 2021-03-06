<?xml version="1.0" encoding="UTF-8"?>

<!--  IHE PCC v3.0  Section: 1.3.6.1.4.1.19376.1.5.3.1.3.31 -->

<!--                  -=<<o#%@O[ S_carePlan_CSE.sch ]O@%#o>>=-
    
    Teste la conformité de la section "Care Plan" (1.3.6.1.4.1.19376.1.5.3.1.3.31)
    aux spécifications du volet CSE du CI-SIS de l'ASIP Santé sur le contenu de
    la section.    
    Sont rendues obligatoires les entrées:
    - Procedures
    - Encounters
    
    Historique :
    25/07/11 : CRI : Création
    11/10/17 : NMA : Ajout du nom du schématron sur les messages d'erreur
    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="S_carePlan_CSE">
    <title>CI-SIS CSE Care Plan Section</title>
    
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.3.31"]'>
 <!--       <!-\- Présence obligatoire de l'entrée Procedure -\->
        <assert test='.//cda:templateId[@root = "1.3.6.1.4.1.19376.1.5.3.1.4.19"]'>
            [S_carePlan_CSE.sch] Erreur de Conformité volet CSE: Cette section 'Care Plan' ne contient pas d'élément 'Procedure Entry'.
        </assert> -->
        <!-- Présence obligatoire de l'entrée Encounters -->
        <assert test='.//cda:templateId[@root = "1.3.6.1.4.1.19376.1.5.3.1.4.14"]'>
            [S_carePlan_CSE.sch] Erreur de Conformité volet CSE: Cette section 'Care Plan' ne contient pas d'élément 'Encounter Entry'.
        </assert>         
    </rule>
    
</pattern>