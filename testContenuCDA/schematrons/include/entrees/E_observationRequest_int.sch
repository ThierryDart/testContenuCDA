<?xml version="1.0" encoding="UTF-8"?>

<!--                  -=<<o#%@O[ E_ObservationRequest_int.sch ]O@%#o>>=-
    
    Teste la conformité de l'entrée "Observation Request Entry" (1.3.6.1.4.1.19376.1.5.3.1.1.20.3.1)
    aux spécifications d'IHE PCC v3.0
    
    Historique :
    06/01/16 : HGH : Création
    23/06/17 : NMA : Ajout de contraintes sur le nombre de templateId
   
-->


<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_ObservationRequest_int">
    
    <title>IHE PCC v3.0 Observation Request</title>
    <rule context="*[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.1.20.3.1']">
        <let name="count_templateId" value="count(cda:templateId)"/>
        <assert test="@classCode='OBS'"> 
            [E_ObservationRequest_int] : Erreur de Conformité PCC: 
            Dans une entrée "Observation Request", l'attribut "classCode" sera fixé à la valeur "OBS". </assert>
        
        <assert test="@moodCode = 'INT' or @moodCode = 'PRP' or @moodCode = 'GOL'"> 
            [E_ObservationRequest_int] : Erreur de Conformité PCC: 
            Dans une entrée "Observation Request", l'élément "moodCode" 
            sera fixé à la valeur "INT" s'il s'agit d'une observation qui fait partie d'un plan de soins à accomplir,
            et il sera fixé à la valeur "PRP" quand l'observation est une proposition faite sur la base d'éléments
            cliniques.
            Dans le cas où l'observation est le but du plan de soins, l'élément "moodCode" sera fixé à la valeur "GOL".
        </assert>
        
        <assert test='cda:templateId[@root="2.16.840.1.113883.10.20.1.25"]'>
            [E_ObservationRequest_int] : Erreur de Conformité PCC: Cette entrée se conforme au template 2.16.840.1.113883.10.20.1.25 </assert>
        
        <assert test="$count_templateId=2">
            [E_ObservationRequest_int] Erreur de conformité PCC : Il doit y avoir deux templateId
        </assert>
        
        <assert test="cda:id"> 
            [E_ObservationRequest_int] : Erreur de Conformité PCC: 
            Dans une entrée "Observation Request", l'élément "id" est obligatoire. </assert>
        
        <assert test="cda:code"> 
            [E_ObservationRequest_int] : Erreur de Conformité PCC: 
            Dans une entrée "Observation Request", l'élément "code" est obligatoire. </assert>
        
        <assert test="cda:text/cda:reference[@value]"> 
            [E_ObservationRequest_int] : Erreur de Conformité PCC: 
            Dans une entrée "Observation Request", l'élément "text" contiendra
            une référence à la partie narrative décrivant les circonstances du transfert via l'attribut value. </assert>
        
        <assert test='cda:statusCode[@code="active"] or 
            cda:statusCode[@code="suspended"] or
            cda:statusCode[@code="aborted"] or
            cda:statusCode[@code="completed"] or
            cda:statusCode[@code="cancelled"] or
            cda:statusCode[@code="normal"] or
            cda:statusCode[@code="new"] or
            cda:statusCode[@code="held"]'>
            [E_ObservationRequest_int] :  L'élément "statusCode" associé à tout élément "observation request" doit prendre l'une des valeurs suivantes: 
            "active", "suspended", "aborted" ou "completed" ou "cancelled" ou "normal" ou "new" ou "held".</assert>
        
        <assert test="cda:effectiveTime" > 
            [E_ObservationRequest_int] : Erreur de Conformité PCC: 
            Dans une entrée "Observation Request", l'élément "effectiveTime" est obligatoire. </assert>
        
    </rule>
    
</pattern>

