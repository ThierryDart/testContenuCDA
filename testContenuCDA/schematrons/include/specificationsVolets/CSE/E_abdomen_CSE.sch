<?xml version="1.0" encoding="UTF-8"?>


<!--                  -=<<o#%@O[ E_abdomen_CSE.sch ]O@%#o>>=-
    
    Teste les entrées des examens physiques relatifs à l'abdomen selon
    les spécifications cliniques du volet Certificats de santé de l'enfant CS9, et CS24 
    pour la section "Coded Physical Exam Section/Abdomen" 
    Note: Ce schematron est commun aux trois volets CS8, CS9, CS24
    
    Historique :
    27/06/11 : CRI : Création
    25/07/11 : CRI: ajout des éléments cliniques des volets CS8, CS9 et CS24
    22/11/17 : NMA : Mise à jour des codes TA_CS ==> TA_ASIP
    
-->


<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_abdomen_CSE">
    <title>IHE PCC v3.0 Abdomen</title>
    
    <!-- ****** Contexte = section Gastro entérologie ****** -->
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.1.9.31"]'>
        
                                        <!---=<<oO[ CS8 seulement ]Oo>>=-->
        
        <!-- Atrésie de l'oesophage -->
        <assert test='not(/cda:ClinicalDocument/cda:templateId[@root="1.2.250.1.213.1.1.1.5.1"]) or
            .//cda:entry/cda:observation[@negationInd]/cda:value/@code="D4-55002"'>
            [E_abdomen_CSE.sch] Erreur de Conformité volet CSE: L'absence ou la présence d'atrésie de l'oesophage doit obligatoirement être mentionnée à partir du booléen observation/@negationInd
        </assert>
        <!-- Omphalocèle, Gastroschisis -->
        <assert test='not(/cda:ClinicalDocument/cda:templateId[@root="1.2.250.1.213.1.1.1.5.1"]) or
            .//cda:entry/cda:observation[@negationInd]/cda:value/@code="MED-177"'>
            [E_abdomen_CSE.sch] Erreur de Conformité volet CSE: L'absence ou la présence d'omphalocèle doit obligatoirement être mentionnée à partir du booléen observation/@negationInd
        </assert>

        
                                    <!---=<<oO[ CS9 et CS24 seulement ]Oo>>=-->
               
        <!-- Reflux Gastro-oesophagien  -->
        <assert test='not(/cda:ClinicalDocument/cda:templateId[@root="1.2.250.1.213.1.1.1.5.3"] or /cda:ClinicalDocument/cda:templateId[@root="1.2.250.1.213.1.1.1.5.2"]) or
            .//cda:entry/cda:observation[@negationInd]/cda:value/@code="D5-30140"'>
            [E_abdomen_CSE.sch] Erreur de Conformité volet CSE: L'absence ou la présence de reflux gastro-oesophagien doit obligatoirement être mentionnée à partir du booléen observation/@negationInd
        </assert>
        <!-- Autre pathologie digestive -->
        <assert test='not(/cda:ClinicalDocument/cda:templateId[@root="1.2.250.1.213.1.1.1.5.3"] or /cda:ClinicalDocument/cda:templateId[@root="1.2.250.1.213.1.1.1.5.2"]) or
            .//cda:entry/cda:observation[@negationInd]/cda:value/@code="GEN-097"'>
            [E_abdomen_CSE.sch] Erreur de Conformité volet CSE: L'absence ou la présence d'une autre affection du système digestif
            doit obligatoirement être mentionnée à partir du booléen observation/@negationInd
        </assert>
        
    </rule>
</pattern>

