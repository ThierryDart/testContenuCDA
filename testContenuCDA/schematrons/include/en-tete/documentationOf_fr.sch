<?xml version="1.0" encoding="UTF-8"?>
<!-- 
   documentationOf.sch :
    Contenu : Vérifie la confomrité de l'élément documentationOf contenu dans l'entête en fonction du volet de strucutration minimale
    Paramètres d'appel : néant
    Historique :
        15/06/2017 : LBE : Création 
        30/01/2018 : NMA : Mise à jour du test sur le performer car il n'est pas obligatoire
-->
<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="documentationOf_fr">
   
    <rule context="cda:documentationOf">
        <assert test="cda:serviceEvent"> 
            [documentationOf_fr] Erreur de conformité CI-SIS : L'élément serviceEvent doit être présent
        </assert>
      
    </rule>
    <rule context="cda:documentationOf/cda:serviceEvent">
       
        <assert test="not(cda:code) or(cda:code and cda:code[@code] and cda:code[@codeSystem] and cda:code[@displayName])">
            [documentationOf_fr] Erreur de conformité CI-SIS : L'élément code doit contenir les attributs @code, @codeSystem et @displayName lorsqu'il est présent
        </assert>
        
        <assert test="cda:performer[@typeCode='PRF'] or not(cda:performer)">
            [documentationOf_fr] Erreur de conformité CI-SIS : L'élément serviceEvent/performer, si présent, doit comporter l'attribut @typeCode fixé à "PRF"
        </assert>
        
        <assert test="count(cda:performer) &lt; 2">
            [documentationOf_fr] Erreur de conformité CI-SIS : l'en-tête CDA doit comporter au maximum un seul documentationOf/serviceEvent 
            avec un élément fils performer. </assert>
        
    </rule>
    <rule context="cda:documentationOf/cda:serviceEvent/cda:effectiveTime">
        <assert test="cda:low and not(@nullFlavor)">
            [documentationOf_fr] Erreur de conformité CI-SIS : L'élément effectiveTime du serviceEvent, si présent, ne peut être en nullFlavor et comporte obligatoirement un élément low
        </assert>
    </rule>
    
    <rule context="cda:ClinicalDocument/cda:documentationOf/cda:serviceEvent/cda:performer">
        
        <assert
            test="not(@nullFlavor)">
            [documentationOf_fr] Erreur de conformité CI-SIS : L'élément documentationOf/serviceEvent/performer doit être renseigné sans nullFlavor. </assert>
        
        <assert test="cda:assignedEntity/cda:representedOrganization/cda:standardIndustryClassCode">
            [documentationOf_fr] Erreur de conformité CI-SIS : L'élément documentationOf/serviceEvent/performer correspondant à l'acte principal documenté, 
            doit comporter un descendant assignedEntity/representedOrganization/standardIndustryClassCode. </assert>
        
    </rule>
    
</pattern>