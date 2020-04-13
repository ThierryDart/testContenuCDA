<?xml version="1.0" encoding="UTF-8"?>

<!--                  -=<<o#%@O[ E_lymphatic_CSE.sch ]O@%#o>>=-
    
    Teste les entrées des examens physiques relatifs aux fonctions hématopoïetiques et lymphatiques du volet du CI-SIS Certificats de santé de l'enfant 
    CS9, et CS24 pour la section "Coded Physical Exam Section/Lymphatic System" 
    
    Historique :
    24/06/11 : CRI : Création
    
-->


<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_lymphatic_CSE">
    <title>IHE PCC v3.0 Lymphatic System</title>
    
    <!-- ****** Contexte = section Hématopoïèse ****** -->
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.1.9.32"]'>
        
        <!-- Observation: Maladie de l'hémoglobine -->
        <assert test='.//cda:entry/cda:observation[@negationInd]/cda:value/@code="DC-20000"'> 
            <!-- Note any missing optional elements -->
            [E_lymphatic_CSE.sch] Erreur de Conformité volet CSE: L'absence ou la présence de maladie de l'hémoglobine doit obligatoirement être mentionnée à partir du booléen observation/@negationInd
        </assert>
        <!-- Observation: autre pathologie -->
        <assert test='.//cda:entry/cda:observation[@negationInd]/cda:value/@code="GEN-097"'> 
            <!-- Note any missing optional elements -->
            [E_lymphatic_CSE.sch] Erreur de Conformité volet CSE: L'absence ou la présence d'une autre affection de l'hématopoièse doit obligatoirement être mentionnée à partir du booléen observation/@negationInd
        </assert>
    </rule>
</pattern>
