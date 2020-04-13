<?xml version="1.0" encoding="UTF-8"?>

<!--                  -=<<o#%@O[ ER_severity_int.sch ]O@%#o>>=-
    
    Teste la conformité d'une entrée utilisée dans le volet du CI-SIS aux spécifications de l'entryRelationship
    PCC severity (1.3.6.1.4.1.19376.1.5.3.1.4.1)  
    
    
    Historique :
    22/06/17 : NMA : Création
    22/06/17 : NMA : Ajout des contraintes internationales 
    05/10/17 : NMA : Modification du test sur la value
    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="ER_severity_int">

    <title>IHE PCC v3.0 Severity</title>
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.4.1"]'>
        <let name="count_templateId" value="count(cda:templateId)"/>
        
        <assert test='../../cda:entryRelationship[@typeCode="SUBJ" and @inversionInd="true"]'>
            [ER_severity_int]Erreur de Conformité PCC: Une entrée 'severity' représente la sévérité et sera de la même manière représentée comme une élément de type 'observation' 
            avec un attribut typeCode='SUBJ' et un inversionIND='true'.</assert>
        
        <assert
            test="self::cda:observation[@classCode='OBS' and @moodCode='EVN']">
            [ER_severity_int] Erreur de conformité PCC : Dans l'élément "severity", le format de base utilisé pour 
            représenter un problème utilise l'élément CDA 'observation' d'attribut classCode='OBS' pour
            signifier qu'il s'agit l'observation d'un problème, et moodCode='EVN', pour exprimer 
            que l'événement a déjà eu lieu. </assert>
        
        <assert test='cda:templateId[@root="2.16.840.1.113883.10.20.1.55"]'>
            [ER_severity_int]Erreur de Conformité PCC: Le template parent (2.16.840.1.113883.10.20.1.55) sera déclaré.</assert>
        
        <assert test="$count_templateId=2">
            [ER_severity_int] Erreur de conformité PCC : Dans l'élément "Severity", il doit y avoir deux templateId
        </assert>

        <assert test='cda:code[@code and @codeSystem]'>
            [ER_severity_int] Erreur de Conformité PCC: L'élément 'code' de l'entrée 'severity' indique la 
            sévérité de l'allergie provoquée.
            L'élément 'code' doit obligatoirement comporter les attributs 'code' et 'codeSystem'.</assert>
        
        <assert test="cda:text/cda:reference[@value]">
            [ER_severity_int] Erreur de conformité PCC : L'élément text doit être présent avec un élément reference qui contient une URI dans l'attribut @value
        </assert>
        
        <assert test="cda:statusCode[@code='completed']"> 
            [ER_severity_int] Erreur de conformité PCC : Le composant "statutCode" d'un élément "health Status Observation" sera toujours fixé à la valeur code='completed'. </assert>
        
<!--        <assert test='(cda:value[@xsi:type="CD"]) and 
            (cda:value[(@code = "H" or @code = "M" or @code = "L" ) and @codeSystem="2.16.840.1.113883.5.1063"] or cda:value[not(@code) and not(@codeSystem)])'>
            [ER_severity_int] Erreur de Conformité PCC: Alors que l'élément 'value' peut être un caractère codé ou non, son type sera 
            toujours 'coded value' (xsi:type='CD'). 
            Dans le cas de l'utilisation d'un code, les attributs  'code' et 'codeSystem'seront présents, 
            et dans le cas contraire, tout autre attribut que xsi:type='CD' seront absents.
            Si présents, le codeSystem sera égal à '2.16.840.1.113883.5.1063' et le code à 'H|M|L'
        </assert>-->
        <assert test='(cda:value[@xsi:type="CD"]) and 
            (cda:value[@codeSystem="2.16.840.1.113883.5.1063"] or cda:value[not(@code) and not(@codeSystem)])'>
            [ER_severity_int] Erreur de Conformité PCC: Alors que l'élément 'value' peut être un caractère codé ou non, son type sera 
            toujours 'coded value' (xsi:type='CD'). 
            Dans le cas de l'utilisation d'un code, les attributs  'code' et 'codeSystem'seront présents, 
            et dans le cas contraire, tout autre attribut que xsi:type='CD' seront absents.
            Si présents, le codeSystem sera égal à '2.16.840.1.113883.5.1063' et le code à 'H|M|L'
        </assert>
    </rule>
</pattern>
