<?xml version="1.0" encoding="UTF-8"?>

<!--                  -=<<o#%@O[ E_endocrine_CSE.sch ]O@%#o>>=-
    
    Teste les entrées des examens physiques relatifs aux fonctions endocriniennes 
    et métaboliques du volet du CI-SIS Certificats de santé de l'enfant 
    CS9, et CS24 pour la section "Coded Physical Exam Section/Système 
    Endocrinien et Métabolique"
    
    Historique :
    27/06/11 : CRI : Création
    25/07/11 : CRI: ajout des éléments cliniques des volets CS8, CS9 et CS24
    11/10/17 : NMA : Ajout du nom du schématron sur les messages d'erreur
    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_endocrine_CSE">
    <title>IHE PCC v3.0 Endocrine System</title>
    
    <!-- ****** Contexte = section Endocrinien et Métabolique ****** -->
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.1.9.25"]'>

        <assert test='.//cda:entry/cda:observation/cda:code[@codeSystem="1.2.250.1.213.2.12"]'>
            [E_endocrine_CSE.sch] Erreur de Conformité volet CSE: L'attribut codeSystem de l'élément "code" d'une observation de l'examen physique est fixé à la valeur "1.2.250.1.213.2.12"
        </assert>
        
        <assert test='.//cda:entry/cda:observation[@negationInd]/cda:value/@code="D6-00000"'>
            [E_endocrine_CSE.sch] Erreur de Conformité volet CSE: L'absence ou la présence de maladie métabolique doit obligatoirement être mentionnée à partir du booléen observation/@negationInd
        </assert>
        <report test='(.//cda:entry/cda:observation[@negationInd="false"]/cda:value/@code="D6-00000") and 
            (.//cda:entry/cda:observation[cda:value/@code="D6-00000"]/cda:entryRelationship/cda:act/cda:text="")'>
            [E_endocrine_CSE.sch] Erreur de Conformité volet CSE: Dans le cas d'une présence de maladie métabolique, préciser laquelle 
        </report>
        <report test='(.//cda:entry/cda:observation[@negationInd="true"]/cda:value/@code="D6-00000") and 
            (.//cda:entry/cda:observation[cda:value/@code="D6-00000"]/cda:entryRelationship/cda:act/cda:text!="")'> 
            [E_endocrine_CSE.sch] Erreur de Conformité volet CSE: Dans le cas d'une autre affection du système signalée, 
            le booléen cda:observation/@negationInd doit être fixé à la valeur "false" 
            sinon l'élément cda:entry/cda:observation/cda:entryRelationship/cda:act/cda:text doit être vide
        </report>
        
        <assert test='.//cda:entry/cda:observation[@negationInd]/cda:value/@code="DB-00000"'>
            [E_endocrine_CSE.sch] Erreur de Conformité volet CSE: L'absence ou la présence de maladie endocrinienne doit obligatoirement être mentionnée à partir du booléen observation/@negationInd
        </assert>
        <report test='(.//cda:entry/cda:observation[@negationInd="false"]/cda:value/@code="DB-00000") and 
            (.//cda:entry/cda:observation[cda:value/@code="DB-00000"]/cda:entryRelationship/cda:act/cda:text="")'>
            [E_endocrine_CSE.sch] Erreur de Conformité volet CSE: Dans le cas d'une présence de maladie endocrinienne, préciser laquelle 
        </report>
        <report test='(.//cda:entry/cda:observation[@negationInd="true"]/cda:value/@code="DB-00000") and 
            (.//cda:entry/cda:observation[cda:value/@code="DB-00000"]/cda:entryRelationship/cda:act/cda:text!="")'> 
            [E_endocrine_CSE.sch] Erreur de Conformité volet CSE: Dans le cas d'une autre affection du système signalée, 
            le booléen cda:observation/@negationInd doit être fixé à la valeur "false" 
            sinon l'élément cda:entry/cda:observation/cda:entryRelationship/cda:act/cda:text doit être vide
        </report>
    </rule>
</pattern>

