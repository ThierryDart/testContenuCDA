<?xml version="1.0" encoding="UTF-8"?>

<!--                  -=<<o#%@O[ E_pregnancyHistoryOrganizer_int.sch ]O@%#o>>=-
    
    Teste la conformité de l'entrée  "Pregnancy History Organizer" (1.3.6.1.4.1.19376.1.5.3.1.4.13.5.1)
    aux spécifications d'IHE PCC v3.0
    
    Historique :
    23/06/17 : NMA : Création E_pregnancyHistoryOrganizer_int.sch
    12/10/17 : Correction de l'assert sur la présence du sequenceNumber
    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_pregnancyHistoryOrganizer_int">
    <title>IHE PCC v3.0 Pregnancy History Organizer</title>
    
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.4.13.5.1"]'>
        
        <assert test='self::cda:organizer[@classCode="CLUSTER" and @moodCode="EVN"]'>
            [E_pregnancyHistoryOrganizer_int] Erreur de conformité PCC : Une entrée "Pregnancy History Organizer" est un cluster d'entrées Pregnancy Observations.
            Les attributs classCode et moodCode doivent obligatoirement être respectivement égaux à "CLUSTER" et "EVN"
        </assert>
        
        <assert test='cda:id'>
            [E_pregnancyHistoryOrganizer_int] Erreur de conformité PCC : Un élément "Pregnancy History Organizer" doit comporter un identifiant "id".
        </assert>
       
        <assert test='cda:code'>
            [E_pregnancyHistoryOrganizer_int] Erreur de conformité PCC : Un élément "Pregnancy History Organizer" doit comporter un code "code" .
        </assert>
        
        <assert test="cda:statusCode[@code='completed']"> 
            [E_pregnancyHistoryOrganizer_int] Erreur de conformité PCC : Un élément "Pregnancy History Organizer" décrit l'observation d'un fait clinique. 
            Son composant "statutCode" sera donc toujours fixé à la valeur code='completed'. </assert>
        <let name="count_statusCode" value="count(cda:statusCode)"/>
        
        <assert test="$count_statusCode=1">
            [E_pregnancyHistoryOrganizer_int] Erreur de conformité PCC : Dans l'élément "Pregnancy History Organizer", il doit y avoir un seul élément statusCode
        </assert>
        
        <assert test='cda:effectiveTime'>
            [E_pregnancyHistoryOrganizer_int] Erreur de conformité PCC : Un élément "Pregnancy History Organizer" doit comporter un élément "effectiveTime" .
        </assert>
        
        <assert test='cda:author'>
            [E_pregnancyHistoryOrganizer_int] Erreur de conformité PCC : Un élément "Pregnancy History Organizer" doit comporter un élément "auteur" pour représenter la personne ou le dispositif
        </assert>
        
        <assert test='cda:component'>
            [E_pregnancyHistoryOrganizer_int] Erreur de conformité PCC : Un élément "Pregnancy History Organizer" doit comporter au moins un élément "component" pour représenter la personne ou le dispositif
        </assert>
       
        <assert test='not(cda:component//cda:templateId[@root="1.3.6.1.4.1.19376.1.5.3.1.4.13.5.2"]) or (cda:component//cda:templateId[@root="1.3.6.1.4.1.19376.1.5.3.1.4.13.5.2"] and cda:component/cda:sequenceNumber)'>
            [E_pregnancyHistoryOrganizer_int] Erreur de conformité PCC : Si un component contient un organizer dont le templateId est: 1.3.6.1.4.1.19376.1.5.3.1.4.13.5.2, il devrait contenir aussi un élément "sequenceNumber"
        </assert>


    </rule>
</pattern>