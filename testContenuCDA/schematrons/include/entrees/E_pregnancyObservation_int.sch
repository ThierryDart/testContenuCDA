<?xml version="1.0" encoding="UTF-8"?>

<!--                  -=<<o#%@O[ E_pregnancyObservation_int.sch ]O@%#o>>=-
    
    Teste la conformité de la section " IHE PCC Pregnancy Observation" (1.3.6.1.4.1.19376.1.5.3.1.4.13.5)
    aux spécifications d'IHE PCC v3.0
    
    Historique :
    21/08/13 : CRI : Création
    26/06/17 : NMA : Ajout de contraite sur les templateIds, sur le code et sur la value
    
    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_pregnancyObservation_int">
   <title>IHE PCC Pregnancy Observation" (1.3.6.1.4.1.19376.1.5.3.1.4.13.5)</title>
   <rule context="*[cda:templateId/@root=&quot;1.3.6.1.4.1.19376.1.5.3.1.4.13.5&quot;]">
      <let name="count_templateId" value="count(cda:templateId)"/>
      
      <assert test="$count_templateId=2">
         [E_pregnancyObservation_int] Erreur de conformité PCC : Dans l'élément "pregnancy Observation", il doit y avoir deux templateId
      </assert>
      
    <assert test='cda:templateId[@root="1.3.6.1.4.1.19376.1.5.3.1.4.13"]'>
       [E_pregnancyObservation_int] Erreur de conformité PCC : Le templateId parent (1.3.6.1.4.1.19376.1.5.3.1.4.13) doit être présent.
    </assert>
      
      <assert test='cda:code'>
         [E_pregnancyObservation_int] Erreur de conformité PCC : Un élément "Pregnancy Observation" comporte obligatoirement un élément "code".</assert>

      <report test='cda:repeatNumber'>
         [E_pregnancyObservation_int] Erreur de conformité PCC : L'élément &lt;repeatNumber&gt; devrait être absent.
      </report>
      
      <assert test='cda:value'>
         [E_pregnancyObservation_int] Erreur de conformité PCC : Un élément "Pregnancy Observation" comporte obligatoirement un élément "value".</assert>

      <report test='cda:interpretationCode or cda:methodCode or cda:targetSiteCode'>
         [E_pregnancyObservation_int] Erreur de conformité PCC : Les éléments &lt;interpretationCode&gt;, 
         &lt;methodCode&gt;, and &lt;targetSiteCode&gt; devraient être absents.
      </report>
    </rule>


  </pattern>
