<?xml version="1.0" encoding="UTF-8"?>

<!--                  -=<<o#%@O[ E_encounters_int.sch ]O@%#o>>=-
    
    Teste les entrées de l'entrée PCC Encounters (1.3.6.1.4.1.19376.1.5.3.1.4.14)
    
    25/07/11 : CRI : Création
	12/12/16 : LBE : Suppression de la condition incohérente suivante : ' test="@moodCode='ARQ' and (cda:effectiveTime or cda:priorityCode"'
    17/01/17 : LBE : Ajout de la conformité du participant
    01/03/17 : NMA : Correction du test sur le participant
    20/07/2017 : LBE : Mise en conformité avec les nouvelles spécifications (ajout compte templateId,..)
    05/10/17 : NMA : Correction du compte des templateIds
    30/11/17 : NMA : Correction des tests sur le moodCode en remplaçant les or par des and
-->



<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_encounters_int">


    <title>IHE PCC v3.0 Encounters - errors validation phase</title>
    <rule context="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.4.14']">
        
        <let name="count_templateId" value="count(cda:templateId)"/>

        <assert test="@classCode='ENC'"> 
            [E_encounters_int] : Erreur de Conformité PCC: Dans une entrée "Encounters", l'attribut "classCode" sera fixé à la valeur "ENC". </assert>

        <assert test="(not(@moodCode='EVN') and cda:templateId[@root='2.16.840.1.113883.10.20.1.25']) or (@moodCode='EVN' and cda:templateId[@root='2.16.840.1.113883.10.20.1.21'])"> 
            [E_encounters_int] : Erreur de Conformité PCC: Dans une entrée "Encounters", le templateId indique que cet élément 
            se conforme aux contraintes de ce module de contenu.
            NOTE: Lorsque l'entrée "Encounters",est en mode événement, (moodCode='EVN'), cette entrée 
            se conforme au template CCD 2.16.840.1.113883.10.20.1.21, et dans les autres modes, 
            elle se conformera au template CCD 2.16.840.1.113883.10.20.1.25. </assert>
        
        <assert test="$count_templateId&gt;1">
            [E_encounters_int] : Erreur de conformité PCC : Dans l'élément "Encounter", il doit y avoir deux templateId
        </assert>
        
        <assert test="cda:id"> 
            [E_encounters_int] : Erreur de Conformité PCC: Dans une entrée "Encounters", l'élément "id" est obligatoire. </assert>
        
          <!-- 
        <assert test="cda:code[@codeSystem='2.16.840.1.113883.5.4']"> 
        Error: In
            Encounters, code is a required element and shall contain a code from the HL7
            ActEncounterCode vocabulary describing the type of encounter (e.g., inpatient,
            ambulatory, emergency, et cetera). </assert>
          -->
        
        <assert test="cda:text/cda:reference"> 
            [E_encounters_int] : Erreur de Conformité PCC: Dans une entrée "Encounters", l'élément "text" contiendra
            une référence à la partie narrative décrivant l'événement. </assert>
        
        <assert test="not(@moodCode = 'EVN' or @moodCode = 'APT') or cda:effectiveTime"> 
            [E_encounters_int] : Erreur de Conformité PCC: Dans une entrée "Encounters", l'élément "effectiveTime" 
            horodate l'événement (en mode EVN), ou la date désirée pour la rencontre, en mode ARQ or APT.
            En mode EVN ou APT, l'élément "effectiveTime" sera présent. En mode ARQ, l'élément "effectiveTime" 
            pourra être présent, et dans le cas contraire, l'élément "priorityCode" sera présent, 
            pour indiquer qu'un rappel est nécessaire pour fixer la date de rendez-vous pour la rencontre. </assert>
        
        <assert test="not(cda:participant[@typeCode='LOC']) or 
                cda:participant[@typeCode='LOC']/cda:participantRole[@classCode='SDLOC']"> 
            [E_encounters_int] : Erreur de Conformité PCC: Dans une entrée "Encounters", un élément "participant" avec un attribut "typeCode" 
            LOC pourra être présent pour donner l'indication sur le lieu où la rencontre doit ou s'est tenue. 
            Cet élément aura un élément "participantRole" d'attribut classCode='SDLOC' décrivant la localisation du service. </assert>
        
        <assert test="not(cda:particpant[@typeCode='LOC']) or
                cda:participant[@typeCode='LOC']/cda:playingEntity[@classCode='PLC']/cda:name"> 
            [E_encounters_int] : Erreur de Conformité PCC: Dans une entrée "Encounters", un élément "participant" d'attribut "typeCode='LOC'" 
            désignera un élément "playingEntity" avec son nom. </assert>
        

    </rule>
</pattern>
