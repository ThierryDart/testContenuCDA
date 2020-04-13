<?xml version="1.0" encoding="UTF-8"?>

<!--                  
    Entete_FLUDR_FLUDT.sch
    Teste la conformité de l'entete du volet DLU (FLUDR/FLUDT) au CI-SIS
    
    Historique :
    07/02/2018 :  NMA : Création
    
-->


<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="Entete_FLUDR_FLUDT">
    
    <rule context='cda:ClinicalDocument'>
        
        <assert test="cda:code[@code='34133-9']">
            [Entete_FLUDR_FLUDT] Le code du document DLU doit être égal à '34133-9'
        </assert>
        
        <assert test="cda:recordTarget/cda:patientRole/cda:patient/cda:birthTime">
            [Entete_FLUDR_FLUDT] La date de naissance du patient est obligatoirement présente
        </assert>
        
        <assert test="not(cda:informant) or cda:informant/cda:relatedEntity[@classCode='CON']/cda:code">
            [Entete_FLUDR_FLUDT] L’attribut classcode de l’élément relatedEntity est fixé à ‘CON’ et l’attribut code de l’élément informant/relatedEntity/code permet de définir le lien de la personne avec le patient.
        </assert>
        
        <assert test="cda:documentationOf/cda:serviceEvent/cda:code[@code='28651-8']">
            [Entete_FLUDR_FLUDT] L’attribut code de l’élément documentationOf/serviceEvent/code prend la valeur '28651-8'
        </assert>
        
        <assert test="cda:documentationOf/cda:serviceEvent/cda:effectiveTime">
            [Entete_FLUDR_FLUDT] Dans le contexte du DLU, la date du début d'exécution de l'acte est obligatoire
        </assert>
        
        <report test="cda:documentationOf/cda:serviceEvent/cda:effectiveTime[@nullFlavor] or cda:documentationOf/cda:serviceEvent/cda:effectiveTime/cda:low[@nullFlavor]">
            [Entete_FLUDR_FLUDT] Dans le contexte du DLU, l'utilisation du nullFlavor pour la date du début d'exécution de l'acte est interdite
        </report>
        
    </rule>
</pattern>