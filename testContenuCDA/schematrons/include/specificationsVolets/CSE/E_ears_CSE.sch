<?xml version="1.0" encoding="UTF-8"?>

<!--                  -=<<o#%@O[ E_ears_CSE.sch ]O@%#o>>=-
    
    Teste les entrées des examens physiques relatifs aux fonctions auditives du volet du CI-SIS Certificats de santé de l'enfant 
    CS9, et CS24 pour la section "Coded Physical Exam Section/Ears" 
    
    Historique :
    27/06/11 : CRI : Création
    21/11/17 : NMA : Mise à jour des codes TA_CS ==> TA_ASIP
    
    15/05/18 : NMA : Limiter le test de l'examen auditif aux CSE9 et CSE24
    
-->


<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_ears_CSE">
    <title>IHE PCC v3.0 Ears</title>
    
    <!-- ****** Contexte = sous-section Apparence générale ****** -->
    
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.1.9.21"]'>
        
        <!-- Entrée Examen auditif -->
        <assert test='not(/cda:ClinicalDocument/cda:templateId[@root="1.2.250.1.213.1.1.1.5.3"] or /cda:ClinicalDocument/cda:templateId[@root="1.2.250.1.213.1.1.1.5.2"]) or
            .//cda:entry/cda:observation[@negationInd]/cda:value/@code="MED-178"'>
            [E_ears_CSE] L'absence ou la présence d'un examen auditif normal doit obligatoirement être mentionnée à partir du booléen observation/@negationInd
        </assert>
    </rule>
</pattern>
