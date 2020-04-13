<?xml version="1.0" encoding="UTF-8"?>

<!--                  -=<<o#%@O[ ER_healthStatusObservation_int.sch ]O@%#o>>=-
    
    Teste la conformité de la section " IHE PCC health Status Observation" (1.3.6.1.4.1.19376.1.5.3.1.4.1.2)
    aux spécifications d'IHE PCC v3.0
    
    Historique :
    09/08/16 : NMA : Création
    22/06/17 : NMA : Ajout des contraintes internationales 
    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="ER_healthStatusObservation_int">
    <title>IHE PCC health Status Observation</title>
    <rule context="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.1.2']">
        <let name="count_templateId" value="count(cda:templateId)"/>
        
        <assert test='../../cda:entryRelationship[@typeCode="REFR"]'>
            [ER_healthStatusObservation_int]Erreur de Conformité PCC: Une entrée 'health Status Observation' est représentée comme une élément de type 'observation' 
            avec un attribut typeCode='REFR'.</assert>
        
        <assert
            test="self::cda:observation[@classCode='OBS' and @moodCode='EVN']">
            [ER_healthStatusObservation_int] Erreur de conformité PCC : Dans l'élément "health Status Observation", le format de base utilisé pour 
            représenter un problème utilise l'élément CDA 'observation' d'attribut classCode='OBS' pour
            signifier qu'il s'agit l'observation d'un problème, et moodCode='EVN', pour exprimer 
            que l'événement a déjà eu lieu. </assert>
        
        <assert test='cda:templateId[@root="2.16.840.1.113883.10.20.1.51"]'>
            [ER_healthStatusObservation_int] Erreur de conformité PCC : Le templateId parent (2.16.840.1.113883.10.20.1.51) doit être présent.
        </assert>
        
        <assert test="$count_templateId=2">
            [ER_healthStatusObservation_int] Erreur de conformité PCC : Dans l'élément "health Status Observation", il doit y avoir deux templateId
        </assert>
        
        
        <assert test='cda:code[@code="11323-3" and @codeSystem="2.16.840.1.113883.6.1"]'>
            [ER_healthStatusObservation_int] Erreur de Conformité PCC: L'élément 'code' de l'entrée "health Status Observation" indique la 
            sévérité de l'allergie provoquée.
            L'élément 'code' doit obligatoirement comporter les attributs 'code' et 'codeSystem'.</assert>
        
        <assert test="cda:text/cda:reference[@value]">
            [ER_healthStatusObservation_int] Erreur de conformité PCC : L'élément text doit être présent avec un élément reference qui contient une URI dans l'attribut @value
        </assert>
        
        <assert test="cda:statusCode[@code='completed']"> 
            [ER_healthStatusObservation_int] Erreur de conformité PCC : Le composant "statutCode" d'un élément "health Status Observation" sera toujours fixé à la valeur code='completed'. </assert>
        
        <assert test='cda:value[@xsi:type="CE"]'>
            [ER_healthStatusObservation_int] Erreur de conformité PCC : Pour tout élément de type 'health Status', l'élément 'value' signale le statut clinique.
            Il est toujours représenté utilisant le datatype 'CE' (xsi:type='CE') 
        </assert>
        
    </rule>
    
    
</pattern>
