<?xml version="1.0" encoding="UTF-8"?>

<!--                  -=<<o#%@O[ E_medications_fr.sch ]O@%#o>>=-
    
    Teste la conformité d'une entrée utilisée dans le volet du CI-SIS aux spécifications de l'entrée 
    PCC medication (1.3.6.1.4.1.19376.1.5.3.1.4.7)  
    
    
    Historique :
    06/07/17 : NMA : Création
    28/07/17 : LBE : Ajout des contraintes sur les nullFlavor
    05/10/17 : NMA : Suppression du test sur le numéro de lot
    09/10/19 : NMA : Mise à jour du test sur la doseQuantity
    
-->

<pattern xmlns="http://purl.oclc.org/dsdl/schematron" id="E_medications_fr">
    <title>CI-SIS Medications</title>
       
    <rule context='*[cda:templateId/@root="1.3.6.1.4.1.19376.1.5.3.1.4.7"]'>
        
        <assert test="count(cda:templateId)&gt;2">
            [E_medications_fr] Erreur de conformité CI-SIS : L'entrée "Medications" doit contenir trois éléments "templateId"            
        </assert>
        
        <assert test="count(cda:effectiveTime)=2">
            [E_medications_fr] Erreur de conformité CI-SIS : Deux effectiveTime doivent être présents, le premier pour préciser la durée de prescription, le second pour la fréquence d'administration
        </assert>
        
        <assert test="(count(cda:doseQuantity/cda:low)=1 and count(cda:doseQuantity/cda:high)=1) or cda:doseQuantity/@nullFlavor or not(cda:doseQuantity)">
            [E_medications_fr] Erreur de conformité CI-SIS : L'élément doseQuantity n'est pas obligatoire mais s'il est présent, ces éléments low et high sont obligatoires et ne doivent être présents qu'une seule fois (cardinalité [1..1]).
            L'élément doseQuantity peut aussi prendre la valeur nullFlavor
        </assert>
        
        <assert test="not(cda:rateQuantity) or cda:rateQuantity/@nullFlavor or (count(cda:rateQuantity/cda:low)=1 and count(cda:rateQuantity/cda:high)=1)">
            [E_medications_fr] Erreur de conformité CI-SIS : Les éléments low et high du rythme d'administration (rateQuantity) sont obligatoires et ne doivent être présents qu'une seule fois (cardinalité [1..1])
        </assert>
        
        <assert test="count(cda:maxDoseQuantity)&lt;2 ">
            [E_medications_fr] Erreur de conformité CI-SIS : Si présent, l'élément "maxDoseQuantity" ne peut être présent plus d'une fois
        </assert>
        
        <assert test='cda:consumable/cda:manufacturedProduct/cda:templateId[@root="1.3.6.1.4.1.19376.1.5.3.1.4.7.2"]'>
            [E_medications_fr] Erreur de conformité CI-SIS : L'élément 'consumable' doit obligatoirement être présent dans une entrée 'Medications'.
            Il comportera un élément 'manufacturedProduct' se conformant au template 'Product Entry' (1.3.6.1.4.1.19376.1.5.3.1.4.7.2).</assert>
        
        <assert test='count(cda:consumable/cda:manufacturedProduct/cda:templateId)=2'>
            [E_medications_fr] Erreur de conformité CI-SIS : L'élément manufacturedProduct contient deux templateId
            (1.3.6.1.4.1.19376.1.5.3.1.4.7.2) et (2.16.840.1.113883.10.20.1.53)
        </assert>
        
        <assert test='count(cda:consumable/cda:manufacturedProduct/cda:manufacturedMaterial/cda:code/cda:originalText/cda:reference)=1 or cda:consumable/cda:manufacturedProduct/cda:manufacturedMaterial/cda:code/@nullFlavor'>
            [E_medications_fr] Erreur de conformité CI-SIS : L'entrée Product entry doit contenir un médicament administré (manufacturedMAterial) avec sa codification CIS-Spécialité
            et une description narrative via une référence à l'élément narratif de la section
        </assert>

        <assert test="not(cda:entryRelationship)
            or cda:entryRelationship[@typeCode='RSON']/cda:act/cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.4.1']
            or cda:entryRelationship[@typeCode='SUBJ']/cda:act/cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.3'] 
            or cda:entryRelationship[@typeCode='REFR']/cda:supply/cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.7.3']
            or cda:entryRelationship[@typeCode='COMP']/cda:supply/cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.7']
            or cda:entryRelationship[@typeCode='COMP']/cda:observation/cda:templateId[@root='1.3.6.1.4.1.19376.1.5.3.1.4.13']">
             [E_medications_fr] Erreur de conformité CI-SIS : Les éléments entryRelationship ne sont pas obligatoires, mais si présentes, elle sont spécifiées ainsi:
             - Raison de l'administration : avec un typeCode='RSON' et une entrée (1.3.6.1.4.1.19376.1.5.3.1.4.4.1)
             - Instructions au patient : avec un typeCode='SUBJ'  et une entrée (1.3.6.1.4.1.19376.1.5.3.1.4.3)
             - Référence de la prescription : avec un typeCode 'REFR' et une entrée sypply (1.3.6.1.4.1.19376.1.5.3.1.4.7.3)
             - Instructions au patient : avec un typeCode='COMP' et une entrée (1.3.6.1.4.1.19376.1.5.3.1.4.7)
             - Simple Observation : avec un typeCode='COMP' et une entrée (1.3.6.1.4.1.19376.1.5.3.1.4.13)
             
        </assert>
    </rule>
</pattern>