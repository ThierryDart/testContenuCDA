<?xml version="1.0" encoding="UTF-8"?>

<!--                  -=<<o#%@O[ E_teeth_CSE.sch ]O@%#o>>=-
    
    Teste les entrées des examens physiques relatifs au système dentaire du volet du CI-SIS Certificats de santé de l'enfant 
    CS9, et CS24 pour la section "Coded Physical Exam Section/teeth" 
    
    Historique :
    24/06/11 : CRI : Création
    12/10/17 : NMA : Ajout du nom du schématron sur les messages d'erreur
    22/11/17 : NMA : Mise à jour des codes TA_CS ==> TA_ASIP
    
-->


<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_teeth_CSE">
    <title>IHE PCC v3.0 Teeth</title>
    
    <!-- ****** Contexte = sous-section Dents ****** -->
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.1.9.23"]'>
        
        <!-- fente labio-palatine -->
        <assert test='not(/cda:ClinicalDocument/cda:templateId[@root="1.2.250.1.213.1.1.1.5.3"] or /cda:ClinicalDocument/cda:templateId[@root="1.2.250.1.213.1.1.1.5.2"]) or
            .//cda:entry/cda:observation[@negationInd]/cda:value/@code="D4-51450"'>
            [E_teeth_CSE.sch] Erreur de Conformité volet CSE: L'absence ou la présence de la fente labio-palatine doit obligatoirement être mentionnée à partir du booléen observation/@negationInd
        </assert>
        
        <!-- Nombre total de dents -->
        <assert test='not(/cda:ClinicalDocument/cda:templateId[@root="1.2.250.1.213.1.1.1.5.3"]) or
            .//cda:entry/cda:observation[@negationInd]/cda:value/@code="MED-188"'>
            [E_teeth_CSE.sch] Erreur de Conformité volet CSE: L'absence ou la présence d'un comptage des dents doit obligatoirement être mentionnée à partir du booléen observation/@negationInd
        </assert>

        <!-- Nombre total de caries -->
        <assert test='not(/cda:ClinicalDocument/cda:templateId[@root="1.2.250.1.213.1.1.1.5.3"]) or
            .//cda:entry/cda:observation[@negationInd]/cda:value/@code="D5-10110"'>
            [E_teeth_CSE.sch] Erreur de Conformité volet CSE: L'absence ou la présence d'un comptage de dents cariées doit obligatoirement être mentionnée à partir du booléen observation/@negationInd
        </assert>

    </rule>
</pattern>



